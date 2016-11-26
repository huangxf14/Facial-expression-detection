function init( handles )
global encrypt_flag coding_effi tail soft_decision 
encrypt_flag = 0;
coding_effi = 0;
tail = 0;
soft_decision = 0;
img = imread('test.jpg');
gray_img = rgb2gray(img);
temp_img = zeros(size(gray_img))+255;
axes(handles.axes1);
imshow(gray_img);
axes(handles.axes2);
imshow(temp_img);
set(handles.edit5,'String', '0');
set(handles.checkbox3,'Value',0);
set(handles.checkbox4,'Value',0);
set(handles.checkbox5,'Value',0);
set(handles.checkbox6,'Value',0);
set(handles.checkbox7,'Value',0);
end

