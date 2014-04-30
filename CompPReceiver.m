% COMPUTE THE PRESSURE AT THE RECEIVER
   % Shifted the Green's function using the position data of the sound source g_l(t_k - r_l/c_0)
   % Sum the pressure from each source up to get the receiver pressure
function Pv = CompPReceiver(X,c0,T)

global gl_g O

NumElem = size(X,3);
pl = zeros(1,NumElem);
Pv = zeros(1,length(T));

for kk = 1:length(T)
   for ll = 1:NumElem

      rl = norm(X(kk,:,ll)-O);
      Cl = 1/(4*pi*c0*rl^2);
      tmp= O - X(kk,:,ll);

      t_k = T(kk)-rl/c0;
      % t_k = T(kk);
      if t_k<0
         gl = [0,0,0];
      else
         gl = GlExt(T,t_k,ll);
      end

      pl(ll) = Cl*dot(tmp,gl);
   end
   Pv(kk) = sum(pl);
end

end


