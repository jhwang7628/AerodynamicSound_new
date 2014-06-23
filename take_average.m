function avg = take_average(xx, interval)

if rem(length(xx),interval) ~=0
   if size(xx,1) == 1
      x = zeros(1,length(xx)+interval-rem(length(xx),interval));
   elseif size(xx,2) == 1
      x = zeros(length(xx)+interval-rem(length(xx),interval),1);
   end
   x(1:length(xx)) = xx;
else
   x = xx;
end

if size(xx,1) == 1
   avg = zeros(1,length(x)/interval);
else
   avg = zeros(length(x)/interval,1);
end

for ii = 1:length(avg)
   avg(ii) = sum(x((ii-1).*interval+1:ii*interval))./interval;
end

end
