




% %1.This segmentation of the background and foreground
% %2.stored the result in result.png file
% %thresholding method with level defined
im = imread("colorful rocks 2.jpg")
imagegray = rgb2gray(im) %Convert Colorful Image to Gray Scale
imagegray = im2double(imagegray) %Converting image pixels to float numbers
%Thresholding for gray image method 1
level = 0.7215;
bw1 = im2bw(imagegray,level)
bw1complement = imcomplement(bw1)
subplot(1,2,1), imshow(bw1complement)
title('Thresholding method 1');
%Thresholding method for gray image method 2
%threholding with red,blue and green planes
imR = im(:,:,1);
imG = im(:,:,2);
imB = im(:,:,3);
lr = 0.67;
lg = 0.56;
lb = 0.68;
bwRed = im2bw(imR, lr);
bwGreen = im2bw(imG, lg);
bwBlue = im2bw(imB, lb);
bwfinal2 = bwRed&bwGreen&bwBlue;
bw2complement = imcomplement(bwfinal2)
subplot(1,2,2), imshow(bw2complement)
title('Thresholding method 2');
saveas(gcf,'resultant.png')






% %3.Isolate the grey rocks
nrOfpixels = 800;
objs = bwareaopen(bw1complement,nrOfpixels);
imshowpair(bw1complement, objs, 'montage');
title('Isolated Gray Rocks')
labels = bwlabeln(objs);
nrOflabels = max(labels(:))
img = label2rgb(labels);
figure,imshow(img)
nrOflabels
saveas(gcf,'color_difference.png')



4A. For finding the area of the objects isolated, I used the inbuilt function that counts pixels. The ‘Area’ Label returns the scalar  of the number of pixels  in the region shown by the ‘labels’ 
% %4. Calculate the area of each rock
% %This gives area of all the objects bwarea(objs)
%inaf = bwlabel(objs);
%img = label2rgb(labels)
A = regionprops(labels,'Area');
areas = [A.Area];
areas;
%

5A. For finding the center point of each gray rock, I assumed that each rock binary pixels are a square. And found all the rows and columns associated with label1, label2,label3,label4. I then tried finding the upper left,upper right,lower left and lower right of each label. I then found their midpoints with my function findmidpoints and plotted the midpoints on the binarized/converted bw image. It can be used with grayimage too. Saved the result in center.png(red star)


% %5.Estimmate center of each gray rock and plot with red stars
%%5.Estimmate center of each gray rock and plot with red stars
[r1,c1] = find(labels == 1);
[r2,c2] = find(labels == 2);
[r3,c3] = find(labels == 3);
[r4,c4] = find(labels == 4);
[rx1,cx1] = findmidpoints(r1,c1)
[rx2,cx2] = findmidpoints(r2,c2)
[rx3,cx3] = findmidpoints(r3,c3)
[rx4,cx4] = findmidpoints(r4,c4)
imshow(bw1)
hold on
point1 = scatter(rx1,cx1,'red',’*’)
point2 = scatter(rx2,cx2,'red',’*’)
point3 = scatter(rx3,cx3,'red',’*’)
point4 = scatter(rx4,cx4,'red',’*’)
saveas(gcf,'centerpoints.png')
