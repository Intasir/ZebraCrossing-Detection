image=imread('zebra8.jpg');
figure(1),
imshow(image);
image_main=imresize(image,[600 600]);
figure(2),
imshow(image_main);
image_gray=rgb2gray(image_main);
figure(3),
imshow(image_gray);
image_double=im2double(image_gray);
sigma=.3;
theta=90; 
lambda=60;
psi=0;
gamma=1;
gb=gabor(sigma,theta,lambda,psi,gamma);
image_conv=conv2(image_double,double(gb));
figure(4),
imshow(image_conv);
image_sobel=sobel(image_conv);
figure(5),
imshow(image_sobel);
t=mythres(image_sobel);
image_binary=im2bw(image_sobel,t);
figure(6),
imshow(image_binary);
image_binary=bwareaopen(image_binary,200);
figure(7),
imshow(image_binary);
image_inverse=~image_binary;
figure(8);
imshow(image_inverse);
[L,NUM]=bwlabel(image_inverse);
stats1=regionprops(image_inverse,'Area');
figure(9),
imshow(image_inverse);
idx3=find([stats1.Area]<1000);
image_area=ismember(L,idx3);
figure(10),
imshow(image_area);
image_new=image_inverse-image_area;
figure(11);
imshow(image_new);
[L,NUM]=bwlabel(image_new);
CC = bwconncomp(image_new);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
image_new=ismember(L,idx);
figure(12),
imshow(image_new);
image_new_binary=~image_new;
imshow(13),
imshow(image_new_binary);
[L,NUM]=bwlabel(image_new_binary);
stats2=regionprops(L,'Area');
idx2=find([stats2.Area]<6000);
image_area2=ismember(L,idx2);
image_area2=bwareaopen(image_area2,200);
figure(14);
imshow(image_area2);
[L,NUM]=bwlabel(image_area2);
stats3=regionprops(L,'Centroid');
stats4=regionprops(L,'BoundingBox');
centroids = cat(1, stats3.Centroid);
figure(15),
imshow(~image_area2);
hold on;
plot(centroids(:,1),centroids(:,2),'*r');
plot(x_intersect,y_intersect,'r*');
figure(16),
imshow(image_main);
for k = 1 :1:NUM
  thisBB = stats4(k).BoundingBox;
  rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
  'EdgeColor','g','LineWidth',2 )
end




