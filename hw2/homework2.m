function varargout = homework2(varargin)
% HOMEWORK2 MATLAB code for homework2.fig
%      HOMEWORK2, by itself, creates a new HOMEWORK2 or raises the existing
%      singleton*.
%
%      H = HOMEWORK2 returns the handle to a new HOMEWORK2 or the handle to
%      the existing singleton*.
%
%      HOMEWORK2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HOMEWORK2.M with the given input arguments.
%
%      HOMEWORK2('Property','Value',...) creates a new HOMEWORK2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before homework2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to homework2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help homework2

% Last Modified by GUIDE v2.5 08-Nov-2016 17:48:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @homework2_OpeningFcn, ...
                   'gui_OutputFcn',  @homework2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before homework2 is made visible.
function homework2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to homework2 (see VARARGIN)

% Choose default command line output for homework2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes homework2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
init(handles);

% --- Outputs from this function are returned to the command line.
function varargout = homework2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
global encrypt_flag
encrypt_flag = mod(encrypt_flag+1,2);
disp('encrypted:');
disp(encrypt_flag);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1

% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4
global tail
tail = mod(tail+1,2);

% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7
global soft_decision
soft_decision = mod(soft_decision+1,2);


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global encrypt_flag coding_effi tail soft_decision 
disp([encrypt_flag,coding_effi,tail,soft_decision]);
SNR = str2num(get(handles.edit5,'String'));
key = get(handles.edit1,'String');
img = imread('test.jpg');
gray_img = rgb2gray(img);
[m,n] = size(gray_img);
temp_img = reshape(gray_img,[],1);
trans_data = d2b(temp_img);
%%
len=128;
if encrypt_flag == 1
	load key.mat;
    t0 = clock;
	out_data=encrypt_encode([trans_data' zeros(1,mod(512-mod(length(trans_data),512),512))],key);
    t1 = clock;
    set(handles.text12,'String',num2str(etime(t1,t0)));
else
    out_data = trans_data';
end
%%
send_message = channel_encode(out_data,coding_effi,tail);
receive_message = awgn(send_message,SNR,'measured');
temp_data_0 = channel_decode(receive_message,coding_effi,tail,soft_decision);
%%
if encrypt_flag == 1
    t0 = clock;
    temp_data_1=encrypt_decode(temp_data_0,key);
	temp_data_1=temp_data_1(1:length(trans_data))';
    t1 = clock;
    set(handles.text13,'String',num2str(etime(t1,t0)));
else
    temp_data_1 = temp_data_0';
end
%%
obtain_data = b2d(temp_data_1);
show_img = reshape(obtain_data,m,n);
axes(handles.axes2);
imshow(show_img);
ber = sum(sum(abs(trans_data-temp_data_1)))/m/n/8;
set(handles.text10,'String',num2str(ber));

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5
global coding_effi
temp = get(handles.checkbox5,'Value');
if temp == 1
    coding_effi = 1/2;
    set(handles.checkbox6,'Value',0);
end

% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6
global coding_effi
temp = get(handles.checkbox6,'Value');
if temp == 1
    coding_effi = 1/3;
    set(handles.checkbox5,'Value',0);
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global coding_effi tail soft_decision 
key = get(handles.edit1,'String');
temp_data = rand(1000,1)>0.5;
data1 = encrypt_encode(temp_data,key);
data2 = encrypt_decode(data1,key);
if sum(sum(abs(data2-temp_data)))>0
    disp('encrypt error!');
else
    disp('encrypt OK');
end
data3 = channel_encode(temp_data,coding_effi,tail);
data4 = channel_decode(data3,coding_effi,tail,soft_decision);
if sum(sum(abs(data4-temp_data)))>0
    disp('channel coding error!');
else
    disp('channel coding OK');
end
