% Sort the data so the texture is represented by a function w(l,s_k,c_l,v_0), (l: element, s_k: texture, c_l: velocity direction, v_0: base vel.)

function TexTable = CompTexture(Y,s_start,s_stop,flag)

% WARNING: MODIFY THIS LINE WHEN YOU GET THE TEXTURE TIME DISCRETIZATION
% S1 = linspace(s_start,s_stop,size(Y,3)); % Texture domain time
% S = s_start:ds:s_stop; % Texture domain time
S = linspace(s_start, s_stop, size(Y,3));
S = S - s_start; % Shift the texture time back to zero
ds = S(2) - S(1);

drag = zeros(size(Y,3),3); % x force, y force
w_l  = zeros(size(Y,3),3); % sound texture 
TexTable = zeros(size(Y,3),4);


% Compute the drag in x,y,z direction
for ii = 1:size(Y,3)
   drag(ii,1) = sum(Y(:,2,ii).*Y(:,3,ii));
   drag(ii,2) = sum(Y(:,2,ii).*Y(:,4,ii));
end

% Finite-difference for the time derivatives of the greens function
for jj = 1:2
   w_l(2:end-1,jj) = (drag(3:end,jj)    - drag(1:end-2,jj)               )/2/ds;
   w_l(1,      jj) = (4.*drag(2    ,jj) - drag(3    ,jj) - 3.*drag(1  ,jj))/2/ds;
   w_l(end,    jj) =-(4.*drag(end-1,jj) - drag(end-2,jj) - 3.*drag(end,jj))/2/ds;
end

TexTable(:,1)   = S.';
TexTable(:,2:4) = w_l; 

end

