function [ out ] = cartoon( I, smoothness, detail, bitdepth, thickness, morph_len, morph_ang  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% RESIZE

% I = imread(in);
[n,m,dim] = size(I);
sharpness = 1.5;    % criteria for gradient (1.01 to 2)
max_beta = 10000; % FACTOR IN DETAIL
minArea = 1000 - detail;

%% Gradient minimization
% for i = 1:n
% smoothness = sm_constants(i);

% FFT Input Image
if dim==1        % make convert grayscale to RGB
    I = repmat(I,[1,1,3]);
end
S = im2double(I);
I_fft = fft2(S);

% Denoise Transfer Function Filter
Tx = psf2otf([1, -1],[n,m]); 
Ty = psf2otf([1; -1],[n,m]);
denoise = abs(Tx).^2 + abs(Ty).^2; % complex magnitude
denoise = repmat(denoise,[1,1,dim]);    % make RGB dimension

beta = 2*smoothness;
while beta < max_beta
    % h-v subproblem
    h = [diff(S,1,2), S(:,1,:) - S(:,end,:)];
    v = [diff(S,1,1); S(1,:,:) - S(end,:,:)];
    t = sum((h.^2+v.^2),3)<smoothness/beta;
    t = repmat(t,[1,1,dim]);
    h(t)=0; v(t)=0;
    
    % S subproblem
    curr_denoise   = 1 + beta*denoise;
    Normin2 = [h(:,end,:) - h(:, 1,:), -diff(h,1,2)];
    Normin2 = Normin2 + [v(end,:,:) - v(1, :,:); -diff(v,1,1)];
    FS = (I_fft + beta*fft2(Normin2))./curr_denoise;
    S = real(ifft2(FS));
    beta = beta*sharpness;
end
% figure; imshow(S); title('Smooth')

% Show result
% subplot(2,4,i+1); imshow(S); title(['Smoothing Coeff : ' num2str(sm_constants(i))])
% end

% high = highboost_filter(S, 5, 1);
% imshow(high)

%% Edge detection
scale = n/1000; % used to work with different sizes
E = edge(rgb2gray(I), 'Sobel');
BW = bwareaopen(E , round(minArea * scale)); % remove white noise < minArea
se = strel('disk',round(thickness * scale));        
erode = double(imerode(~BW, se));
se2 = strel('line',round(morph_len* scale), morph_ang);
dilate = imdilate(erode,se2);
% figure; imshow(dilate); title('Edge')

% [Gmag, Gdir] = imgradient(im2bw(I),'CentralDifference');
% Gmag = double(1-Gmag); imshow(Gmag);
% ed = Gmag + dilate;
% ed(ed < 1) = 0;

% Modify Colors
for i = 1:3
    S(:, :, i) = S(:, :, i).*dilate; % apply weight
end

% Quantize color
[S,map]= rgb2ind(S,bitdepth,'nodither');
out = ind2rgb(S, map);
% figure, imshow(S,map);


end

