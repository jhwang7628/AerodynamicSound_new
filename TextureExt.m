% Write the interpolation function so that the texture can be directly called upon. 
% This extraction function is written ONLY FOR 1D TABLE (circular cylinder)
%
% Created by Jui-Hsien Wang
% Date: 12/04/14
% 
% * Linear Interpolation is performed if the input s_k does not match with the texture time (first column),S, 
%   of TexTable_g and 0 < s_k < max(S).  
% * Sound Texture is assumed to be periodic and the ends of it are blended to give a smooth transition of the
%   sound source function.


function wl = TextureExt(s_k)

global TexTable_g

wl = zeros(1,3);

if s_k >= max(TexTable_g(:,1))
   s_k = rem(s_k,TexTable_g(end,1));
end

[row,col] = find(TexTable_g(:,1) >= s_k);
if row(1) ~= 1
     t_int = s_k;
   tmp_low = TexTable_g(row(1)-1,2:4);
     t_low = TexTable_g(row(1)-1,1  );      
   tmp_hig = TexTable_g(row(1),  2:4);
     t_hig = TexTable_g(row(1),  1  );
     
   wl = (s_k - t_low)./(t_hig - t_low).*(tmp_hig - tmp_low) + tmp_low;
else
   wl = TexTable_g(2:4);
end







end


