% CONSTRUCT THE TEXTURE TABLE 
   % Read the table from Fluent
   % Compute the sound texture by integrating the pressure around the object and taking the time derivatives.
   % Sort the data so the texture is represented by a function w(l,s_k,c_l,v_0), (l: element, s_k: texture, c_l: velocity direction, v_0: base vel.)

function [PRaw, TexTable_g] = TextureConstruc

global TexTable_g

% Read the table from Fluent
[Y,FileStart,FileEnd] = ReadFluent;
PRaw = squeeze(Y(:,2,:));

% Compute the sound texture by integrating the pressure around the object and taking the time derivatives.

% Read data for Re120
% TexTable_g = CompTexture(Y,5.068274,5.079914,[]); % CompTexture(Y,s_start,s_stop,ds,flag)

% Read data for Re1200
TexTable_g = CompTexture(Y,FileStart,FileEnd,[]); % CompTexture(Y,s_start,s_stop,ds,flag)


% TexTable_g = CompTexture(Y,10.155914,10.208764,[]); % CompTexture(Y,s_start,s_stop,ds,flag)




end






