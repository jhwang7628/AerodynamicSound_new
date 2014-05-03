function [f,fftPv] = PlotFFTSignal(T, Pv)

Fs = 1/(T(2)-T(1));
NFFT = 2^nextpow2(length(T));
fftPv = fft(Pv,NFFT)/length(T);
f = Fs/2*linspace(0,1,NFFT/2+1);

figure, plot(f,2*abs(fftPv(1:NFFT/2+1)),'b');
title('FFT of the input signal')
ylabel('|Pv(f)|')
xlabel('Frequency (Hz)')


end



