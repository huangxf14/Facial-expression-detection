function [  ] = rsa_pre(len)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
temp=sym([0,1,2]);
p1=make_prime(len/2)
while true
    p2=make_prime(len/2)
    if p1~=p2
        break;
    end;
end;
n=p1*p2;
phi=(p1-1)*(p2-1);

rsa=[];
rsa_pub=[];
while true
     bittemp1=[1 rand(1,len-2)>0.5 1];
     temp1=sym(0);
     for y=1:len
       temp1=temp1*temp(3)+temp(bittemp1(y)+1);
     end;
    %[temp1,bittemp1]=make_prime(len);
    [gcd,temp2]=exgcd(temp1,phi,phi);
    gcd
    if gcd>1
        continue;
    end;
    bittemp2=zeros(1,len);
    for y=len:-1:1
        if (mod(temp2,2)==1)
            bittemp2(y)=1;
        end;
        temp2=floor(temp2/2);
    end;
    rsa=[rsa;bittemp1;bittemp2];
    rsa_pub=[rsa_pub;bittemp2;bittemp1];
    break;
end
save n.mat n
save rsa.mat rsa
save rsa_pub.mat rsa_pub


