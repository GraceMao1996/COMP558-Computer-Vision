function  [P, K, R, C] =  calibrate(XYZ, xy)

%  Create the data matrix to be used for the least squares.
%  and perform SVD to find matrix P.

%  BEGIN CODE STUB (REPLACE WITH YOUR OWN CODE)

% K = [1 0 0;  0 1 0; 0 0 1];  
% R = [1 0 0;  0 1 0; 0 0 1];  
% C = [0 0 0];
numPositions = size(XYZ,1);
A = [];
for j = 1:numPositions
    X = XYZ(j,1);
    Y = XYZ(j,2);
    Z = XYZ(j,3);
    x = xy(j,1);
    y = xy(j,2);
    
    
    A = [A;X Y Z 1 0 0 0 0 -x*X -x*Y -x*Z -x];
    A = [A;0 0 0 0 X Y Z 1 -y*X -y*Y -y*Z -y];
   
end
[U,S,V] = svd(A);
min = +Inf;
index = 1;
for i = 1:12
    singular_value = S(i,i);
    if singular_value<min
        min = singular_value;
        index = i;
    end
end

p = V(:,i);
P = [p(1) p(2) p(3) p(4);
    p(5) p(6) p(7) p(8);
    p(9) p(10) p(11) p(12)];


%  END CODE STUB 
% 
% P = K * R * [eye(3), -C];
[K, R, C] = decomposeProjectionMatrix(P);
