function result = highboost_filter(img, n, c)
% highboost_filter is made up of an all pass filter and a edge
%   detection filter (laplacian filter). Essentially image sharpener.
%   Adjust c and w to change the filter parameters 
%       img = imread('4_2.bmp');  % input img
%       n = 5;  % window dimensions
%       c = 1;  % division constant for contrast (all pass filter

w = 0; % adjust to add weight to center
img = double(rgb2gray(img));

mask = ones(n) * -1;
mask(round(n/2), round(n/2)) = n*n+w;   % set weight at kernel center
mask = mask ./ c;                    % divide kernel by divisor constant
result = conv2(img, mask, 'same');  % convolve mask with img
result = uint8(result);             % cutoff outsize [0, 255]
end