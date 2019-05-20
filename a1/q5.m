I = imread('q2.jpg');
I = imresize(I,0.25);
I_Green = I(:,:,2);
sigma = 0.5;%change sigma to 1,2
g = fspecial('gaussian',3,sigma);
I_filtered = uint8(conv2(I_Green,g,'same'));


x_kernel = [-1/2 0 1/2];
y_kernel = [-1/2;0;1/2];  %gradient kernel
Ix = (conv2(I_filtered,x_kernel,'same'));  %local difference of x
%disp(Ix);
%Iy = uint8(conv2(I_filtered,y_kernel,'same'));  %local difference of y
nr = size(Ix,1);
nc = size(Ix,2);
counts = zeros(1,256);

for i = (1:nr)        %count the number of pixels whose local difference is x 
    for j = (1:nc)
        for x = (-127:128)
            if Ix(i,j)==x
                counts(x+128)=counts(x+128)+1;
            end
        end
    end
end
counts = counts/sum(counts);  %normalizing the frequencies by dividing by the number of pixels.
x = (-14:15);
y = (-127:128);            
figure,bar(y,log(counts));   %plot the log of the frequency distribution
xlabel('local difference with x');
ylabel('log of frequency');
figure,bar(x,counts(114:143));   %plot the nomalized frequency distribution histogram
hold on;
y = -14:0.1:15;
f = exp(-y.^2./(2*sigma^2))./(sigma*sqrt(2*pi));  %gaussian function
plot(y,f,'LineWidth',1.5)                         %overlap gaussian function on frequencies histogram.
legend('partial derivatives','gaussian');
hold off;
z = (-127:128);
f = exp(-z.^2./(2*sigma^2))./(sigma*sqrt(2*pi));  %log of the gaussian function
figure,plot(log(f),'LineWidth',1.5)