

a = make2DGaussian(3,0.7);
I = imread('q3.png');

I_Gray = rgb2gray(I);
sigma = 0.25;  %change sigma to 0.5,1,2
log = mylog(3,sigma); %log filter

I_filtered = conv2(I_Gray,log,'same'); %filtered image


[nr,nc]=size(I_filtered);  %size of image
If=zeros([nr,nc]);  %initialize zero-crossing matrix

for x = (2:nr-1)       %compute zero-crossing matrix. Finding a point where neighbors on the opposite side of                       
    for y = (2:nc-1)   % a pixel have opposite signs of the filtered image
         if (I_filtered(x-1,y)>=0 && I_filtered(x+1,y)<0 || I_filtered(x-1,y)<0 && I_filtered(x+1,y)>=0)
              If(x,y) = 1;
         elseif (I_filtered(x,y-1)>=0 && I_filtered(x,y+1)<0 || I_filtered(x,y-1)<0 && I_filtered(x,y+1)>=0)
              If(x,y) = 1;
         elseif (I_filtered(x-1,y-1)>=0 && I_filtered(x+1,y+1)<0 || I_filtered(x-1,y-1)<0 && I_filtered(x+1,y+1)>=0)
              If(x,y) = 1;
         elseif (I_filtered(x-1,y+1)>=0 && I_filtered(x+1,y-1)<0 || I_filtered(x-1,y+1)<0 && I_filtered(x+1,y-1)>=0)
              If(x,y) = 1;
         end
    end
end

figure,imshow(If); 
