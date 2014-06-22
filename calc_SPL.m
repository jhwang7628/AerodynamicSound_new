function SPL = calc_SPL(data, refP)

if nargin == 1
   % SPL for air is calculated
   SPL = 10.*log(data.^2/(20E-6).^2)/log(10);
else
   % SPL calculated about input refP
   SPL = 10.*log(data.^2/(refP ).^2)/log(10);
end

end
