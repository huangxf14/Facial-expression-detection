clear;
doc=dir('train');
doc=doc(3:end);
faceDetector = vision.CascadeObjectDetector();
label=[];
feature=[];
cnt=0;
weight=[0.1,1,1,0.2,0.2,1,1,0.1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.6,0.6,1,1,1,0.1,0.4,0.8,0.4,0.4,0.8,0.4,0.1,0.1,0.4,0.8,0.8,0.8,0.8,0.4,0.1,0.1,0.4,1,1,1,1,0.4,0.1,0.1,0.1,1,1,1,1,0.1,0.1];
tic;
for x=1:length(doc)
    file=dir(['train/' doc(x).name]);
    file=file(3:end);
    for y=1:length(file)
        videoFileReader = vision.VideoFileReader(['train\' doc(x).name '\' file(y).name]);
        %videoFileReader = vision.VideoFileReader('train\6.jpg');
        videoFrame      = step(videoFileReader);
        bbox            = step(faceDetector, videoFrame);
        if (~isempty(bbox))
          for k=1:size(bbox,1)
            box=bbox(k,:);
            pic=videoFrame(box(2):box(2)+box(4)-1,box(1):box(1)+box(3)-1,:);
            pic=rgb2gray(pic);
            pic=imresize(pic,[128,128]);
            newfeature=extractHOGFeatures(pic);
            for blockx=1:8
                for blocky=1:8
                    newfeature=[newfeature weight(blockx*8+blocky-8)*WLD(pic(blockx*8-7:blockx*8,blocky*8-7:blocky*8))];
                end;
            end;
            feature=[feature;newfeature];
            label=[label,file(y).name(end-4)];
            cnt=cnt+1;
            disp(cnt);
            toc;
          end;
        end;
    end;
end;
save('model.mat','label','feature');
