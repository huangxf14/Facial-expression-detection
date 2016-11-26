function [A]=findA()
    load trans256.mat;
    find=false;
    while find==false
    find=true;
%     A=sym(min(floor(rand(8,8)*128)*2+1,255));
    A=sym(min(floor(rand(8,8)*256),255));
    dA=det(A);
    if mod(dA,2)==0
        find=false;
    end;
%     B=dA*inv(A);
%     for x=1:size(A,1)
%         for y=1:size(A,2)
%             gcd=new_gcd(B(x,y),dA);
%             xx=mod(B(x,y)/gcd,256);
%             yy=trans256(mod(dA/gcd,256)+1);
%             if yy==0
%                  find=false;
%                 break;
%             end;
%             B(x,y)=mod(xx*yy,256);
%         end;
%         if find==false;
%             break;
%         end;
%     end;
    end;
    
            
    
