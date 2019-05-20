close all
readPositions  %  reads given positions of XYZ and xy1 and xy2 for two images

numPositions = size(XYZ,1);

close all
Iname = 'c1.jpg';
theta = 0/180*pi;%10,20
I1 = imread(Iname);
K1 = [50*size(I1,2)/23.6 0 0;
    0 50*size(I1,1)/15.8 0;
    0 0 1];

R2 = [1 0 0;0 cos(theta) sin(theta);0 -sin(theta) cos(theta)];
K2 = [25*size(I1,2)/2/23.6 0 178;
      0 25*size(I1,1)/2/15.8 268;
      0 0 1];
T= K2*R2*inv(K1);




I2 = zeros(size(I1,1)/2,size(I1,2)/2,3);
for x = 1:size(I1,1)
    for y = 1:size(I1,2)
        p_new = T*[x;y;1]; 
        p_new(1) = p_new(1)/p_new(3);
        p_new(2) = p_new(2)/p_new(3);
        if(p_new(1)<1) p_new(1)=1;
        elseif(p_new(1)>size(I2,1)) p_new(1) =size(I2,1);
        end
        
        if(p_new(2)<1) p_new(2)=1;
        elseif(p_new(2)>size(I2,2)) p_new(2) = size(I2,2);
        end
        
        I2(round(p_new(1)),round(p_new(2)),:)=I1(x,y,:);
        
    end
end

figure,imshow(uint8(I2));