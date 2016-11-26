Eb_N0 = -2:.01:10;

% BPSK
BpskBer = 0.5*erfc(sqrt(10.^(Eb_N0/10)));
figure;
semilogy(Eb_N0, BpskBer);
title('Bit Error Rate');
ylim([1e-4 1e-0]);
xlabel('E_b/N_0 (dB)');
ylabel('Bit Error Rate');
hold on;
drawnow;

% Conv 1/2 16bit-tailed

N = 16;
%k = 480000;
k = 2000;
Eb_N0 = -2:.5:7;
data = randi([0 1],1,N);
dataEnc = encode_conv(data, [1,0,1,1;1,1,1,1], true, 16);
modSignal = 2.*dataEnc-1;
errRateHard = 0.*Eb_N0;
errRateSoft = errRateHard;
for iter = 1:length(Eb_N0)
    dist_hard=@(x,y) sum((y>0) ~= x);
    dist_soft=@(x,y) norm((2.*x-1)-y).^2;
	errRateHardLocal = 0;
	errRateSoftLocal = 0;
	parfor tt = 1:k
		y = awgn(modSignal,Eb_N0(iter),'measured');
		y_decode = logical(decode_conv(y,[1,0,1,1;1,1,1,1],true,dist_hard,16));
		errRateHardLocal = errRateHardLocal + sum(data ~= y_decode);
		y_decode = logical(decode_conv(y,[1,0,1,1;1,1,1,1],true,dist_soft,16));
		errRateSoftLocal = errRateSoftLocal + sum(data ~= y_decode);
	end
	errRateHard(iter) = errRateHardLocal./N./k;
	errRateSoft(iter) = errRateSoftLocal./N./k;
end
errRateHard(errRateHard==0) = 1e-100;
errRateSoft(errRateSoft==0) = 1e-100;
plot(Eb_N0, errRateHard);
plot(Eb_N0, errRateSoft);
drawnow;


% LDPC 2/5
N = 25920;
%k = 200;
k=50;
%Eb_N0 = -2:.01:0;
Eb_N0 = -2:.4:0;
data = randi([0 1],N,1);
ldpcH = dvbs2ldpc(2/5);
enc = comm.LDPCEncoder(ldpcH);
dec = comm.LDPCDecoder(ldpcH);
dataEnc = step(enc, data);
modSignal = 2.*dataEnc-1;
errRate = 0.*Eb_N0;
tic;
for iter = 1:length(Eb_N0)
	hDemod = comm.PSKDemodulator(2,'BitOutput',true,'DecisionMethod','Approximate log-likelihood ratio','Variance', 1/10^(Eb_N0(iter)/10),'PhaseOffset',pi);
	errRateLocal = 0;
	parfor t = 1:k
		y = awgn(modSignal,Eb_N0(iter),'measured');
		y_decode = step(dec, step(hDemod, y));
		errRateLocal = errRateLocal + sum(data ~= y_decode);
	end
	errRate(iter) = errRateLocal./N./k;
end
toc
errRate(errRate==0) = 1e-100;
plot(Eb_N0, errRate);
legend('BPSK','Conv, 1/2, 16bit tailed, hard, QPSK','Conv, 1/2, 16bit tailed, soft, QPSK','LDPC, 2/5, QPSK');
drawnow;
