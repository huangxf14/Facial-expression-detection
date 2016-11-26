function [ gcd ] = new_gcd(a,b)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
    if b==sym(0)
        gcd=a;
        return;
    end;
    [gcd]=new_gcd(b,mod(a,b));

end