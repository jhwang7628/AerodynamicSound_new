function y = SynWindSpeed(T)

t = T;
tperiod = T(end);

% y = 1.5.*sin(2*pi/tperiod*2.*t) + 2.*cos(2*pi/tperiod*2.5.*t) + sin(2*pi/tperiod*10.*t)-cos(2*pi/tperiod*0.1.*t.^2).*cos(2*pi/tperiod*3.*t).*sqrt(t).*3;

t = t - tperiod/7;
y = 3.*sin(2*pi/tperiod/2.*t) + 0.5.*cos(2*pi/tperiod*2.5.*t)+ 0.1.*sin(2*pi/tperiod*10.*t)-0.5.*cos(2*pi/tperiod*0.1.*t.^2).*cos(2*pi/tperiod*3.*t).*t;
y = y.*2 + 10;
% y = y./1.2+15+randn(size(y)).*0.25;


% figure, plot(t,y)


end
