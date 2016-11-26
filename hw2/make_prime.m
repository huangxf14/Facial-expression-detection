function [ key,bitkey ] = make_prime( len )

not_find=true;
test_num=10;
temp=sym([0,1,2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]);

while (not_find==true)
    not_find=false;
    %bitkey=[1 0 1 1];
    bitkey=[1 1 rand(1,len-3)>0.5 1];
    key=sym(0);
    
    for x=1:len
      key=key*temp(3)+temp(bitkey(x)+1);
    end;
    
    if min(mod(key,temp(4:27)))==0
        not_find=true;
        continue;
    end;

    for s=1:test_num
        test_bitkey=[rand(1,len-1)>0.5];
        test_key=sym(0);
        for x=1:len-1
            test_key=test_key*temp(3)+temp(test_bitkey(x)+1);
        end;
        if mod_power(test_key,[bitkey(1:len-1) 0],key)~=1
            not_find=true;
            break;
        end;
    end;
end;
end
