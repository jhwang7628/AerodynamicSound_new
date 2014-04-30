% COMPUTE THE GREEN'S FUNCTION AT EACH PHYSICAL TIME POINT
   % At each time point calculate the texture time knowing the speed of the source
   % Using this texture time, s_k, and direction info, c_l, to compute the green's function
function [S_k_new, gl] = CompGFunc(vl_k, v0, dt, S_k)
   S_k_new = vl_k./v0.*dt + S_k;
   gl = (vl_k./v0).^6.*TextureExt(S_k_new);
end



