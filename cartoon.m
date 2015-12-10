function [ out ] = cartoon( I, smoothness, detail, bitdepth, thickness, morph, morph_len, morph_ang, dither  )
%cartoon will apply a carton type effect on the input image. It has
%functionality for addition effects too.

% Initialize
[n,m,dim] = size(I);
sharpness = 1.5;    % criteria for gradient (1.01 to 2)
max_beta = 10000; % FACTOR IN DETAIL
minArea = 1000 - detail;

% Gradient minimization (bilateral filter kinda)
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
    % Smooth high frequency details and color
    h = [diff(S,1,2), S(:,1,:) - S(:,end,:)];
    v = [diff(S,1,1); S(1,:,:) - S(end,:,:)];
    t = sum((h.^2+v.^2),3)<smoothness/beta;
    t = repmat(t,[1,1,dim]);
    h(t)=0; v(t)=0;
    
    % Retain Edges
    curr_denoise   = 1 + beta*denoise;
    curr_min = [h(:,end,:) - h(:, 1,:), - diff(h,1,2)];
    curr_min = curr_min + [v(end,:,:) - v(1, :,:); - diff(v,1,1)];
    FS = (I_fft + beta*fft2(curr_min))./curr_denoise;
    S = real(ifft2(FS));
    beta = beta*sharpness;
end


% Emphasize Edges
scale = n/1000; % used to work with different sizes
E = edge(rgb2gray(I), 'Sobel');
BW = bwareaopen(E , round(minArea * scale)); % remove white noise < minArea

% Morphalogical Functions

if morph
    se = strel('disk',round(thickness * scale));  
    erode = double(imerode(~BW, se));
    se2 = strel('line',round(morph_len* scale), morph_ang);
    morphed = imdilate(erode,se2);
else
    morphed = 1;
end
for i = 1:3
    S(:, :, i) = S(:, :, i).*morphed; % apply weight
end

% Quantize color
if dither
    [S,map]= rgb2ind(S,bitdepth,'dither');
else
    [S,map]= rgb2ind(S,bitdepth,'nodither');
end
out = ind2rgb(S, map);

end

