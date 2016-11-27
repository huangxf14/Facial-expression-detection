len = 100000;
coef = [1,0,1,1;1,1,1,1]; % parameter
%coef = [1,1,0,1;1,0,1,1;1,1,1,1];
x = rand(1,len)>0.5;
x = crc32(x);
snr = 0:0.5:8;
tail_num=100;
err_rate1 = zeros(1,length(snr));
err_rate2 = zeros(1,length(snr));
err_rate3 = zeros(1,length(snr));
err_rate4 = zeros(1,length(snr));
for iter = 1:length(snr)    
    sigma_new=0.25/10^(snr(iter)/10);
    hard_value = fzero(@(r) exp(10.^(snr(iter)/10) .* 2) - besseli(0, r .* 10.^(snr(iter)/10) .* 4), [.5 1]);
    dist1=@(x,y) (norm((abs(y)>hard_value)-x).^2);%hard;
    dist2=@(x,y) sum(-(x==0).*(0.5/sigma_new)-(x==1).*log(abs(besseli(0,abs(y)/sigma_new))));%soft
    tail=false;
    x_encode = complex(encode_conv(x,coef,tail,tail_num)); 
    y = awgn(x_encode.*exp(rand(1,length(x_encode))*2j*pi),snr(iter),'measured');    
    y_decode = logical(decode_conv(y,coef,tail,dist1,tail_num));
    for cnt=1:232:length(y_decode)-tail*(size(coef,2)-1)
        if sum(y_decode(cnt:cnt+231)~=crc32(y_decode(cnt:cnt+199)))>0
        	err_rate1(iter) = err_rate1(iter)+1;
        end
    end;
    err_rate1(iter)=err_rate1(iter)/(len/200);        
    y_decode = logical(decode_conv(y,coef,tail,dist2,tail_num));
    for cnt=1:232:length(y_decode)-tail*(size(coef,2)-1)
        if sum(y_decode(cnt:cnt+231)~=crc32(y_decode(cnt:cnt+199)))>0
        	err_rate2(iter) = err_rate2(iter)+1;
        end
    end;
    err_rate2(iter)=err_rate2(iter)/(len/200);
    tail=true;
    x_encode = complex(encode_conv(x,coef,tail,tail_num)); 
    y = awgn(x_encode.*exp(rand(1,length(x_encode))*2j*pi),snr(iter),'measured');    
    y_decode = logical(decode_conv(y,coef,tail,dist1,tail_num));
    for cnt=1:232:length(y_decode)-tail*(size(coef,2)-1)
        if sum(y_decode(cnt:cnt+231)~=crc32(y_decode(cnt:cnt+199)))>0
        	err_rate3(iter) = err_rate3(iter)+1;
        end
    end;
    err_rate3(iter)=err_rate3(iter)/(len/200);
    y_decode = logical(decode_conv(y,coef,tail,dist2,tail_num));
   for cnt=1:232:length(y_decode)-tail*(size(coef,2)-1)
        if sum(y_decode(cnt:cnt+231)~=crc32(y_decode(cnt:cnt+199)))>0
        	err_rate4(iter) = err_rate4(iter)+1;
        end
    end;
    err_rate4(iter)=err_rate4(iter)/(len/200);
end
figure
semilogy(snr,err_rate1,snr,err_rate2,snr,err_rate3,snr,err_rate4);
legend('tail=false,hard','tail=false,soft','tail=true,hard','tail=true,soft')
title('snr VS error rate');xlabel('snr/dB');ylabel('error rate');
saveas(gcf,'Img3_3_1.eps');
