close all


%% Inputs
I = imread('image/flower.jpg');
[n,m,dim] = size(I);
areaMag = numel(num2str(n*m));
sharpness = 2;    % criteria for gradient (1.01 to 2)
smoothness = .04; % higher is more blurr (0.001 to 0.1)
thickness = 1;  % edge thickness (0 to 20)
edge_thresh = 0.3;  % threshhold to keep edges (0-1)
minArea = 500;
max_beta = 100000;

% sm_constants = [.001 .005, .007, .01, .05, .07, .1];
% n = length(sm_constants);
% subplot(2,4,1); imshow(I); title('Original')

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
figure; imshow(S); title('Smooth')

% Show result
% subplot(2,4,i+1); imshow(S); title(['Smoothing Coeff : ' num2str(sm_constants(i))])
% end

%% Edge detection
E = edge(rgb2gray(I), 'Sobel');%, edge_thresh);
BW = bwareaopen(E , 100); % remove white noise < minArea
se = strel('disk',thickness);        
erode = double(imerode(~BW, se));
figure; imshow(erode); title('Edge')
hsv = rgb2hsv(S); 

    % Modify Colors
for i = 1:3
    S(:, :, i) = S(:, :, i).*erode; % apply weight
end
%     
% V = erode.*hsv(:, :, 3);
% hsv = [hsv(:,:,1), hsv(:,:,2), V];
% rgb = hsv2rgb(hsv);
figure; imshow(S); title('rgb');

% figure; imshow(hsv(:,:,3)); title('rgb');


