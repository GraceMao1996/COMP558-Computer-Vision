function [Vx,Vy] = compute_LK_optical_flow(frame_1,frame_2,type_LK)

% You have to implement the Lucas Kanade algorithm to compute the
% frame to frame motion field estimates. 
% frame_1 and frame_2 are two gray frames where you are given as inputs to 
% this function and you are required to compute the motion field (Vx,Vy)
% based upon them.
% -----------------------------------------------------------------------%
% YOU MUST SUBMIT ORIGINAL WORK! Any suspected cases of plagiarism or 
% cheating will be reported to the office of the Dean.  
% You CAN NOT use packages that are publicly available on the WEB.
% -----------------------------------------------------------------------%

% There are three variations of LK that you have to implement,
% select the desired alogrithm by passing in the argument as follows:
% "LK_naive", "LK_iterative" or "LK_pyramid"

switch type_LK

    case "LK_naive"
        % YOUR IMPLEMENTATION GOES HERE
        %frame_1 = frame_1(:,:,2);
        %frame_2 = frame_2(:,:,2);
        frame_1 = rgb2gray(frame_1);
        frame_2 = rgb2gray(frame_2);
      
        sigma = 1;
        windowsize = 3;
        l = floor(windowsize/2);
        g = fspecial("gaussian", [3,3], sigma);
        frame_1 = conv2(frame_1, g, 'same');
        frame_2 = conv2(frame_2, g, 'same');
        [Ix,Iy] = gradient(double(frame_1));
       
        Vx = zeros(size(frame_1));
        Vy = zeros(size(frame_1));
        for x = 1+l:size(frame_1,1)-l
            for y = 1+l:size(frame_1,2)-l
                
                temp = zeros(2,2);  
                temp1 = zeros(2,1);  
                V = zeros(2,1);
                for i = x-l:x+l        %the window size = 3
                    for j = y-l:y+l
                        temp(1,1) = temp(1,1) + Ix(i,j)*Ix(i,j);
                        temp(1,2) = temp(1,2) + Ix(i,j)*Iy(i,j);
                        temp(2,1) = temp(2,1) + Ix(i,j)*Iy(i,j);
                        temp(2,2) = temp(2,2) + Iy(i,j)*Iy(i,j);
                        temp1(1,1) = temp1(1,1) + (frame_2(i,j)-frame_1(i,j))*Ix(i,j);
                        temp1(2,1) = temp1(2,1) + (frame_2(i,j)-frame_1(i,j))*Iy(i,j);
                    end
                end
                r = rank(temp);
                if r == 2
                    V =  -inv(temp)*temp1;
                end
                Vx(x,y) = V(1,1); 
                Vy(x,y) = V(2,1);
            end
        end
      
       
                
        
    case "LK_iterative"
        % YOUR IMPLEMENTATION GOES HERE
            % YOUR IMPLEMENTATION GOES HERE
        
        frame_1 = rgb2gray(frame_1);
        frame_2 = rgb2gray(frame_2);
      
        sigma = 1;
        windowsize = 40;
        l = floor(windowsize/2);
        g = fspecial("gaussian", [3,3], sigma); %gaussian filter
        frame_1 = conv2(frame_1, g, "same");
        frame_2 = conv2(frame_2, g, "same");    %blur the image
        
        Vx = zeros(size(frame_1));
        Vy = zeros(size(frame_1));          %initialize vx,vy
        
        [Ix,Iy] = gradient(double(frame_1));
        
        Vv =[];
        for x = 1+l:size(frame_1,1)-l
            for y = 1+l:size(frame_1,2)-l
                
                t=0;
                window_1 = frame_1(x-l:x+l, y-l:y+l);
                window_2 = frame_2(x-l:x+l, y-l:y+l);
                while(t<3)
                    temp = zeros(2,2);  
                    temp1 = zeros(2,1);  
                    t = t+1;           %iterative time
                    
                    for i = x-l:x+l        %the window size = 2*l+1
                        for j = y-l:y+l
                            temp(1,1) = temp(1,1) + Ix(i,j)*Ix(i,j);
                            temp(1,2) = temp(1,2) + Ix(i,j)*Iy(i,j);
                            temp(2,1) = temp(2,1) + Ix(i,j)*Iy(i,j);
                            temp(2,2) = temp(2,2) + Iy(i,j)*Iy(i,j);
                            temp1(1,1) = temp1(1,1) + (window_2(i-x+l+1,j-y+l+1)-window_1(i-x+l+1,j-y+l+1))*Ix(i,j);
                            temp1(2,1) = temp1(2,1) + (window_2(i-x+l+1,j-y+l+1)-window_1(i-x+l+1,j-y+l+1))*Iy(i,j);
                        end
                    end

                    r = rank(temp);
                    if r == 2
                        V =  -inv(temp)*temp1;
                    end
                    V(isnan(V)) = 0;
                    Vv = [Vv V];
                    Vx(x,y) = Vx(x,y)+V(1,1); 
                    Vy(x,y) = Vy(x,y)+V(2,1);

                    x_new= x+round(Vx(x,y));
                    y_new = y+round(Vy(x,y));

                    if x_new < 1+l 
                        x_new = 1+l;
                    elseif x_new > size(frame_1,1)-l
                        x_new = size(frame_1,1)-l;
                    end

                    if y_new<1+l
                        y_new = 1+l;
                    elseif y_new>size(frame_1,2)-l
                        y_new =size(frame_1,2)-l;
                    end
                    window_2 = frame_2(x_new-l:x_new+l,y_new-l:y_new+l);  
                end
            end
        end
        

        
        

    case "LK_pyramid"
        % YOUR IMPLEMENTATION GOES HERE
        frame_1 = rgb2gray(frame_1);
        frame_2 = rgb2gray(frame_2);
      
        gaussianpyramid_1 = cell(3,1);
        gaussianpyramid_2 = cell(3,1);
        windowsize = 40;
        l = floor(windowsize/2);
        for s = 1:3
            if s == 1
                gaussianpyramid_1{s} = frame_1;
                gaussianpyramid_2{s} = frame_2;
            else 
                gaussianpyramid_1{s} = gaussianpyramid_1{s-1};
                gaussianpyramid_2{s} = gaussianpyramid_2{s-1};     %firstly copy last layer
            end
            sigma = 2^(s-1);
            g = fspecial('gaussian', [3 3], sigma);
            gaussianpyramid_1{s} = conv2(gaussianpyramid_1{s}, g, 'same');      %then blur with gaussian filter
            gaussianpyramid_2{s} = conv2(gaussianpyramid_2{s}, g, 'same');
            if s ~=1
                gaussianpyramid_1{s} = imresize(gaussianpyramid_1{s}, 0.5);     % then resize
                gaussianpyramid_2{s} = imresize(gaussianpyramid_2{s}, 0.5);
            end
        end
        
        Vx_cell = cell(3,1);
        Vy_cell = cell(3,1);
        Vx = zeros(size(frame_1));
        Vy = zeros(size(frame_1));
 
        for level = 1:3 
            s = 4 - level;
            %from the coarsest pyramid to finest one
             
            if s == 3
                Vx_cell{s} = zeros(size(gaussianpyramid_1{3}));
                Vy_cell{s} = zeros(size(gaussianpyramid_1{3}));
            else
                Vx_cell{s} = Vx_cell{s+1};
                Vy_cell{s} = Vy_cell{s+1};         %use the (Vx,Vy) of the coarser pyramid to initialize the finer one 
            end
            
         
            [Ix,Iy] = gradient(double(gaussianpyramid_1{s}));
                   
                
            maxV = 0;
            for x = 1+l:size(gaussianpyramid_1{s},1)-l
                for y = 1+l:size(gaussianpyramid_1{s},2)-l
                   
                    t = 0;       %iterative time
                    window_1 = gaussianpyramid_1{s}(x-l:x+l, y-l:y+l);
                    window_2 = gaussianpyramid_2{s}(x-l:x+l, y-l:y+l);
                    while(t<3)
                        t = t+1; 
                        V = zeros(2,1);
                        temp = zeros(2,2);  
                        temp1 = zeros(2,1);  
                        
                        for i = x-l:x+l        %the window size = 9
                            for j = y-l:y+l
                                temp(1,1) = temp(1,1) + Ix(i,j)*Ix(i,j);
                                temp(1,2) = temp(1,2) + Ix(i,j)*Iy(i,j);
                                temp(2,1) = temp(2,1) + Ix(i,j)*Iy(i,j);
                                temp(2,2) = temp(2,2) + Iy(i,j)*Iy(i,j);
                                temp1(1,1) = temp1(1,1) + (window_2(i-x+l+1,j-y+l+1)-window_1(i-x+l+1,j-y+l+1))*Ix(i,j);
                                temp1(2,1) = temp1(2,1) + (window_2(i-x+l+1,j-y+l+1)-window_1(i-x+l+1,j-y+l+1))*Iy(i,j);
                            end
                        end
                        r = rank(temp);
                        %if r == 2
                        V =  -inv(temp)*temp1;
                        %end
                        V(isnan(V)) = 0;
                        Vx_cell{s}(x,y) = Vx_cell{s}(x,y)+V(1,1); 
                        Vy_cell{s}(x,y) = Vy_cell{s}(x,y)+V(2,1);
                        
                        if max(abs(V)) > maxV
                            maxV = max(V);
                        end


                        x_new= x+round(Vx_cell{s}(x,y));
                        y_new = y+round(Vy_cell{s}(x,y));

                        if x_new < 1+l 
                            x_new = 1+l;
                        elseif x_new > size(gaussianpyramid_2{s},1)-l
                            x_new = size(gaussianpyramid_2{s},1)-l;
                        end

                        if y_new<1+l
                            y_new = 1+l;
                        elseif y_new>size(gaussianpyramid_2{s},2)-l
                            y_new =size(gaussianpyramid_2{s},2)-l;
                        end
                        window_2 = gaussianpyramid_2{s}(x_new-l:x_new+l,y_new-l:y_new+l);  
                        disp(t)
                        
                    end
                end
                
                if maxV < 0.1 || t>3
                    break;
                end
            end
            if s ~= 1
                Vx_cell{s} = imresize(Vx_cell{s}, size(gaussianpyramid_2{s-1}));
                Vy_cell{s} = imresize(Vy_cell{s}, size(gaussianpyramid_2{s-1}));
                Vx_cell{s} = Vx_cell{s} * 2;
                Vy_cell{s} = Vy_cell{s} * 2;
            end
        end
        Vx = Vx_cell{1};
        Vy = Vy_cell{1};
end



