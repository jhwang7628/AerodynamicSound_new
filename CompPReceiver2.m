% COMPUTE THE PRESSURE AT THE RECEIVER
   % Shifted the Green's function using the position data of the sound source g_l(t_k - r_l/c_0)
   % Sum the pressure from each source up to get the receiver pressure
function pl = CompPReceiver2(ObjPosition,c0,ll,t_k)

global gl_g O T


rl = norm(ObjPosition-O);
Cl = 1/(4*pi*c0*rl^2);
tmp= O - ObjPosition;

t_k = t_k-rl/c0;
% t_k = T(kk);
if t_k<0
   gl = [0,0,0];
else
   gl = GlExt(T,t_k,ll);
end

pl = Cl*dot(tmp,gl);

end


