I = imread('james.jpg');
I_Green = I(:,:,2);
sigma = 0.25;  %change sigma to 0.5,1,2
g = fspecial('gaussian',3,sigma);   %gaussian filter

I_filtered = uint8(conv2(I_Green,g,'same'));   %the smoothed image
%figure,imshow(I_filtered);
%title('Ifiltered');


x_kernel = [-1/2 0 1/2];              %local difference kernel
y_kernel = [-1/2;0;1/2];
Ix = uint8(conv2(I_filtered,x_kernel,'same'));  %local difference of x
Iy = uint8(conv2(I_filtered,y_kernel,'same'));  %local difference of y
% figure,imshow(Ix);
% title('Ix');
% figure,imshow(Iy);
% title('Iy');

edge = [];

for i=(2:size(Ix,1)-1)
    for j =(2:size(Ix,2)-1)
        I_gradient(i,j) =double(Ix(i,j)^2+Iy(i,j)^2).^(1/2);  %the gradient magnitude
        orient(i,j) = atan(double(Iy(i,j)./Ix(i,j)));  %the gradient orientation = arctan(Iy/Ix)
           if I_gradient(i,j) >10    %threshold = 10
               I_gradient(i,j) = 1;
               edge = [edge; i j orient(i,j)];       %save the edge position and orientation
               
           else
               I_gradient(i,j) = 0;
           end
    end
end


max = zeros(1,4);
for t = (1:200)      %running T=200
    i = randi(size(edge,1));     %randomly sample an edge
    count = 0;
    xi = edge(i,2);      ss
    yi = edge(i,1);
    thetai = edge(i,3);
    for j = (1:size(edge,1))
        if j~=i
            xj = edge(j,2);
            yj = edge(j,1);
            thetaj = edge(j,3);
            d1 = abs((xj-xi)*cos(thetai) + (yj-yi)*sin(thetai));   %the distance of edge j to the line of edge i. 
            d2 = abs(thetai - thetaj);    %the difference between two orientations.

             if d1 <1 && d2 < 0.2          %j is an inlier
                count = count + 1;   
            end
        end
    end
    if count > max(1,4) 
        max(1,4) = count;   
        max(1,1) = yi;
        max(1,2) = xi;
        max(1,3) = thetai;
    end  
end

figure,imshow(I_gradient);
title('Igradient');
% disp(max);
figure;
hold on;
inlier_x = [];
inlier_y = [];
outlier_x = [];
outlier_y = [];
for j = (1:size(edge,1))
            xj = edge(j,2);
            yj = edge(j,1);
            thetaj = edge(j,3);
            d1 =abs((xj-max(1,2))*cos(max(1,3)) + (yj-max(1,1))*sin(max(1,3))); %the distance of edge j to the line of edge i. 
            d2 = abs(max(1,3)- thetaj);
            if d1 <1 && d2<0.2      %inliers of the best model
                inlier_x = [inlier_x xj];
                inlier_y = [inlier_y yj]
            else                    %outliers of the best model
                outlier_x = [outlier_x xj];
                outlier_y = [outlier_y yj];
            end    
end
% disp(inlier_x);
% disp(inlier_y);
plot(inlier_x,-inlier_y,'.','color','r');
plot(outlier_x,-outlier_y,'.','color',[0 0 0]);
hold off;

