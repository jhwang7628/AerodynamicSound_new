% function demo_v1

tLoad = tic;
load('/Users/jui-hsienwang/Documents/MATLAB/Aerodynamic_sound_Matlab/Test/data/Texture/2Dcylinder_v10_D0p01');
tLoadElapsed = toc(tLoad);
fprintf('Time elapsed for loading is ... %5.5f (second).\n',tLoadElapsed)
% 

tCalPv = tic; 
[T,Pv,PRaw,X,U,vl,O,TexTable_g] = main_v2([0,15,0],4000,TexTable_g);
tCalPvElapsed = toc(tCalPv);
fprintf('Time elapsed for calculating the sound pressure at the receiver end is ... %5.5f (second).\n',tCalPvElapsed)


Fs = 4000;
NFFT = 2^nextpow2(length(T));
fftPv = fft(Pv,NFFT)/length(T);
f = Fs/2*linspace(0,1,NFFT/2+1);

colorset = jet(size(X,3));
figure, set(gcf,'outerposition',[0,0,800,600], 'DefaultAxesColorOrder',colorset)
subplot(2,1,1), [ax,h1,h2] = plotyy(T,Pv,T,vl);
title('Acoustic pressure at receiver vs speed of object')
xlabel('T (s)')
set(ax(1), 'ylim', [-0.15,0.15], 'ytick',[-0.15:0.052:0.15],'ycolor','k')
set(get(ax(1), 'ylabel'),'string','Acoustic Pressure Pa')
set(ax(2), 'ycolor', colorset(1,:))
set(get(ax(2), 'ylabel'),'string','Object speed (m/s)')
set(h1, 'color', 'k')
subplot(2,1,2), plot(f,2*abs(fftPv(1:NFFT/2+1)),'b'); set(gca,'xlim',[0,400])
hold on, plot([0.15*15/0.01,0.15*15/0.01],[0,0.015],'r--')
hold on, plot([0.18*15/0.01,0.18*15/0.01],[0,0.015],'r--')
title('FFT acoustic pressure')
ylabel('|Pv(f)|')
xlabel('Frequency (Hz)')

tRender = tic; 
sine_4000 = audioplayer(Pv, 4000);
tRenderElapsed = toc(tRender);
fprintf('Time elapsed for sound rendering is ... %5.5f (second).\n',tRenderElapsed)

AnimObjMotion(T,O,X,5,'anim',200)


% REDUCE THE SAMPLING FREQUENCY BY 2,
% DOES NOT AFFECT THE RENDERED SOUND
%

% [T,Pv,PRaw,X,U,vl,O,TexTable_g] = main_v2([0,15,0],2000,TexTable_g);
% 
% Fs = 2000;
% NFFT = 2^nextpow2(length(T));
% fftPv = fft(Pv,NFFT)/length(T);
% f = Fs/2*linspace(0,1,NFFT/2+1);
% 
% colorset = jet(size(X,3));
% figure, set(gcf,'outerposition',[0,0,800,600], 'DefaultAxesColorOrder',colorset)
% subplot(2,1,1), [ax,h1,h2] = plotyy(T,Pv,T,vl);
% title('Acoustic pressure at receiver vs speed of object')
% xlabel('T (s)')
% set(ax(1), 'ylim', [-0.06,0.06], 'ytick',[-0.06:0.02:0.06],'ycolor','k')
% set(get(ax(1), 'ylabel'),'string','Acoustic Pressure Pa')
% set(ax(2), 'ycolor', colorset(1,:))
% set(get(ax(2), 'ylabel'),'string','Object speed (m/s)')
% set(h1, 'color', 'k')
% subplot(2,1,2), plot(f,2*abs(fftPv(1:NFFT/2+1)),'b'); set(gca,'xlim',[0,400])
% hold on, plot([0.2 *15/0.01,0.2 *15/0.01],[0,6E-3],'r--')
% hold on, plot([0.21*15/0.01,0.21*15/0.01],[0,6E-3],'r--')
% title('FFT acoustic pressure')
% ylabel('|Pv(f)|')
% xlabel('Frequency (Hz)')
% 
% sine_2000 = audioplayer(Pv, 2000);
% 
% AnimObjMotion(T,O,X,5,'anim',100)
% 
% 
