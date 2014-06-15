% Read in openfoam data and generate sound for the raw data

PWD = pwd; 
A = load([PWD,'/postProcessing/totalForces/5.980000000003771/forcesProcessed']);

cutoff = 3000; 
ri = 0.5; 
c0 = 330; 
dt = 0.0001; 

scal = 100; 


T = A(cutoff:end-1,1); 
dtAcut = (A(cutoff+1:end,2:4) - A(cutoff-1:end-2,2:4))/(2*(T(2)-T(1)));

Pv = ri.*sum(dtAcut,2)./(4*pi*c0*norm([ri,ri,ri]).^2);
SPL = 10.*log(Pv.^2/(20E-6).^2)/log(10);
% Pv_db = 20.*log(Pv/20E-6)/log(10); % Calculate decibel level

figure, plot(T,A(cutoff:end-1,2:4)), axis tight 
figure, plot(A(cutoff:end-1,2:4)), axis tight
figure, plot(T,Pv), ylabel('Sound Pressure'), axis tight
figure, plot(T,SPL), ylabel('SPL'), axis tight
[f,fftPv] = PlotFFTSignal(T,Pv,1);

player0 = audioplayer(Pv*100,1/dt);


