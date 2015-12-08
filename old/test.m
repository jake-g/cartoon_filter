I = imread('images/doom.jpg');
t1=graythresh(I);
k1=im2bw(I,t1);
k1=~k1;
se = strel('disk',1);
k0=imfill(~k1,'holes');            % new
cc = bwconncomp(k0);               % new
k0(cc.PixelIdxList{1})=0;          % new
k1 = imfill(k1,'holes');
cellMask = k1 | k0;                % new

k1=~k1;
bw = edge(k1,'canny',[],sqrt(2));

figure,imshow(~bw); title('original')