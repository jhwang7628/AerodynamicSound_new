function f = HarmWindSpeed(t)


f = 15+1.*[1.5.*sin(2*pi/4.*t) + 0.5.*cos(2*pi/2.*t) - 0.5.*sin(2*pi/3.5.*t).*cos(2.*pi/0.9.*t)];

end


