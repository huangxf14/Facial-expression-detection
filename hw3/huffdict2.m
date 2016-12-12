filename='test1.bmp';
tpic=double(imread(filename));
pic=zeros(size(tpic,1),size(tpic,2)/2);
for x=1:size(pic,1)
    for y=1:size(pic,2)
        pic(x,y)=tpic(x,2*y-1)*256+tpic(x,2*y);
    end;
end;
data=tabulate(pic(:));
data=sortrows(data,-3);
fre(int32(data(:,1)))=data(:,3)/100;

% code_length=[];
% bit_length=[];
% for x=2:10:size(data,1)
%     if (data(x,2)==0)
%         code_length=[code_length x];
%         bit_length=[bit_length bit_length(length(bit_length))];
%         continue;
%     end;
%     code=huffmandict(data(1:x,1),[data(1:x-1,3);sum(data(x:size(data,1),3))]/100);
%     len=0;
%     for y=1:size(code,1)
%         if code{y,1}==data(x,1)
%             len=len+(length(code{y,2})+16)*sum(data(x:size(data,1),3))/100;
%         else
%             len=len+fre(int32(code{y,1}))*length(code{y,2});
%         end;
%     end;
% 	code_length=[code_length x];
% 	bit_length=[bit_length len];
% %     if len<min_length
% %         code_tot=y;
% %         min_length=len;
% %     end;
% end;
% figure;
% plot(code_length,bit_length);

code_tot=1;
while true
    if data(code_tot,3)==0
        break;
    end;
    code_tot=code_tot+1;
end;
code_tot=52;
if code_tot>0
    code=huffmandict(data(1:code_tot,1),[data(1:code_tot-1,3);sum(data(code_tot:size(data,1),3))]/100);
	fic=fopen('mytable2.txt','wt');
	for y=1:size(code,1)
        if code{y,1}==data(code_tot,1)
            test=code{y,2};
        else
            fprintf(fic,'%d %d ',floor(code{y,1}/256),mod(code{y,1},256));
            fprintf(fic,'%d',code{y,2});
            fprintf(fic,'\n');
        end;
	end;
    fprintf(fic,'%d',test);
    fclose(fic);
end;