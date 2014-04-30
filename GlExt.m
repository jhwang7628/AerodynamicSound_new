function gl = GlExt(T,t_k,ll)

global gl_g

gl = zeros(1,3);

if t_k >= max(T)
   t_k = rem(t_k,T(end));
   return;
end

[row,col] = find(T >= t_k);
if row(1) ~= 1
   tmp_low = zeros(3,1); tmp_hig = zeros(3,1);
   for ii = 1:3
        t_int     = t_k;
      tmp_low(ii) = gl_g(row(1)-1,ll,ii);
        t_low     = T(row(1)-1);      
      tmp_hig(ii) = gl_g(row(1)  ,ll,ii);
        t_hig     = T(row(1));
   end
     
   gl = (t_k - t_low)./(t_hig - t_low).*(tmp_hig - tmp_low) + tmp_low;
   gl = gl.';
end


