len = 100;
coef = [1,0,1,1;1,1,1,1]; % parameter
%coef = [1,1,0,1;1,0,1,1;1,1,1,1];
[depth,~] = size(coef);
x = rand(1,len)>0.5;
tail_num=100;
snr = 1;
sigma_new=0.25/10^(snr/10);
hard_value = fzero(@(r) exp(10.^(snr/10) .* 2) - besseli(0, r .* 10.^(snr/10) .* 4), [.5 1]);
dist1=@(x,y) (norm((abs(y)>hard_value)-x).^2);%hard;
dist2=@(x,y) sum(-(x==0).*(0.5/sigma_new)-(x==1).*log(abs(besseli(0,abs(y)/sigma_new))));%soft
tail=true;
x_encode = complex(encode_conv(x,coef,tail,tail_num)); 
y = awgn(x_encode.*exp(rand(1,length(x_encode))*2j*pi),snr,'measured');    
y_decode = logical(decode_conv(y,coef,tail,dist2,tail_num));
stem(bitxor(x,y_decode));
title('1/2,tail=true,soft')
    
