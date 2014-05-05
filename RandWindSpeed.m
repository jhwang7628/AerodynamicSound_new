function x = RandWindSpeed(k, lambda)

% k      = 1; % shape 
% lambda = 1; % scale


x = lambda.*(-log(1-rand(1))).^(1/k);


%%%%%% Verify the distribution %%%%%%% 
%
% for ii = 1:100000 
%   xsamp(ii) = RandWindSpeed(k, lambda);
% end
% [n, xout] = hist(xsamp, 200); 
% figure, plot(xout, n/sum(n).*factor, '-', x, y,'r-')
% figure, plot(xsamp(1:200)) 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
