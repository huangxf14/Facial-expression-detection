function [ gcd ] = new_gcd(a,b)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    if b==sym(0)
        gcd=a;
        return;
    end;
    [gcd]=new_gcd(b,mod(a,b));

end