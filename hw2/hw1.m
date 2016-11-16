N = 8192;
alpha = 0.5;
Rs = 1800;
Rws = 115200;
k = Rws./Rs;
f0= 1850;

%% Data Generation
data = randi([0 1],1,N);

%% Channel Coding
% None

%% Baseband Modulation
modSignal = 2.*data - 1;

%% Pulse Forming
t = 0:1./Rws:N./Rs;
waveformSingle = rcosdesign(alpha,2.*N-1,k,'sqrt');
modSignalExpanded = complex(zeros(1,N.*k+1));
modSignalExpanded(k./2+1:k:end) = modSignal;
waveform = conv(waveformSingle, modSignalExpanded);
waveform = waveform((N-0.5).*k+1:(2.*N-0.5).*k+1);

%% Carrier Modulation
waveformMod = waveform .* cos(2 .* pi .* f0 .* t);

%% 1. Plot waveform and its spectrum.
Nsample = 10;
figure;
hold on;
stem(0.5:1:Nsample,modSignal(1:Nsample).*waveformSingle((end+1)./2),'.');
plot(0:1./k:Nsample,waveform(1:Nsample.*k+1),'--');
%plot(0:1./k:Nsample,-waveform(1:Nsample.*k+1),'--');
plot(0:1./k:Nsample,waveformMod(1:Nsample.*k+1));
title('Waveform');
xlabel('t/Ts');
legend('Symbol','Baseband Waveform','Modulated Waveform');
drawnow;

figure;
spectrum = fft(waveformMod);
fRange = 0:Rws./length(spectrum):4000;
plot(fRange, abs(spectrum(1:length(fRange)))./max(abs(spectrum)));
title('Spectrum of Modulated Signal');
xlabel('f/Hz');
drawnow;

%% Add Noise
Eb_n0 = 4;
SNR = 2 .* Eb_n0;
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
waveformDemod = waveformRecv .* cos(2 .* pi .* f0 .* t);
rcosWindow = zeros(1,N.*k./2+1);
rcosWindow(1:convergent((N.*k+1)./k)) = 1;
slopeRange = convergent(ceil(1+(1-alpha).*(N.*k+1)./k):floor(1+(1+alpha).*(N.*k+1)./k));
rcosWindow(slopeRange) = cos(((slopeRange-1).*k./(N.*k+1)-(1-alpha)).*(pi./4./alpha));
rcosWindow = [rcosWindow, fliplr(rcosWindow(2:end))];
waveformDemod = ifft(rcosWindow.*fft(waveformDemod));
dataRecv = waveformDemod(k./2+1:k:end) >= 0;

%% Calculate BER
fprintf('BER = %f at Eb/n0 = %.2fdB.\n',sum(dataRecv~=data)./N,Eb_n0);
