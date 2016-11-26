function odata = channel_decode( idata,coding_effi,tail,soft_decision)
%CHANNEL_DECODE Summary of this function goes here
%   Detailed explanation goes here
    if coding_effi==1/2
        coef=[1,0,1,1;1,1,1,1];
    else
        coef = [1,1,0,1;1,0,1,1;1,1,1,1];
    end;
    if soft_decision==0
        dist = @(x,y) (norm((real(y)>0.5)-x).^2);
    else
        dist = @(x,y) (norm(x-y).^2);
    end;
    %odata=idata>mean(idata);
    odata = decode_conv( idata,coef,tail,dist);

end

