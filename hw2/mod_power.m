function [ result ] = mod_power( a,b,n )

result=sym(1);
temp=a;
if b(length(b))==1
    result=a;
end;
for x=length(b)-1:-1:1
    temp=mod(temp*temp,n);
    if b(x)~=0
        result=mod(result*temp,n);
    end;
end



