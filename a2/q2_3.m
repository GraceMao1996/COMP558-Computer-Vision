clc;
sig = 1;
N = 10;
M=(N-1)/2;
k = 2;
[x,y] = meshgrid(-M:0.1:M,-M:0.1:M);
g = make2DGaussian(N,sig);
g2 = make2DGaussian(N,k*sig);
dog = g2-g;
figure,mesh(x,y,dog); %?????????
title('dog');

[Gx,Gy] = gradient(double(g));
[Gxx,Gxy] = gradient(Gx);
[Gyx,Gyy] = gradient(Gy);
log = Gxx + Gyy;
figure,mesh(x,y,log); %?????????
title('log');







