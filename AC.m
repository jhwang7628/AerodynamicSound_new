function [ac] = AC(y)

ffty = fft(y);
tmp = ffty.*conj(ffty);
ac = real(ifft(tmp));

end


