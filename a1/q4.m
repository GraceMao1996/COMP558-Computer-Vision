I = imread('q2.jpg');
I = imresize(I,0.1);   %resize the picture

I_Green = I(:,:,2);   %take the green channel
sigma = 0.25;  
g = fspecial('gaussian',3,sigma); %gaussian filter
I2 = conv2(I_Green,g,'same'); %filtered image

x_kernel = [-1/2 0 1/2];  %gradient kernel
y_kernel = [-1/2;0;1/2];
Ix = uint8(conv2(I2,x_kernel,'same'));  %local difference of x
Iy = uint8(conv2(I2,y_kernel,'same'));  %local difference of y

for i=(1:size(Ix,1))
    for j =(1:size(Ix,2))
        I_gradient(i,j) =double(Ix(i,j)^2+Iy(i,j)^2).^(1/2); 
        orient(i,j) = atan(double(Iy(i,j)./Ix(i,j)));
           if I_gradient(i,j) >6
               I_gradient(i,j) = 1;
           else
               I_gradient(i,j) = 0;   %the same method as q2.
           end
    end
end
I2_20 = I2(30:50,80:100);  %take 20*20 region of the picture
I_edge_20 = I_gradient(30:50,80:100); %take 20*20 region of the edge map

figure,imshow(I_edge_20);
figure,imagesc(uint8(I2_20));
hold on;

[x,y] = meshgrid(1:21,1:21);
I_gradient_20 = quiver(x,y,Ix(30:50,80:100),Iy(30:50,80:100));  %plot the gradient vector
hold off;
