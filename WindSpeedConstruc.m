function [WS,Tws,ws] = WindSpeedConstruc(T,n_sample)

tstart = T(1); 
tend   = T(end);

% n_sample = 15;

Tws = linspace(tstart, tend, n_sample); % uniformly sample the wind velocity change
 ws = zeros(size(Tws));

for ii = 1:n_sample
   ws(ii) = RandWindSpeed(3,15);
end
% ws = ws + min(ws);

% polydegree = round(n_sample*0.8)
% polydegree = 10
polydegree = n_sample;
pp = polyfit(Tws,ws,polydegree);

WS = zeros(size(T));
for ii = 1:polydegree+1
   WS = WS + pp(ii).*T.^(n_sample-(ii-1));
end

if min(WS) < 0
   ws = ws + abs(min(WS));
   WS = WS + abs(min(WS));

end
