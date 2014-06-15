% IMPLEMENTATION OF THE CALCULATION OF AERODYNAMIC SOUND USING SOUND TEXTURE
% Following: Real-time Rendering of Aerodynamic Sound using Sound Textures based on Computational Fluid Dynamics

function [T,Pv,X,U,vl,O,S_k_mon] = main_v2(ReceiPos,SampFreq,PrevData)

global TexTable_g gl_g O

O=ReceiPos;

% INITIALIZE THE VARIABLES
% tspan = [0,3];
% dt    = 4E-5; 
% T     = tspan(1):dt:tspan(2); T = T.';
tend = 3;
T = linspace(0,tend,SampFreq.*tend).';
NumElem = 10; % Number of discretization of the object
v0 = 10;
dt = T(2) - T(1);
c0 = 340;
gl_g = zeros(length(T),NumElem,3); 


% CONSTRUCT THE TEXTURE TABLE 
   % Read the table from Fluent
   % Compute the sound texture by integrating the pressure around the object and taking the time derivatives.
   % Sort the data so the texture is represented by a function w(l,s_k,c_l,v_0), (l: element, s_k: texture, c_l: velocity direction, v_0: base vel.)

if nargin < 3
   [PRaw] = TextureConstruc;
else 
   PrevData(:,1) = PrevData(:,1) - PrevData(1,1); % shift the texture back to zero   
   TexTable_g = PrevData;
end
   

% TEXTURE EXTRACTION
   % Write the interpolation function so that the texture can be directly called upon. 
% TextureExt
   

% SPECIFY THE OBJECT MOTION (IN THE FUTURE CAN USE EXPERIMENTAL MOTION TRACKER)
   % discretize and describe the body motion in space, including position and velocity (speed and direction) for each element.
   % render the body motion animation? 
   % This object motion spans the length of physical time. 
% [X,U,vl] = ObjMotion(T,NumElem,'linear');  % ObjMotion(T,NumElem,flag)
[X,U,vl] = ObjMotion(T,NumElem,'rotate');  % ObjMotion(T,NumElem,flag)

   

% COMPUTE THE GREEN'S FUNCTION AT EACH PHYSICAL TIME POINT
   % At each time point calculate the texture time knowing the speed of the source
   % Using this texture time, s_k, and direction info, c_l, to compute the green's function
S_k_mon = zeros(length(T),NumElem);
S_k = ones(1,NumElem).*T(1);
for ll = 1:NumElem
   for kk = 1:length(T)
      [S_k(ll),gl_g(kk,ll,:)] = CompGFunc(vl(kk,ll),v0,dt,S_k(ll));
      S_k_mon(kk,ll) = S_k(ll);
      
   end
end

   


% COMPUTE THE PRESSURE AT THE RECEIVER
   % Shifted the Green's function using the position data of the sound source g_l(t_k - r_l/c_0)
   % Sum the pressure from each source up to get the receiver pressure
Pv = CompPReceiver(X,c0,T);
   




% POSTPROCESSING, SOUND RENDERING


end
