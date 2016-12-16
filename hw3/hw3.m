fp = fopen('bin.txt');
data = fread(fp);
fclose(fp);
data = (data==49)';
N = length(data);

%% Channel Coding
dataEnc = encode_conv([data, zeros(1, mod(-length(data), 16))], [1,0,1,1;1,1,1,1], true, 16);

%% Baseband Modulation (QPSK)
modSignal = (2.*dataEnc(1:2:end)-1) + 1j.*(2.*dataEnc(2:2:end)-1);

%% Add Noise
Eb_n0 = 4;
symRecv = awgn(modSignal, Eb_n0, 'measured');

%% Baseband Demodulation
bitRecv = reshape([real(symRecv); imag(symRecv)],1,[]);

%% Channel Decoding
dist_soft=@(x,y) norm((2.*x-1)-y).^2;
dataRecv = decode_conv(bitRecv, [1,0,1,1;1,1,1,1], true, dist_soft, 16);
dataRecv = dataRecv(1:N);

%% Calculate BER
fprintf('BER = %f at Eb/n0 = %.2fdB.\n',sum(dataRecv~=data)./length(data),Eb_n0);

fp = fopen('bin_rec_QPSK_4dB_conv_block_16_effi_2_tailed_soft_1.txt','w');
fwrite(fp, uint8(dataRecv + 48)');
fclose(fp);




symRecv = awgn(modSignal, Eb_n0, 'measured');

%% Baseband Demodulation
bitRecv = reshape([real(symRecv); imag(symRecv)],1,[]);

%% Channel Decoding
dist_soft=@(x,y) norm((2.*x-1)-y).^2;
dataRecv = decode_conv(bitRecv, [1,0,1,1;1,1,1,1], true, dist_soft, 16);
dataRecv = dataRecv(1:N);

%% Calculate BER
fprintf('BER = %f at Eb/n0 = %.2fdB.\n',sum(dataRecv~=data)./length(data),Eb_n0);

fp = fopen('bin_rec_QPSK_4dB_conv_block_16_effi_2_tailed_soft_2.txt','w');
fwrite(fp, uint8(dataRecv + 48)');
fclose(fp);
