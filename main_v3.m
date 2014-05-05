% IMPLEMENTATION OF THE CALCULATION OF AERODYNAMIC SOUND USING SOUND TEXTURE
% Following: Real-time Rendering of Aerodynamic Sound using Sound Textures based on Computational Fluid Dynamics

function [T,Pv,X,U,vl,O,TexTable_g] = main_v3(ReceiPos,SampFreq,PrevData)

global TexTable_g gl_g O T


if size(ReceiPos,1) == 1
   O=ReceiPos.';
else
   O=ReceiPos;
end

% INITIALIZE THE VARIABLES
tend = 5;
T = linspace(0,tend,SampFreq.*tend).';
NumElem = 5; % Number of discretization of the object
v0 = 10;
dt = T(2) - T(1);
c0 = 340;
gl_g = zeros(length(T),NumElem,3); 


if nargin < 3
   [PRaw] = TextureConstruc;
else 
   PrevData(:,1) = PrevData(:,1) - PrevData(1,1); % shift the texture back to zero
   TexTable_g = PrevData;
   % PRaw = sprintf('N/A');
end
   
% [X,U,ObjSpeed] = ObjMotion(T,NumElem,'rotate');  % ObjMotion(T,NumElem,flag)


U = zeros(length(T),3,NumElem);
X = zeros(length(T),3,NumElem);
vl= zeros(length(T),NumElem); % Speed of the element

   
S_k = T(1);
Pv = zeros(1,length(T));

[WS,Tws,ws] = WindSpeedConstruc(T,10);
WS = WS./max(WS).*35; % Scale the wind speed

for kk = 1:length(T)
      [ObjPosition, ObjSpeed] = ObjMotion2(T(kk),WS(kk),NumElem,'standing_wind_random');
      vl(kk,:) = ObjSpeed; 
       X(kk,:,:) = ObjPosition;

   pl = zeros(1,NumElem);
   for ll = 1:NumElem
      [S_k,gl_g(kk,ll,:)] = CompGFunc(ObjSpeed(ll),v0,dt,S_k);

      pl(ll) = CompPReceiver2(ObjPosition(:,ll),c0,ll,T(kk));
      % S_k_mon(kk) = S_k;
   end
   Pv(kk) = sum(pl);
end
   
% Pv = CompPReceiver(X,c0);
   

% POSTPROCESSING, SOUND RENDERING


end
