I = imread('images/girl.jpg');
n = 2;
t1=graythresh(I);
BW=im2bw(I,t1);
for i = 1:n*n
%     R = 0; G = 0.8; B = 0.7;
    R = rand(1,1); G = rand(1,1); B = rand(1,1);

    RGB = double(cat(3, BW.*R, BW.*G, BW.*B).*(i*n)/(n*n));
%     subplot(n,n,1); imshow(RGB); hold on;
    subplot(n,n,i); imshow(RGB); hold on;

    [Bo,L,N] = bwboundaries(BW);
    for k=1:length(Bo),
        bound = Bo{k};
        if(k > N)
            edge_x = bound(:,2); edge_y = bound(:,1);
            plot(bound(:,2), bound(:,1),'k','LineWidth',2);
        end
    end
end