len = 10240;
coef = [1,0,1,1;1,1,1,1]; % parameter
%coef = [1,1,0,1;1,0,1,1;1,1,1,1];
[depth,~] = size(coef);
x = rand(1,len)>0.5;
encode_flag=1;
snr = 4;
sigma_new=0.25/10^(snr/10);
dist = @(x,y) (norm(x-y).^2);%soft
%dist = @(x,y) (norm((real(y)>0.5)-x).^2);%hard
tail=false;
x_encode=x;
if encode_flag==1
    load key.mat;
	x_encode=encrypt_encode([x zeros(1,mod(512-mod(length(x),512),512))],key);
end;
x_encode = complex(encode_conv(x_encode,coef,tail)); 
y = awgn(x_encode,snr,'measured');    
y_decode = logical(decode_conv(y,coef,tail,dist));
if encode_flag==1
    y_decode=encrypt_decode(y_decode,key);
	y_decode=y_decode(1:length(x));
end;
stem(bitxor(x,y_decode));
%title('1/2,tail=true,soft')
    
