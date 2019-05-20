a = make2DGaussian(3,0.7);
I = imread('q2.jpg');
I = imresize(I,0.25);
I_Green = I(:,:,2);  %take the green channel
sigma = 0.25;  %change sigma to 0.5,1,2
g = fspecial('gaussian',3,sigma);   %gaussian filter

I_filtered = uint8(conv2(I_Green,g,'same'));   %the smoothed image
figure,imshow(I_filtered);
%title('Ifiltered');


x_kernel = [-1/2 0 1/2];              %local difference kernel
y_kernel = [-1/2;0;1/2];
Ix = uint8(conv2(I_filtered,x_kernel,'same'));  %local difference of x
Iy = uint8(conv2(I_filtered,y_kernel,'same'));  %local difference of y
figure,imshow(Ix);
title('Ix');
figure,imshow(Iy);
title('Iy');

for i=(1:size(Ix,1))
    for j =(1:size(Ix,2))
        I_gradient(i,j) =double(Ix(i,j)^2+Iy(i,j)^2).^(1/2);  %the gradient magnitude
        orient(i,j) = atan(double(Iy(i,j)./Ix(i,j)));  %the gradient orientation = arctan(Iy/Ix)
           if I_gradient(i,j) >6      %threshold = 6
               I_gradient(i,j) = 1;
           else
               I_gradient(i,j) = 0;
           end
    end
end

figure,imshow(I_gradient);
title('Igradient');
disp(orient);
% figure,imshow(orient);