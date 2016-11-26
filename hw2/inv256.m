function [B]=inv256(A)
    load trans256.mat;
    find=true;
    A=sym(A);
    dA=det(A);
    B=dA*inv(A);
    for x=1:size(A,1)
        for y=1:size(A,2)
            %gcd=new_gcd(B(x,y),dA);
            xx=mod(B(x,y),256);
            yy=trans256(mod(dA,256)+1);
            if yy==0
                find=false;
                break;
            end;
            B(x,y)=mod(xx*yy,256);
        end;
        if find==false;
            break;
        end;
    end;
    if find==false
        B=zeros(size(A,1),size(A,2));
    end;

    
            
    

