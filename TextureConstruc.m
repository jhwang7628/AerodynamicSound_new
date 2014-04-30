% CONSTRUCT THE TEXTURE TABLE 
   % Read the table from Fluent
   % Compute the sound texture by integrating the pressure around the object and taking the time derivatives.
   % Sort the data so the texture is represented by a function w(l,s_k,c_l,v_0), (l: element, s_k: texture, c_l: velocity direction, v_0: base vel.)

function [PRaw, TexTable_g] = TextureConstruc

global TexTable_g

% Read the table from Fluent
Y = ReadFluent;
PRaw = squeeze(Y(:,2,:));

% Compute the sound texture by integrating the pressure around the object and taking the time derivatives.
% TexTable_g = CompTexture(Y,5.068274,5.079914,0.00001,[]); % CompTexture(Y,s_start,s_stop,ds,flag)
TexTable_g = CompTexture(Y,9.800004,9.887094,[]); % CompTexture(Y,s_start,s_stop,ds,flag)


end






