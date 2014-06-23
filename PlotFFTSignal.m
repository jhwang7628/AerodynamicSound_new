function [f,fftPv] = PlotFFTSignal(T, Pv, flag)

% Shift the start back to zero
T = T - T(1);

Fs = 1/(T(2)-T(1));
NFFT = 2^nextpow2(length(T));
% Apply a Hanning window before FFT
Pv = Pv.*hann(length(T));
fftPv = fft(Pv,NFFT)/length(T);
f = Fs/2*linspace(0,1,NFFT/2+1);

fftPv = fftPv(1:NFFT/2+1); % For real function


% Plotting flag is on
if flag == 1
  figure, plot(f,2*abs(fftPv),'b');
  title('FFT of the input signal')
  ylabel('|Pv(f)|')
  xlabel('Frequency (Hz)')
end

end



