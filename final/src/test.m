tic;
load model.mat;
faceDetector=vision.CascadeObjectDetector();
weight=[0.1,1,1,0.2,0.2,1,1,0.1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.6,0.6,1,1,1,0.1,0.4,0.8,0.4,0.4,0.8,0.4,0.1,0.1,0.4,0.8,0.8,0.8,0.8,0.4,0.1,0.1,0.4,1,1,1,1,0.4,0.1,0.1,0.1,1,1,1,1,0.1,0.1];
epr=['an';'co';'di';'fe';'ha';'ne';'sa';'su'];
file=dir('test/公开数据测试集');
file=file(3:end);
labelcnt=zeros(1,8);
for x=1:8
    labelcnt(x)=length(find(label==char(x+47)));
end;
for filecnt=2:2%length(file)
    img=imread(['test/公开数据测试集/' file(filecnt).name]);
    lab=floor(rand(1,1)*8);
    min=100000000000000;
    bbox=step(faceDetector, img);
    cal=zeros(1,8);
    
    if (~isempty(bbox))
       disp('true');
       for k=1:size(bbox,1)
          box=bbox(k,:);
          pic=img(box(2):box(2)+box(4)-1,box(1):box(1)+box(3)-1,:);
          if (size(pic,3)==3)
              pic=rgb2gray(pic);
          end;
          pic=imresize(pic,[128,128]);
          newfeature=extractHOGFeatures(pic);
          for blockx=1:8
              for blocky=1:8
                  newfeature=[newfeature weight(blockx*8+blocky-8)*WLD(pic(blockx*8-7:blockx*8,blocky*8-7:blocky*8))];
              end;
          end;
          dis=[];
          for cnt=1:size(feature,1)
              dis=[dis,chi_square_dis(feature(cnt,:),newfeature)];
          end;
          [sortdis,index]=sort(dis);
          for i=1:50
              cal(label(index(i))-47)=cal(label(index(i))-47)+1;
          end;
        end;
      end;
      imshow(img);
      cal=cal./labelcnt;
      [sortcal,index]=sort(cal);
      if (sortcal(end)~=0) lab=index(end)-1;end;
      disp(epr(lab+1,:))
      fid=fopen('公开数据结果.txt','a');
      fprintf(fid,'%s\n',[file(filecnt).name ' ' epr(lab+1,:)]);
      fclose(fid);
      toc;
end;