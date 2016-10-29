len = 1000;
coef = [1,0,1,1;1,1,1,1]; % parameter
%coef = [1,1,0,1;1,0,1,1;1,1,1,1];
[depth,~] = size(coef);
x = rand(1,len)>0.5;
tail_num=100;
snr = 0:1:10;
std = 10.^(-snr/40)/2;
syms r;
syms sigma;
f=exp(1/(2*sigma)) - besseli(0, r/sigma);
err_rate1 = zeros(1,length(snr));
err_rate2 = zeros(1,length(snr));
err_rate3 = zeros(1,length(snr));
err_rate4 = zeros(1,length(snr));
for iter = 1:length(snr)
    sigma_new=0.25/10^(snr(iter)/10);
    %f1=subs(f,sigma,sigma_new);
    %hard_value=abs(double(solve(f1)));
    hard_value = fzero(@(r) exp(10.^(snr(iter)/10) .* 2) - besseli(0, r .* 10.^(snr(iter)/10) .* 4), [.5 1]);
    dist1=@(x,y) (norm((abs(y)>hard_value)-x).^2);%hard;
    %log(exp(0.5/sigma_new)+abs(besseli(0,abs(y)/sigma_new)))
    dist2=@(x,y) sum(-(x==0).*(0.5/sigma_new)-(x==1).*log(abs(besseli(0,abs(y)/sigma_new))));%soft
    tail=false;
    x_encode = complex(encode_conv(x,coef,tail,tail_num)); 
    y = awgn(x_encode.*exp(rand(1,length(x_encode))*2j*pi),snr(iter),'measured');    
    y_decode = logical(decode_conv(y,coef,tail,dist1,tail_num));
    err_rate1(iter) = sum(bitxor(x,y_decode))/len;        
    y_decode = logical(decode_conv(y,coef,tail,dist2,tail_num));
    err_rate2(iter) = sum(bitxor(x,y_decode))/len;
    
    tail=true;
    x_encode = complex(encode_conv(x,coef,tail,tail_num)); 
    y = awgn(x_encode.*exp(rand(1,length(x_encode))*2j*pi),snr(iter),'measured');    
    y_decode = logical(decode_conv(y,coef,tail,dist1,tail_num));
    err_rate3(iter) = sum(bitxor(x,y_decode))/len;        
    y_decode = logical(decode_conv(y,coef,tail,dist2,tail_num));
    err_rate4(iter) = sum(bitxor(x,y_decode))/len;

end
figure
semilogy(snr,err_rate1,snr,err_rate2,snr,err_rate3,snr,err_rate4);
legend('tail=false,hard','tail=false,soft','tail=true,hard','tail=true,soft')
title('snr VS error rate');xlabel('snr/dB');ylabel('error rate');
