function [ gcd,x,y ] = exgcd( a,b,max_int )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    if b==sym(0)
        x=sym(1);
        y=sym(0);
        gcd=a;
        return;
    end;
    [gcd,x1,y1]=exgcd(b,mod(a,b),max_int);
    x=y1;
    y=mod(x1-floor(a/b)*y1,max_int);
end

