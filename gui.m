function varargout = gui(varargin)
%GUI M-file for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('Property','Value',...) creates a new GUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to gui_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      GUI('CALLBACK') and GUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in GUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 09-Dec-2015 16:45:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
clear all; 
reset;


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles)


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
disp('RESET')
return;

% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)

global X;
global hAxes1;
% open an image
[FileName,PathName] = uigetfile('*.bmp;*.tif;*.jpg;*.png;*.hdf','Select the image file');
FullPathName = [PathName,'/',FileName];
X = imread(FullPathName);

%display the original image
set(gcf, 'CurrentAxes', hAxes1);
imshow(X);
disp('LOAD')

% --- Executes on selection change in effect.
function effect_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function effect_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function smoothness_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function smoothness_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function smoothing_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function smoothing_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function detail_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function detail_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function color_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function color_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
%     set(gcf, 'CurrentAxes', hAxes1);
%     fig = get(gcf,'CurrentAxes');
%     saveas(fig,'output.jpg')
    disp('SAVE')
    F = getframe(gcf);
    image(F.cdata);
    imwrite(F.cdata, 'file.jpg');
return
        

% --- Executes on button press in black.
function black_Callback(hObject, eventdata, handles)

% --- Executes on slider movement.
function thickness_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function thickness_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function length_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function length_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function angle_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function angle_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in inv.
function inv_Callback(hObject, eventdata, handles)

% --- Executes on button press in morph.
function morph_Callback(hObject, eventdata, handles)

% --- Executes on button press in dither.
function dither_Callback(hObject, eventdata, handles)

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
reset;


% --- Executes on button press in apply.
function apply_Callback(hObject, eventdata, handles)

global X;
global hAxes2;

% get effect effect
hObject = findobj(gcf, 'Tag', 'effect');
val = get(hObject,'Value');

% get morph option
hObject = findobj(gcf, 'Tag', 'morph');
morph = get(hObject, 'Value');

% get dither option
hObject = findobj(gcf, 'Tag', 'dither');
dither = get(hObject, 'Value');

% get inv option
hObject = findobj(gcf, 'Tag', 'inv');
inv = get(hObject, 'Value');

% get black option
hObject = findobj(gcf, 'Tag', 'black');
black = get(hObject, 'Value');

% get the smoothness
hSlider = findobj(gcf, 'Tag', 'smoothness');
smooth = get(hSlider,'Value');

% get the color quantization
hSlider = findobj(gcf, 'Tag', 'color');
color = round(get(hSlider,'Value'));

% get the detail
hSlider = findobj(gcf, 'Tag', 'detail');
detail = get(hSlider,'Value');

% get the thickness
hSlider = findobj(gcf, 'Tag', 'thickness');
thick = get(hSlider,'Value');

% get the morphological info
hSlider = findobj(gcf, 'Tag', 'length');
length = get(hSlider,'Value');
hSlider = findobj(gcf, 'Tag', 'angle');
angle = get(hSlider,'Value');

% show the result
set(gcf, 'CurrentAxes', hAxes2);
tic
if val == 1
    out = cartoon(X, smooth, detail, color, thick,  morph, length, angle, dither);
    if inv 
        out = 1-out;
    end
    if black
        out = rgb2gray(out);
    end
    imshow(out);

else    % Simple black and white effect
    bw( X , detail, color, thick, length, angle,  morph, inv, black ) 
%     F = getframe(gcf);
%     image(F.cdata);
%     imshow(F.cdata)
%     imwrite(F.cdata, 'file.jpg');
end
disp('DONE')
toc
return;



