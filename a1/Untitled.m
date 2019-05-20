I = imread('james.jpg');

I_Green = I(:,:,2);
sigma = 4;%change sigma to 1,2
g = fspecial('gaussian',3,sigma);
I_filtered = uint8(conv2(I_Green,g,'same'));
I_filtered_2 = I_Green;
for t=(1:sigma*sigma/2)
    [Gx,Gy] = gradient(I_filtered2);
    [Gxx,Gxy] = gradient(Gx);
    [Gyx,Gyy] = gradient(Gy);
    I_filtered2 = I_filtered2 + Gxx + Gyy;
end


    