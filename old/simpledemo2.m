function varargout = simpledemo2(varargin)
% SIMPLEDEMO2 M-file for simpledemo2.fig
%      SIMPLEDEMO2, by itself, creates a new SIMPLEDEMO2 or raises the existing
%      singleton*.
%
%      H = SIMPLEDEMO2 returns the handle to a new SIMPLEDEMO2 or the handle to
%      the existing singleton*.
%
%      SIMPLEDEMO2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMPLEDEMO2.M with the given input arguments.
%
%      SIMPLEDEMO2('Property','Value',...) creates a new SIMPLEDEMO2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simpledemo2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simpledemo2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simpledemo2

% Last Modified by GUIDE v2.5 09-Nov-2011 16:12:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simpledemo2_OpeningFcn, ...
                   'gui_OutputFcn',  @simpledemo2_OutputFcn, ...
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


% --- Executes just before simpledemo2 is made visible.
function simpledemo2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simpledemo2 (see VARARGIN)

% Choose default command line output for simpledemo2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simpledemo2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
clear all;
reset;

% --- Outputs from this function are returned to the command line.
function varargout = simpledemo2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function reset
global hAxes1;
global hAxes2;

if (isempty(hAxes1))
    hAxes1 = findobj(gcf,'Tag', 'axes1');
end
if (isempty(hAxes2))
    hAxes2 = findobj(gcf,'Tag', 'axes2');
end

set(gcf, 'CurrentAxes', hAxes1);
imshow(1);
set(gcf, 'CurrentAxes', hAxes2);
imshow(1);
return;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% declare global variables to hold the image and handle

global X; % original image
global hAxes1;

% open an image
[FileName,PathName] = uigetfile('*.bmp;*.tif;*.jpg;*.hdf','Select the image file');
FullPathName = [PathName,'/',FileName];
X = imread(FullPathName);

%display the original image
set(gcf, 'CurrentAxes', hAxes1);
imshow(X);

% display the result image
displayResult;


function displayResult

global X;
global hAxes2;

% get the filter size
hSlider = findobj(gcf, 'Tag', 'slider1');
sz = get(hSlider,'Value');

% filtering
H = fspecial('gaussian', round(sz), 0.5 * round(sz));
Y = imfilter(X, H);

% show the result
set(gcf, 'CurrentAxes', hAxes2);
imshow(Y);
return;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
displayResult;

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
