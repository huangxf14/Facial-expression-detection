len = 10000000;
x = (rand(1,len)>0.5).^2;
snr = 0:0.5:15;
err_rate1 = zeros(1,length(snr));
err_rate2 = zeros(1,length(snr));
for iter = 1:length(snr)
    y = awgn(complex(x).*exp(rand(1,len)*2i*pi),snr(iter),'measured');
    y_judge = abs(y)>0.5;
    err_rate1(iter) = sum(bitxor(x,y_judge))/len;
    hard_value = fzero(@(r) exp(10.^(snr(iter)/10) .* 2) - besseli(0, r .* 10.^(snr(iter)/10) .* 4), [.5 1]);
    y_judge = abs(y)> hard_value;
    err_rate2(iter) = sum(bitxor(x,y_judge))/len;
end
semilogy(snr,err_rate1,snr,err_rate2);title('snr VS error rate');xlabel('snr/dB');ylabel('error rate');
