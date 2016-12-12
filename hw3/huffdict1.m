filename='test1.bmp';
pic=imread(filename);
data=tabulate(pic(:));
data=sortrows(data,-3);
fre(int16(data(:,1)))=data(:,3)/100;

% code_length=[];
% bit_length=[];
% for x=2:size(data,1)
%     code=huffmandict(data(1:x,1),[data(1:x-1,3);sum(data(x:size(data,1),3))]/100);
%     len=0;
%     for y=1:size(code,1)
%         if code{y,1}==data(x,1)
%             len=len+(length(code{y,2})+8)*sum(data(x:size(data,1),3))/100;
%         else
%             len=len+fre(int16(code{y,1}))*length(code{y,2});
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
code_tot
if code_tot>0
    code=huffmandict(data(1:code_tot,1),[data(1:code_tot-1,3);sum(data(code_tot:size(data,1),3))]/100);
	fic=fopen('mytable1.txt','wt');
	for y=1:size(code,1)
        if code{y,1}==data(code_tot,1)
            test=code{y,2};
        else
            fprintf(fic,'%d ',code{y,1});
            fprintf(fic,'%d',code{y,2});
            fprintf(fic,'\n');
        end;
	end;
    fprintf(fic,'%d',test);
    fclose(fic);
end;