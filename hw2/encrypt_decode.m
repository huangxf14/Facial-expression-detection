function odata = encrypt_decode(idata,key)
%ENTCRYPT_ENCODE Summary of this function goes here
%   Detailed explanation goes here
    load s.mat;
    odata=zeros(1,length(idata));
    temp_M=repmat(0:7,8,1)+8*repmat(0:7,8,1)';
    M=zeros(8,8);
    new_key=double(inv256(key));
    for x=1:512:length(idata)
        for xx=1:8
            for yy=1:8
                 M(xx,yy)=bin2dec(char(idata(x+temp_M(xx,yy)*8:x+temp_M(xx,yy)*8+7)+48));
            end;
        end;
        M=mod(new_key*(M-key)*new_key,256);
        for xx=1:8
            for yy=1:8
                 M(xx,yy)=bitshift(s_trans(bitshift(M(xx,yy),-4)+1),4)+s_trans(bitand(M(xx,yy),15)+1);
            end;
        end;
%         M=mod(new_key*(bin2dec(char(idata(x+temp_M*8:x+temp_M*8+7)+48))-key)*new_key,256);
%         M=bitshift(s_trans(bitshift(M,-4):bitshift(M,-4)),4)+s_trans(bitand(M,31):bitand(M,31));
        M=mod(new_key*(M-key)*new_key,256);
        for list=0:63
            odata(x+list*8:x+list*8+7)=bitget(M(floor(list/8)+1,mod(list,8)+1),8:-1:1);
        end;
    end;
end

