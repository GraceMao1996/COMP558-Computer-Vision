function g = make2DGaussian(N, sigma)
% N is odd, and so the origin (0,0) is positioned at indices
% (M+1,M+1) where N = 2*M + 1.
  M=(N-1)/2;
  sig = sigma;
  [x,y] = meshgrid(-M:0.1:M,-M:0.1:M);
  g = exp(-(x.*x+y.*y)./(2*sig*sig));  %the gaussian function
  sumg = sum(g(:));
  if (sumg~=0)
      g = g/sumg;                    %make sure the sum of g = 1;
  end
  mesh(x,y,g); %?????????
  title('?????');
  
end

