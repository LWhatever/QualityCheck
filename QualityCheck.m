%this application uses many functions in Statistics toolbox to analyse the
%sample data in order to evaluate the quality of a product,test a new
%technique and find a linear realition between different kinds of data.

function varargout = QualityCheck(varargin)
% QUALITYCHECK MATLAB code for QualityCheck.fig
%      QUALITYCHECK, by itself, creates a new QUALITYCHECK or raises the existing
%      singleton*.
%
%      H = QUALITYCHECK returns the handle to a new QUALITYCHECK or the handle to
%      the existing singleton*.
%
%      QUALITYCHECK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QUALITYCHECK.M with the given input arguments.
%
%      QUALITYCHECK('Property','Value',...) creates a new QUALITYCHECK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before QualityCheck_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to QualityCheck_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help QualityCheck

% Last Modified by GUIDE v2.5 22-Aug-2016 16:23:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @QualityCheck_OpeningFcn, ...
                   'gui_OutputFcn',  @QualityCheck_OutputFcn, ...
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


% --- Executes just before QualityCheck is made visible.
function QualityCheck_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to QualityCheck (see VARARGIN)

global y1;                                                                                 %y1 data of sample one
global y2;                                                                                 %y2 data of sample two
global x1;                                                                                 %influencing factor one
global x2;                                                                                 %influencing factor one
global m;                                                                                  %the qualified data 

% Choose default command line output for QualityCheck
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes QualityCheck wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = QualityCheck_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_test_Callback(hObject, eventdata, handles)
% hObject    handle to edit_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_test as text
%        str2double(get(hObject,'String')) returns contents of edit_test as a double


% --- Executes during object creation, after setting all properties.
function edit_test_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_test.
function pushbutton_test_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y1 m;
y1=str2num(get(handles.edit_test,'string'));                                                          %get the data of sample one
m=str2num(get(handles.edit_agreed,'string'));                                                     %get the qualified data
if isempty(m)                                                                                                            %check if the qualified data is inputed
    msgbox('Please input the Agreed Quality Parameter!','Warning');                  %if not,popup a messagebox
else
    [str1,str2,str3,str4]=mle_ttest_printf( y1,m );                                                    %get the maximum likelihood estimates,t-test the data
                                                                                                                                 %of sample one,get the 95% confidence limits of the 
                                                                                                                                 %mean,get the standard deviation and change these 
                                                                                                                                 %imformation into string
    hs=questdlg({str2;str3;str1;str4;'';'Want to see more detail?'},...                     %Yes---show the detailed analyse of the sample data
        'test result','Yes','No','Yes');
    if strcmp(hs,'Yes')
        hs=box_norm_plot(y1);                                                                                  %boxplot and normplot the sample data
        set (hs,'Position',[550,50,1000,400]);  
        hs=hist_scatter_plot(y1);                                                                                %histogram the sample data with a distribution fit and
                                                                                                                                 %draw scatter plot with a fitting line
        set (hs,'Position',[0,50,1000,400]);
        capa_plot(y1,m);                                                                                             %return the probability that a new observation from the 
                                                                                                                                 %estimated distribution will fall within the range of [m,inf)
                                                                                                                                 %and highlight the area in the plot
    else
        return
    end
end

function edit_agreed_Callback(hObject, eventdata, handles)
% hObject    handle to edit_agreed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_agreed as text
%        str2double(get(hObject,'String')) returns contents of edit_agreed as a double


% --- Executes during object creation, after setting all properties.
function edit_agreed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_agreed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sample_one_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sample_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sample_one as text
%        str2double(get(hObject,'String')) returns contents of edit_sample_one as a double


% --- Executes during object creation, after setting all properties.
function edit_sample_one_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sample_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sample_two_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sample_two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sample_two as text
%        str2double(get(hObject,'String')) returns contents of edit_sample_two as a double


% --- Executes during object creation, after setting all properties.
function edit_sample_two_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sample_two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Agreed_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Agreed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Agreed as text
%        str2double(get(hObject,'String')) returns contents of edit_Agreed as a double


% --- Executes during object creation, after setting all properties.
function edit_Agreed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Agreed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_cmp.
function pushbutton_cmp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y1 y2 m;
y1=str2num(get(handles.edit_sample_one,'string'));                                  %get the data of sample one
y2=str2num(get(handles.edit_sample_two,'string'));                                   %get the data of sample two
m=str2num(get(handles.edit_Agreed,'string'));                                           %get the qualified data
[str1,str2,str3,str4]=mle_ttest_printf( y1,m );                                                %get the basic analysation of sample data
[str5,str6,str7,str8]=mle_ttest_printf( y2,m );
if isempty(get(handles.edit_Agreed,'string'))                                               %if the user didn't provide the data,quality test result is unclea
    str4='quality test result: Unclear';
    str8=str4;
end
str9=ttest2_printf(y2,y1);                                                                                %compare the two samples and return the result in str9
hs=msgbox({'Sample One';str1;str2;str3;str4;'';'Sample Two';...                %show the imformation in messagebox
    str5;str6;str7;str8;'';str9},'Result');
ht = findobj(hs, 'Type', 'text');                                                                         %adjust the property of msgbox
set(ht, 'FontSize', 10, 'Unit', 'normal');
set(hs,'Position',[500,300,200,230]);


% --- Executes on button press in pushbutton_Analyse.
function pushbutton_Analyse_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Analyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y1 x1 x2;
y1=str2num(get(handles.edit_result,'string'))';                                              %get the data of sample one
x1=str2num(get(handles.edit_factor_one,'string'))';                                     %get the data of factor one
x2=str2num(get(handles.edit_factor_two,'string'))';                                      %get the data of factor two
regress_mesh( y1,x1,x2 );                                                                              %multiple linear regression and draw meshplot

function edit_result_Callback(hObject, eventdata, handles)
% hObject    handle to edit_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_result as text
%        str2double(get(hObject,'String')) returns contents of edit_result as a double


% --- Executes during object creation, after setting all properties.
function edit_result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_factor_one_Callback(hObject, eventdata, handles)
% hObject    handle to edit_factor_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_factor_one as text
%        str2double(get(hObject,'String')) returns contents of edit_factor_one as a double


% --- Executes during object creation, after setting all properties.
function edit_factor_one_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_factor_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_factor_two_Callback(hObject, eventdata, handles)
% hObject    handle to edit_factor_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_factor_one as text
%        str2double(get(hObject,'String')) returns contents of edit_factor_one as a double


function edit_factor_two_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_factor_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
