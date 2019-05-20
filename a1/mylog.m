function log=mylog(N,sigma)
% N is odd, and so the origin (0,0) is positioned at indices
% (M+1,M+1) where N = 2*M + 1.

%gaussian
  M=(N-1)/2;
  sig = sigma;
  [x,y] = meshgrid(-M:M,-M:M);
  g = exp(-(x.*x+y.*y)./(2*sig*sig));
  sumg = sum(g(:));
  if (sumg~=0)   % let the sum of g = 1
      g = g/sumg;
  end
  
  %laplacian of gaussian:
  
  gl = g.*(x.*x + y.*y - 2*sig*sig)/(sig^4);
  

  log = gl -sum(gl(:))/(N.*N); % let the sum of log = 0 
  