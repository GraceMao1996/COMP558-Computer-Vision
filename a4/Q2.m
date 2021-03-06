close all
readPositions  %  reads given positions of XYZ and xy1 and xy2 for two images

numPositions = size(XYZ,1);

close all


Iname = 'c1.jpg';
xy = xy1;
[P, K, R, C] = calibrate(XYZ, xy);  

%change K, keep R,C(shift)
%  Display image with keypoints

I = imread(Iname);
NX = size(I,2);
NY = size(I,1);
imageInfo = imfinfo(Iname);
figure;
imshow(I);
title(Iname);
hold on

%  Draw in green the keypoints locations that were hand selected.

for j = 1:numPositions
    plot(xy(j,1),xy(j,2),'g*');
end


K_new = K;
K_new(1,3) = K_new(1,3) + 0.00001;
K_new(2,3) = K_new(2,3) + 0.00001;
P1 = K_new * R * [eye(3), -C];
for j = 1:numPositions
    p = P1*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
    x = p(1)/p(3);
    y = p(2)/p(3);
    %  Draw in white square the projected point positions according to the fit model.

    plot(ceil(x),ceil(y),'ws');
end
hold off;





% change C, keep R, K (shift)
I = imread(Iname);
NX = size(I,2);
NY = size(I,1);
imageInfo = imfinfo(Iname);
figure;
imshow(I);
title(Iname);
hold on

%  Draw in green the keypoints locations that were hand selected.

for j = 1:numPositions
    plot(xy(j,1),xy(j,2),'g*');
end



C_new = C+  [-7.9026;10.0238;7.3511];

P2 = K * R * [eye(3), -C_new];
for j = 1:numPositions
    p = P2*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
    x = p(1)/p(3);
    y = p(2)/p(3);
    %  Draw in white square the projected point positions according to the fit model.

    plot(ceil(x),ceil(y),'ws');
end

hold off;


% change R, keep C, K(shift)
I = imread(Iname);
NX = size(I,2);
NY = size(I,1);
imageInfo = imfinfo(Iname);
figure;
imshow(I);
title(Iname);
hold on

%  Draw in green the keypoints locations that were hand selected.

for j = 1:numPositions
    plot(xy(j,1),xy(j,2),'g*');
end

R_new = R +[0.003 0.003 0.003;
            0.003 0.003 0.003;
            0 0 0];
P3 = K*R_new*[eye(3), -C];
for j = 1:numPositions
    p = P3*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
    x = p(1)/p(3);
    y = p(2)/p(3);
    %  Draw in white square the projected point positions according to the fit model.

    plot(ceil(x),ceil(y),'ws');
end

hold off;


%change k, keep R,C (scale)



I = imread(Iname);
NX = size(I,2);
NY = size(I,1);
imageInfo = imfinfo(Iname);
figure;
imshow(I);
title(Iname);
hold on

%  Draw in green the keypoints locations that were hand selected.

for j = 1:numPositions
    plot(xy(j,1),xy(j,2),'g*');
end



K_new= K;
K_new(1,1) = K_new(1,1)*1.2;
K_new(2,2) = K_new(2,2)*1.2;

P4 = K_new * R * [eye(3), -C];
for j = 1:numPositions
    p = P4*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
    x = p(1)/p(3);
    y = p(2)/p(3);
    %  Draw in white square the projected point positions according to the fit model.

    plot(ceil(x),ceil(y),'ws');
end

hold off;


%change C,keep K,R(scale)
I = imread(Iname);
NX = size(I,2);
NY = size(I,1);
imageInfo = imfinfo(Iname);
figure;
imshow(I);
title(Iname);
hold on

%  Draw in green the keypoints locations that were hand selected.
for j = 1:numPositions
    plot(xy(j,1),xy(j,2),'g*');
end

C_new = C+ [-277;
 -122;
 -131];

P5 = K * R * [eye(3), -C_new];
for j = 1:numPositions
    p = P5*[ XYZ(j,1) XYZ(j,2) XYZ(j,3)  1]';
    x = p(1)/p(3);
    y = p(2)/p(3);
    %  Draw in white square the projected point positions according to the fit model.

    plot(ceil(x),ceil(y),'ws');
end

hold off;
