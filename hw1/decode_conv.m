function [ output_list ] = decode_conv( y,coef,tail,dist,tail_num )
%y is the signal list 
%coef is the coefficient of conv_code
%tail means whether to add tail
%dist is the function of calculate distance

num=size(coef,1);%num is the efficient of conv_code
m=size(coef,2)-1;
k=2^m;%k is amount of the state
state=zeros(1,k);%the low level bit means the new bit
new_state=zeros(1,k);
L=floor(size(y,2)/num);
path=zeros(k,L+1);
path(1,1)=1;
for i=1:1:L
    for j=1:1:k
        if tail==true
            if ((i+m>L)&&(bitand(j-1,1)~=0))
                continue;
            end
            if (((mod(i,tail_num+m)==0)||(mod(i,tail_num+m)>tail_num))&&(bitand(j-1,1)~=0))
                continue;
            end;
        end
        pre=floor((j-1)/2)+1;
        if path(pre,i)~=0
            new_state(j)=dist(bitget(coef*make_vector(m,pre,bitand(j-1,1)),1)',y((i-1)*num+1:i*num))+state(pre);
            path(j,i+1)=pre;
        end
        pre=pre+floor(k/2);
        if path(pre,i)~=0
            temp=dist(bitget(coef*make_vector(m,pre,bitand(j-1,1)),1)',y((i-1)*num+1:i*num))+state(pre);
            if temp<new_state(j)
                new_state(j)=temp;
                path(j,i+1)=pre;
            end
        end
    end
    state=new_state;
end

max=inf;
max_point=0;
for i=1:1:k
    if path(i,L+1)~=0
        if state(i)<max
            max=state(i);
            max_point=i;
        end
    end
end

temp_list=zeros(1,L);
output_list=[];
for i=L:-1:1
    temp_list(i)=bitand((max_point-1),1);
    max_point=path(max_point,i+1);
end
if tail==true
    for i=1:tail_num+m:length(temp_list)
        output_list=[output_list temp_list(i:min(i+tail_num-1,length(temp_list)-m))];
    end;
else
    output_list=temp_list;
end;


function [ state_vector ] = make_vector(m,x,y)
state_vector = [y; bitget(x-1, (1:m)')];

