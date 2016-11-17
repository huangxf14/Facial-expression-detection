function [y]=fconv(x, h)
% Fast Convolution, same result as conv(x, h)

Ly=length(x)+length(h)-1;
Ly2=pow2(nextpow2(Ly));
y=ifft(fft(x, Ly2).*fft(h, Ly2));
y=y(1:Ly);
