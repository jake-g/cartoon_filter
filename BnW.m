function BnW( I, detail, color, thickness, morph_len, morph_ang, inv, black ) 
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[n,m,dim] = size(I);
t1=graythresh(I);
BW=im2bw(I,t1);
minArea = 1000 - detail;

% Create background mask
if black == 0
HSV = double(cat(3, ones(2), ones(2), ones(2)));
HSV(:,:,1) = HSV(:,:,1)*color/255;
mask = hsv2rgb(HSV);
R = mask(1,1,1); G = mask(1,1,3); B = mask(1,1,3);

else
    R = 1; G = 1; B = 1;
end

% Morphological Function
scale = n/1000; % used to work with different sizes
BW = bwareaopen(BW , round(minArea * scale)); % remove white noise < minArea
se = strel('line',round(morph_len* scale), morph_ang);
if inv == 0      % invert if arg passed
    dilate = imdilate(BW,se);
else 
    dilate = imdilate(~BW,se);
end

BW = BW.*dilate;
RGB = double(cat(3, BW.*R, BW.*G, BW.*B));
imshow(RGB); hold on;

[Bo,~,N] = bwboundaries(BW);
for k=1:length(Bo),
    bound = Bo{k};
    if(k > N)
        plot(bound(:,2), bound(:,1),'k','LineWidth', thickness);
    end
end
    

end

