% Read in openfoam data and generate sound for the raw data.
%
% Argument list: 
%  * ri: observer position
%  * scal: scaling to the final sound rendering
%
function [player0] = Raw_openfoam(ri,scal,extension)

% A = load('ForcesProcessed_matlab'); 
load('forcesProcessed_matlab.mat');

cutoff = 2;
c0 = 330; 
dt = A(end,1)-A(end-1,1);


T        = A(cutoff:end-1,1  ); 
  Forces = A(cutoff:end-1,2:4);
dtForces =(A(cutoff+1:end,2:4) - A(cutoff-1:end-2,2:4))/(2*(T(2)-T(1)));

Pv    = ri.*sum(dtForces,2)./(4*pi*c0*norm([ri,ri,ri]).^2);
SPL_t = calc_SPL(Pv);

[f,fftPv] = PlotFFTSignal(T,Pv,1);
Pv_f_PSD  = sqrt(real(fftPv).^2 + imag(fftPv).^2);
SPL_f = calc_SPL(Pv_f_PSD,1); 

figure, 
subplot(2,1,1), plot(T,  Forces(:,1:3)), xlabel('Time'), ylabel('Forces (N)')
subplot(2,1,2), plot(T,dtForces(:,1:3)), xlabel('Time'), ylabel('Force derivatives')
figure, 
plot(T, SPL_t), xlabel('Time'), ylabel('SPL dB'),
   gg = get(gca,'ylim'), set(gca,'ylim', [0,gg(2)]);
% plot(f, SPL_f), xlabel('Frequency'), ylabel('SPL B')


if exist('extension')
   Pvtmp=[];
   for ii = 1:extension
      Pvtmp = [Pvtmp;Pv];
   end
   Pv=Pvtmp;
end


% Sound Rendering
player0 = audioplayer(Pv*scal,1/dt);




end
