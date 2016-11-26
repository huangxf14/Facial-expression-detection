load key.mat;
% while true
%     testdata1=rand(1,512)>0.5;
%     testdata2=bitxor((rand(1,512)>0.998),testdata1);
%     if max(bitxor(testdata1,testdata2))>0
%         break;
%     end;
% end;
% figure;
% stem(bitxor(testdata1,testdata2));
% 
% code1=encrypt_encode(testdata1,key);
% code2=encrypt_encode(testdata2,key);
% figure;
% stem(bitxor(code1,code2))

% testdata1=rand(1,512)>0.5;
% code1=encrypt_encode(testdata1,key);
% while true
%     code2=bitxor((rand(1,512)>0.998),code1);
%     if max(bitxor(code1,code2))>0
%         break;
%     end;
% end;
% testdata2=encrypt_decode(code2,key);
% figure;
% stem(bitxor(testdata1,testdata2));
% 
% figure;
% stem(bitxor(code1,code2))

cor=zeros(1,10);
for x=1:10
    testdata1=rand(1,512)>0.5;
    code1=encrypt_encode(testdata1,key);
    temp=corrcoef(testdata1,code1);
    cor(x)=temp(1,2);
end;
