I = imread('james.jpg');
I_Green = I(:,:,2);
%I_Green = imrotate(I_Green, 5,'bicubic','crop'); %rotate the image
%I_Green = imresize(I_Green, 0.5); %scale the image;
%subpart 1

Ig_0 = uint8(imgaussfilt(I_Green,1));
figure,imshow(Ig_0);
Ig_1 = imresize(uint8(imgaussfilt(I_Green,2)),0.5);
figure,imshow(Ig_1);
Ig_2 = imresize(uint8(imgaussfilt(I_Green,4)),0.25);
figure,imshow(Ig_2);
Ig_3 = imresize(uint8(imgaussfilt(I_Green,8)),0.125);
figure,imshow(Ig_3);
Ig_4 = imresize(uint8(imgaussfilt(I_Green,16)),0.0625);
figure,imshow(Ig_4);
Ig_5 = imresize(uint8(imgaussfilt(I_Green,32)),0.03125);
figure,imshow(Ig_5);

%subpart 2
Il_0 = Ig_0 - imresize(Ig_1,2)+128;
figure,imshow(Il_0);
Il_1 = Ig_1 - imresize(Ig_2,2)+128;
figure,imshow(Il_1);
Il_2 = Ig_2 - imresize(Ig_3,2)+128;
figure,imshow(Il_2);
Il_3 = Ig_3 - imresize(Ig_4,2)+128;
figure,imshow(Il_3);
Il_4 = Ig_4 - imresize(Ig_5,2)+128;
figure,imshow(Il_4);

n = 0;
disp(size(Il_1,1));
 for i =(2:size(Il_1,1)-1)
     for j = (2:size(Il_1,2)-1)
         Ngd1 = [];
         for x = (i-1:i+1)
             for y = (j-1:j+1)
                 if x~=i  
                     Ngd1 = [Ngd1 Il_1(x,y)];
                 end
                 if y~=j
                    Ngd1 = [Ngd1 Il_1(x,y)];
                 end
             end
         end
         Ngd2 = imresize(Il_2,2);
         Ngd2 = Ngd2(i-1:i+1,j-1:j+1);
         Ngd0 = imresize(Il_0,0.5);
         Ngd0 = Ngd0(i-1:i+1,j-1:j+1);
         
         if(Il_1(i,j) > max(Ngd0(:)))
             if( Il_1(i,j) > max(Ngd1(:)))
                 if( Il_1(i,j) > max(Ngd2(:)) ) 
                   key_point(n+1,1) = i*2;
                   key_point(n+1,2) = j*2;
                   key_point(n+1,3) = 2;
                   n = n+1;
                   disp(n)
                 end
             end
         end  
         if(Il_1(i,j) < min(Ngd0(:)) )
             if(Il_1(i,j) < min(Ngd1(:)))
                 if(Il_1(i,j) < min(Ngd2(:)))
                    key_point(n+1,1) = i*2;
                    key_point(n+1,2) = j*2;
                    key_point(n+1,3) = 2;
                    n = n+1;
                    disp(n)
                 end
             end
         end
            
     end   
 end
 

 
 
 
 
 for i =(2:size(Il_2,1)-1)
     for j = (2:size(Il_2,2)-1)
         Ngd1 = [];
         for x = (i-1:i+1)
             for y = (j-1:j+1)
                 if x~=i || y~=j
                     Ngd1 = [Ngd1 Il_2(x,y)];
                 end
             end
         end
         Ngd2 = imresize(Il_3,2);
         Ngd2 = Ngd2(i-1:i+1,j-1:j+1);
         Ngd0 = imresize(Il_1,0.5);
         Ngd0 = Ngd0(i-1:i+1,j-1:j+1);
         if(Il_2(i,j) > max(Ngd0(:)) && Il_2(i,j) > max(Ngd1(:)) && Il_2(i,j) > max(Ngd2(:))) 
             key_point(n+1,1) = i*4;
             key_point(n+1,2) = j*4;
             key_point(n+1,3) = 4;
             n = n+1;
             disp(n)
         elseif(Il_2(i,j) < min(Ngd0(:)) && Il_2(i,j) < min(Ngd1(:)) && Il_2(i,j) < min(Ngd2(:)))
             key_point(n+1,1) = i*4;
             key_point(n+1,2) = j*4;
             key_point(n+1,3) = 4;
             n = n+1;
             disp(n)
         end
            
     end   
 end
 
 for i =(2:size(Il_3,1)-1)
     for j = (2:size(Il_3,2)-1)
               Ngd1 = [];
         for x = (i-1:i+1)
             for y = (j-1:j+1)
                 if x~=i || y~=j
                     Ngd1 = [Ngd1 Il_3(x,y)];
                 end
             end
         end
         Ngd2 = imresize(Il_4,2);
         Ngd2 = Ngd2(i-1:i+1,j-1:j+1);
         Ngd0 = imresize(Il_2,0.5);
         Ngd0 = Ngd0(i-1:i+1,j-1:j+1);
         if(Il_3(i,j) > max(Ngd0(:)) && Il_3(i,j) > max(Ngd1(:)) && Il_3(i,j) > max(Ngd2(:))) 
             key_point(n+1,1) = i*8;
             key_point(n+1,2) = j*8;
             key_point(n+1,3) = 8;
             n = n+1;
             disp(n)
         elseif(Il_3(i,j) < min(Ngd0(:)) && Il_3(i,j) < min(Ngd1(:)) && Il_3(i,j) < min(Ngd2(:)))
             key_point(n+1,1) = i*8;
             key_point(n+1,2) = j*8;
             key_point(n+1,3) = 8;
             n = n+1;
             disp(n)
         end
            
     end   
 end
 
 
 disp(n);
 figure,imshow(I_Green);
 hold on;
 colors={'r','g','b'};
 for k = (1:n)
     x = key_point(k,1);
     y = key_point(k,2);
     sigma = key_point(k,3);
     circle([x y], sigma, 'color', colors{log2(sigma)});
 end