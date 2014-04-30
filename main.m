function pl = main

% Problem setup
dt= 4E-5; 
tspan = [0,3]; 
T = tspan(1):dt:tspan(end);   % Physical time
S(1) = T(1);                  % Texture time
v0 = 1;
c0 = 340;
k=1;

% Compute object motion
[X,U,vl] = object_motion(T);
[g, SS, drag] = cal_g;
gl = zeros(1,3);

% Make sure the texture time is aligned with physical time
if SS(1) ~= T(1)
   disp('The time domain is not aligned between physical and texture domain!');
   return;
end   

% RE-READ THIS
for ll = 1:4
  for T = tspan(1):dt:tspan(end)
        S(k+1) = vl(k+1,ll)./v0.*dt + S(k);
        [row,col] = find(SS(:)<S(k+1));
        gl = [gl; (vl(k+1,ll)./v0).^6.*g(row(1),1), (vl(k+1,ll)./v0).^6.*g(row(1),2), 0];
        k = k+1;
  end
  
  % SUM UP THE PRESSURE OF EACH SOURCE
  for kk = 1:k
        rl = norm(X(kk,:,ll));
        C  = 4.*pi.*c0.*rl.^2;
        pl(kk,ll) = 1/C*dot(-X(kk,:,ll),gl(kk,:));
  end
end


   
   



