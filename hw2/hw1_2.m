N = 8192;
alpha = 0.5;
Rs = 2000;
Rws = 128000;
k = Rws./Rs;
f0= 1850;

%% Data Generation
data = randi([0 1],1,N);

%% Channel Coding
dataEnc = encode_conv(data, [1,0,1,1;1,1,1,1], true, 16);

%% Baseband Modulation (QPSK)
modSignal = (2.*dataEnc(1:2:end)-1) + 1j.*(2.*dataEnc(2:2:end)-1);
Ns = length(modSignal);

%% Pulse Forming
t = 0:1./Rws:Ns./Rs;
waveformSingle = rcosdesign(alpha,2.*Ns-1,k,'sqrt');
modSignalExpanded = complex(zeros(1,Ns.*k+1));
modSignalExpanded(k./2+1:k:end) = modSignal;
waveform = fconv(modSignalExpanded, waveformSingle);
waveform = waveform((Ns-0.5).*k+1:(2.*Ns-0.5).*k+1);

%% Carrier Modulation
waveformMod = real(waveform .* exp(2j .* pi .* f0 .* t));

%% 1. Plot waveform and its spectrum.
Nsample = 10;
figure;
hold on;
plot([Nsample:-1./k:0,-1,0:1./k:Nsample],[abs(waveform(Nsample.*k+1:-1:1)),0,-abs(waveform(1:Nsample.*k+1))],'--');
%plot(0:1./k:Nsample,-waveform(1:Nsample.*k+1),'--');
plot(0:1./k:Nsample,waveformMod(1:Nsample.*k+1));
xlim([0,Nsample]);
title('Waveform');
xlabel('t/Ts');
legend('Baseband Waveform','Modulated Waveform');
drawnow;

figure;
spectrum = fft(waveformMod);
fRange = 0:Rws./length(spectrum):4000;
plot(fRange, abs(spectrum(1:length(fRange)))./max(abs(spectrum)));
title('Spectrum of Modulated Signal');
xlabel('f/Hz');
drawnow;

%% Add Noise
Eb_n0 = 8;
SNR = Eb_n0 + 10.*log10(2) - 10.*log10(k);
waveformRecv = awgn(waveformMod, SNR, 'measured');

%% 2. Plot waveform and its spectrum.
figure;
hold on;
plot(0:1./k:Nsample,waveformMod(1:Nsample.*k+1));
plot(0:1./k:Nsample,waveformRecv(1:Nsample.*k+1));
title('Waveform');
xlabel('t/Ts');
legend('Sent Waveform', 'Received Waveform');
drawnow;

figure;
spectrum = fft(waveformRecv);
fRange = 0:Rws./length(spectrum):4000;
plot(fRange, abs(spectrum(1:length(fRange)))./max(abs(spectrum)));
title('Spectrum of Received Signal');
xlabel('f/Hz');
drawnow;

%% Carrier Demodulation
waveformDemod = waveformRecv .* exp(- 2j .* pi .* f0 .* t) .* 2;
waveformLowpass = fconv(waveformDemod, waveformSingle);
waveformLowpass = waveformLowpass((Ns-0.5).*k+1:(2.*Ns-0.5).*k+1);
symRecv = waveformLowpass(k./2+1:k:end);

%% Baseband Demodulation
bitRecv = reshape([real(symRecv); imag(symRecv)],1,[]);

%% Channel Decoding
dist_soft=@(x,y) norm((2.*x-1)-y).^2;
dataRecv = decode_conv(bitRecv, [1,0,1,1;1,1,1,1], true, dist_soft, 16);

%% Calculate BER
fprintf('BER = %f at Eb/n0 = %.2fdB.\n',sum(dataRecv~=data)./N,Eb_n0);
