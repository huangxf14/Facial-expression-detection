function odata = channel_encode( idata,coding_effi,tail)
%CHANNEL_ENCODE Summary of this function goes here
%   Detailed explanation goes here

    if coding_effi==1/2
        coef=[1,0,1,1;1,1,1,1];
    else
        coef = [1,1,0,1;1,0,1,1;1,1,1,1];
    end;
    %coef
    %odata=idata;
    odata = encode_conv(idata,coef,tail);

end

