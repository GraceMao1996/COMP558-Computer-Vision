I = imread('james.jpg');
I_Green = I(:,:,2);
deltaT = 0.25;%change into 0.25,0.5,0.75,1



for sigma = (4:4:16)
    I_filtered = uint8(imgaussfilt(I_Green,sigma));
    I_filtered2 = I_Green;
    for t=(1:deltaT:sigma*sigma/2)
        [Gx,Gy] = gradient(double(I_filtered2));
        [Gxx,Gxy] = gradient(Gx);
        [Gyx,Gyy] = gradient(Gy);
        I_filtered2 = double(I_filtered2) + deltaT*(Gxx + Gyy);
    end
    I_filtered2 = uint8(I_filtered2);
     figure,imshow(I_filtered);
     figure,imshow(I_filtered2);
    Id = I_filtered - I_filtered2;
    disp(sum(Id(:)));
end

