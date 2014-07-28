% Dobashi implementation
%
%
%
%
%
%
%

Hello this is wrong.
function [Pv] = main_v4

global Table NumSources

NumSources=10;
SampFreq=16000;

ConstructTable; 
Pv = SoundRendering(SampFreq);

figure, plot(Table(1).Texture)


end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Table = ConstructTable 

global Table NumSources

% Read-in spec for how many orientation and inflow speed we want to do. 
% Table is a class. Each object in the class records the simulation description of a unique point in the simulation parameter space. 
%
% in the class is generated by reading the SimSpec description.

%
%
load('./SimSpec_files/simulation_spec.mat');

LenTable  = length(Table);

for CurrentTableEntry = 1:LenTable 
    ComputeTexture(CurrentTableEntry); 
end



end



%%%%%%%%

function ComputeTexture(CurrentTableEntry )

global Table NumSources

[TextureTime,DragTexture] = ReadSimulation(Table(CurrentTableEntry).simulationFile); 
% Discretize_Object(NumSources); % First treat the object as acoustically compact.

CompTexture2(CurrentTableEntry, TextureTime,DragTexture);



end


%%%%%%%%

% Read in the simulation data
function [TextureTime,DragTexture] = ReadSimulation(filename)

% Process the data differently depending on the software used
%
% OpenFoam:  
% ---------
%
%   File name: forcesProcessed_matlab.mat
%
%   T   Forces_X    Forces_Y    Forces_Z
%   ------------------------------------
%
%

% switch SimSpec_ii.software
%     case {'OpenFoam', 'Openfoam', 'OpenFOAM'}
%         disp('Simulation done by OpenFoam.')
%                 
%     case 'Fluent'
%         disp('Simulation done by ANSYS Fluent.')'
%     otherwise 
%         disp('Simulation software not recognized!')
% end


% For OpenFoam;
tmp = load(filename);

cutoff = 3000; 

% cut off the undesired initial transient
if size(tmp,1) > cutoff    
    tmp = tmp(cutoff:end,:);
end

TextureTime = tmp(:,1);
DragTexture(:,1)= tmp(:,2);
DragTexture(:,2)= tmp(:,3);
DragTexture(:,3)= tmp(:,4);


end


%%%%%%%%

function CompTexture2(CurrentTableEntry, TextureTime,DragTexture);

global Table

% sound texture
w_l = zeros(length(TextureTime),3); 

% Shift the texture time to start from zero.
TextureTime = TextureTime - TextureTime(1);

dT = TextureTime(2) - TextureTime(1); 

if abs(dT - (TextureTime(end)-TextureTime(end-1))) / dT > 0.1
    fprintf('Error: Adaptive time stepping in the simulation data detected. \n')
    return;
end


% Second-order finite difference methods are used to approximate the time derivatives 
for jj = 1:3
   w_l(2:end-1,jj) = (DragTexture(3:end,jj)    - DragTexture(1:end-2,jj)               )/2/dT;
   w_l(1,      jj) = (4.*DragTexture(2    ,jj) - DragTexture(3    ,jj) - 3.*DragTexture(1  ,jj))/2/dT;
   w_l(end,    jj) =-(4.*DragTexture(end-1,jj) - DragTexture(end-2,jj) - 3.*DragTexture(end,jj))/2/dT;
end

Table(CurrentTableEntry).TextureTime = TextureTime; 
Table(CurrentTableEntry).Texture = w_l;


end


function Pv = SoundRendering(SampFreq)

global Table NumSources

% INITIALIZE THE VARIABLES
tend = 5;
T = linspace(0,tend,SampFreq.*tend).';
v0 = 10;
dt = T(2) - T(1);
c0 = 340;

Pv = zeros(length(T),1);

vl = ObjMotion3(T);


%%%% Can probably parallelize/vectorize this part of the code %%%%
CurrentTime = ones(1,NumSources).*T(1);
for ii = 1:length(T)
    for jj = 2:NumSources
          [CurrentTime(jj), Pl_ii] = CompPReceiver3(CurrentTime(jj), T,vl(ii,jj),v0,dt,c0);
          Pv(ii) = Pv(ii) + Pl_ii;
    end
end
%

% for jj = 2:NumSources
%     tic
%   CurrentTime = T(1);
%   fprintf('Calculating the pressure of source # %2.0i \n', jj)
%   for ii = 1:length(T)
%       [CurrentTime, Pv(ii)] = CompPReceiver3(CurrentTime, vl(ii,jj));
%   end
%   toc
% 
%   
% end

% gl_g = zeros(length(T),NumSources,3); 


% Nested function
% ObjMotion3 describe the object motion, copied from the file ObjMotion.m
%
end
function vl = ObjMotion3(T,flag)

global NumSources

    % default for flag is rotate
    if nargin < 3
        flag = 'rotate';
    end

    vl= zeros(length(T),NumSources); % Speed of the element
    
    if strcmpi(flag, 'linear') % Linear motion

        fprintf('Error: Linear flag support is temporarily removed. Will update it to be in the receivers frame of reference.');
        return;

       
%        % Constant velocity motion in x-direction with four partition
%        for ii = 1:size(U,3)
%           U(:,1,ii) = 15.*ones(length(T),1);
%        end 
%     
%        dt = T(2)-T(1);
%        for ii = 1:size(U,3)
%           for jj = 2:length(T)
%              X(jj,1,ii) = X(jj-1,1,ii) + (U(jj,1,ii) + U(jj-1,1,ii))*dt/2;
%           end
%        end
%        
%        X(:,2,1) = 0  .*ones(length(T),1,1);
%        X(:,2,2) = 0.01.*ones(length(T),1,1);
%        X(:,2,3) = 0.02.*ones(length(T),1,1);
%        X(:,2,4) = 0.03.*ones(length(T),1,1);
%           
%        for ii = 1:length(T)
%           for jj = 1:NumSources
%              vl(ii,jj) = sqrt(U(ii,1,jj).^2 + U(ii,2,jj).^2 + U(ii,3,jj).^2);
%           end
%        end
    
    elseif strcmpi(flag, 'rotate') % harmonic rotation
    
       vmax = 15; 
       Ri = 10*((1:NumSources)-1)./(NumSources-1);
       Tswing = pi^2/2*Ri(end)/vmax;
%        theta = pi/2   - pi/4.*cos(2*pi.*T./Tswing);
%
%      % Analytical expression derived from prescribing theta
       omega = pi^2/2/Tswing.*sin(2*pi.*T./Tswing);

       for jj = 1:NumSources
           vl(:,jj) = omega.*Ri(jj);
       end

       

    end


end

% Nested function
function [CurrentTime, Pl_ii] = CompPReceiver3(CurrentTime, T,vl_ii,v0,dt,c0)

% Resample and interpolate the texture
%

VelocityRatio = vl_ii./v0;

% Time reindexing
CurrentTime = VelocityRatio.*dt + CurrentTime; 

% Looping the texture
if CurrentTime >= max(T)
    CurrentTime = rem(CurrentTime,T(end));
end


% Interpolate the texture using the CurrentTime
gl = VelocityRatio.^6.*InterpolateTexture(CurrentTime, vl_ii);

% Compute the Pressure at the receiver
% Neglecting the receiver position for now
%
% rl = norm(ObjPosition-O);
rl = 0.5;
Cl = 1/(4*pi*c0*rl^2);

Pl_ii = Cl*dot(gl,rl.*ones(1,3));




end




% Texture interpolation
% Assume there is only one table entry..
function [w_lInterpolated] = InterpolateTexture(CurrentTime, vl_ii)

global Table

SearchDomain = Table(1).TextureTime;; 

CurrentPointerRange=1:length(SearchDomain);

while true
    if length(SearchDomain) <= 2 
        w_lPointer = CurrentPointerRange(1); 
        break; 
    end

    MidPoint = ceil(length(SearchDomain)/2);

%     [length(SearchDomain),MidPoint,CurrentTime,SearchDomain(MidPoint)];

    if CurrentTime == SearchDomain(MidPoint)
        w_lPointer = CurrentPointerRange(MidPoint);
        break;
    elseif CurrentTime > SearchDomain(MidPoint) 
        SearchDomain = SearchDomain(MidPoint:end);
        CurrentPointerRange = CurrentPointerRange(MidPoint:end);
    else
        SearchDomain = SearchDomain(1:MidPoint);
        CurrentPointerRange = CurrentPointerRange(1:MidPoint);
    end

    % CurrentPointerRange(MidPoint)

end


w_lInterpolated  = Table(1).Texture(w_lPointer,:); 


end


    
















