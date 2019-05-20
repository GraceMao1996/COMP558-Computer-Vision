function c=myconv(A,B)
O1=zeros(size(B,1)-1,size(A,2));
A=[O1;A;O1];    %supplement A
O2=zeros(size(A,1),size(B,2)-1);
A=[O2 A O2];    %supplement A
B=rot90(B,2);   %rotate 180 degrees
c=zeros(size(A,1)-size(B,1)+1,size(A,2)-size(B,2)+1);
for i=1:size(A,1)-size(B,1)+1
    for j=1:size(A,2)-size(B,2)+1
        c(i,j)=sum(sum(A(i:i+size(B,1)-1,j:j+size(B,2)-1).*B));  %Multiply and add the corresponding elements
    end
end