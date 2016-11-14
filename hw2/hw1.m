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
waveformSingle = rcosfir(alpha,N-0.5,k,1,'sqrt');
modSignalExpanded = complex(zeros(1,N.*k+1));
modSignalExpanded(k./2+1:k:end) = modSignal;
waveform = conv(waveformSingle, modSignalExpanded);
waveform = waveform((N-0.5).*k+1:(2.*N-0.5).*k+1);

%% Carrier Modulation
waveformMod = waveform .* cos(2 .* pi .* f0 .* t);

%% 1. Plot waveform and its spectrum.
Nsample = 10;
figure;
hold('on');
stem(0.5:1:Nsample,modSignal(1:Nsample).*waveformSingle((end+1)./2),'.');
plot(0:1./k:Nsample,waveform(1:Nsample.*k+1),'--');
%plot(0:1./k:Nsample,-waveform(1:Nsample.*k+1),'--');
plot(0:1./k:Nsample,waveformMod(1:Nsample.*k+1));
title('Waveform');
xlabel('t/Ts');
legend('Symbol','Baseband Waveform','Modulated Waveform');

figure;
spectrum = fft(waveformMod);
fRange = 0:Rws./length(spectrum):4000;
plot(fRange, abs(spectrum(1:length(fRange)))./max(abs(spectrum)));
title('Spectrum of Modulated Signal');
xlabel('f/Hz');

%% Add Noise
%TODO
