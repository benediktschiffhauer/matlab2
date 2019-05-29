function varargout = simGUI(varargin)
% SIMGUI M-file for simGUI.fig
%      SIMGUI, by itself, creates a new SIMGUI or raises the existing
%      singleton*.
%
%      H = SIMGUI returns the handle to a new SIMGUI or the handle to
%      the existing singleton*.
%
%      SIMGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMGUI.M with the given input arguments.
%
%      SIMGUI('Property','Value',...) creates a new SIMGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simGUI

% Last Modified by GUIDE v2.5 19-Jun-2018 14:55:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @simGUI_OutputFcn, ...
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


% --- Executes just before simGUI is made visible.
function simGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simGUI (see VARARGIN)

clear global;

% Choose default command line output for simGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = simGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Arbeitspunkt
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in AP_2_1.
function AP_2_1_Callback(hObject, eventdata, handles)
	% hObject    handle to AP_2_1 (see GCBO)
	% eventdata  reserved - to be defined in a future version of MATLAB
	% handles    structure with handles and user data (see GUIDATA)

	h = guihandles();

	value=get(hObject,'Value');
	if value == 1
		set(h.AP_2_2,'Value',0);

	elseif value == 0
		set(h.AP_2_2,'Value',1);

	end
	% Hint: get(hObject,'Value') returns toggle state of AP_2_1

% --- Executes on button press in AP_2_2.
function AP_2_2_Callback(hObject, eventdata, handles)
% hObject    handle to AP_2_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    h = guihandles();

	value=get(hObject,'Value');
	if value == 1
		set(h.AP_2_1,'Value',0);

	elseif value == 0
		set(h.AP_2_1,'Value',1);

    end
% Hint: get(hObject,'Value') returns toggle state of AP_2_2    



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Arbeitspunkt ENDE
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Berechnung Regler reglerK
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in berechneK.
function berechneK_Callback(hObject, eventdata, handles)
	% hObject    handle to berechneK (see GCBO)
	% eventdata  reserved - to be defined in a future version of MATLAB
	% handles    structure with handles and user data (see GUIDATA)

	% Struktur mit den Handles aller Objekte der GUI erzeugen
	h = guihandles();
    
    global AP K M_AP

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Auslesen der Matrix Q
	q11 = str2num(get(h.Q11,'String'));
	q22 = str2num(get(h.Q22,'String'));
	q33 = str2num(get(h.Q33,'String'));
	q44 = str2num(get(h.Q44,'String'));

	Q = diag([q11 q22 q33 q44]);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Auslesen von R
	R = str2num(get(h.R,'String'));
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Auslesen des Arbeitpunkts
	% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	% Ggf. an eigene Codierung des Arbeitspunktes anpassen!
	% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    AP = [0 0 0 0];
	value1 = get(h.slider_AP,'Value');
        AP(1) = value1*pi;
	value2 = get(h.AP_2_1,'Value');
	if (value2 == 1)
		AP(3) = pi;
	else % (value == 0)
		AP(3) = 0;
    end    
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [f_m, h_m] = nonlinear_model();
    
	[A, B, C, D, M_AP] = linearisierung(f_m, h_m, AP);
    
	[K poleRK] = berechneLQR(A, B, Q, R);
	
	% Anzeigen des Vektors 'K' im Textfeld 'reglerK'

 	set(h.reglerK, 'String', num2str(K));
	set(h.poleRK, 'String', num2str(poleRK'));
	
% end function berechneK_Callback

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Berechnung Regler reglerK ENDE
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Matrix R 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function R_Callback(hObject, eventdata, handles)
% hObject    handle to R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of R as text
%        str2double(get(hObject,'String')) returns contents of R as a double

% --- Executes during object creation, after setting all properties.
function R_CreateFcn(hObject, eventdata, handles)
% hObject    handle to R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 1);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Matrix R ENDE
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Matrix Q
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Q11_Callback(hObject, eventdata, handles)
% hObject    handle to Q11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of Q11 as text
%        str2double(get(hObject,'String')) returns contents of Q11 as a double
% --- Executes during object creation, after setting all properties.
function Q11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 1);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Q22_Callback(hObject, eventdata, handles)
% hObject    handle to Q22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of Q22 as text
%        str2double(get(hObject,'String')) returns contents of Q22 as a
%        double
% --- Executes during object creation, after setting all properties.
function Q22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 1);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Q33_Callback(hObject, eventdata, handles)
% hObject    handle to Q33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of Q33 as text
%        str2double(get(hObject,'String')) returns contents of Q33 as a
%        double
% --- Executes during object creation, after setting all properties.
function Q33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 1);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Q44_Callback(hObject, eventdata, handles)
% hObject    handle to Q44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of Q44 as text
%        str2double(get(hObject,'String')) returns contents of Q44 as a
%        double
% --- Executes during object creation, after setting all properties.
function Q44_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 1);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Matrix Q ENDE
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes during object creation, after setting all properties.
function reglerK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reglerK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called





% --- Executes during object creation, after setting all properties.
function record_sim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to record_sim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function slider_AP_Callback(hObject, eventdata, handles)
% hObject    handle to slider_AP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    h = guihandles();
    value_AP = get(h.slider_AP,'Value');
    set(h.AP_1,'String',[num2str(value_AP*180) '°'])
    
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_AP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_AP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in startSimulation.
function startSimulation_Callback(hObject, eventdata, handles)
% hObject    handle to startSimulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	global AP K x0 xs0 M_AP stopAnimation useObs
    h = guihandles();
    if isempty(AP) || isempty(K)
        msgbox('Bitte erst den Regler berechnen!');
    else
    
        x0(1) = str2num(h.x1_0.String);
        x0(2) = str2num(h.x2_0.String);
        x0(3) = str2num(h.x3_0.String);
        x0(4) = str2num(h.x4_0.String);

        xs0(1) = str2num(h.x1_s0.String);
        xs0(2) = str2num(h.x2_s0.String);
        xs0(3) = str2num(h.x3_s0.String);
        xs0(4) = str2num(h.x4_s0.String);
        
        stPendel = ladePendel();
        if useObs
            poleObs = [0 0 0 0];
            poleObs(1) = str2num(h.eigBeob1.String);
            poleObs(2) = str2num(h.eigBeob2.String);
            poleObs(3) = str2num(h.eigBeob3.String);
            poleObs(4) = str2num(h.eigBeob4.String);
            
            [f_fun, h_fun] = nonlinear_model();
            stObs = ladeObs(f_fun, h_fun, AP, xs0, poleObs);
            
            [ vT, vM, mX ] = runPendel( stPendel, AP, K, x0, M_AP, stObs );
        else
            [ vT, vM, mX ] = runPendel( stPendel, AP, K, x0, M_AP );
        end
        [ vTint, mXint ] = interpolateSim( vT, mX, 200 );
        
        vid = h.makeVideo.Value;
        stopAnimation = [];
        animierePendel(vTint,mXint,stPendel,h.axes1,vid);
    end
    
    

% --- Executes on button press in stopSimulation.
function stopSimulation_Callback(hObject, eventdata, handles)
% hObject    handle to stopSimulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stopAnimation
stopAnimation = 1;


% --- Executes on button press in makeVideo.
function makeVideo_Callback(hObject, eventdata, handles)
% hObject    handle to makeVideo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of makeVideo



function x1_0_Callback(hObject, eventdata, handles)
% hObject    handle to x1_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x1_0 as text
%        str2double(get(hObject,'String')) returns contents of x1_0 as a double


% --- Executes during object creation, after setting all properties.
function x1_0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x1_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x2_0_Callback(hObject, eventdata, handles)
% hObject    handle to x2_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x2_0 as text
%        str2double(get(hObject,'String')) returns contents of x2_0 as a double


% --- Executes during object creation, after setting all properties.
function x2_0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x2_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x3_0_Callback(hObject, eventdata, handles)
% hObject    handle to x3_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x3_0 as text
%        str2double(get(hObject,'String')) returns contents of x3_0 as a double


% --- Executes during object creation, after setting all properties.
function x3_0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x3_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x4_0_Callback(hObject, eventdata, handles)
% hObject    handle to x4_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x4_0 as text
%        str2double(get(hObject,'String')) returns contents of x4_0 as a double


% --- Executes during object creation, after setting all properties.
function x4_0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x4_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x1_s0_Callback(hObject, eventdata, handles)
% hObject    handle to x1_s0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x1_s0 as text
%        str2double(get(hObject,'String')) returns contents of x1_s0 as a double


% --- Executes during object creation, after setting all properties.
function x1_s0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x1_s0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x2_s0_Callback(hObject, eventdata, handles)
% hObject    handle to x2_s0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x2_s0 as text
%        str2double(get(hObject,'String')) returns contents of x2_s0 as a double


% --- Executes during object creation, after setting all properties.
function x2_s0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x2_s0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x3_s0_Callback(hObject, eventdata, handles)
% hObject    handle to x3_s0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x3_s0 as text
%        str2double(get(hObject,'String')) returns contents of x3_s0 as a double


% --- Executes during object creation, after setting all properties.
function x3_s0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x3_s0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x4_s0_Callback(hObject, eventdata, handles)
% hObject    handle to x4_s0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x4_s0 as text
%        str2double(get(hObject,'String')) returns contents of x4_s0 as a double


% --- Executes during object creation, after setting all properties.
function x4_s0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x4_s0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in dropdownFeedback.
function dropdownFeedback_Callback(hObject, eventdata, handles)
% hObject    handle to dropdownFeedback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global useObs
selected = hObject.Value;
mode = hObject.String{selected};
if strcmp(mode, 'direkt')
    useObs = 0;
elseif strcmp(mode, 'Beobachter')
    useObs = 1;
end


% --- Executes during object creation, after setting all properties.
function dropdownFeedback_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dropdownFeedback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eigBeob1_Callback(hObject, eventdata, handles)
% hObject    handle to eigBeob1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eigBeob1 as text
%        str2double(get(hObject,'String')) returns contents of eigBeob1 as a double


% --- Executes during object creation, after setting all properties.
function eigBeob1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eigBeob1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eigBeob2_Callback(hObject, eventdata, handles)
% hObject    handle to eigBeob2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eigBeob2 as text
%        str2double(get(hObject,'String')) returns contents of eigBeob2 as a double


% --- Executes during object creation, after setting all properties.
function eigBeob2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eigBeob2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eigBeob3_Callback(hObject, eventdata, handles)
% hObject    handle to eigBeob3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eigBeob3 as text
%        str2double(get(hObject,'String')) returns contents of eigBeob3 as a double


% --- Executes during object creation, after setting all properties.
function eigBeob3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eigBeob3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eigBeob4_Callback(hObject, eventdata, handles)
% hObject    handle to eigBeob4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eigBeob4 as text
%        str2double(get(hObject,'String')) returns contents of eigBeob4 as a double


% --- Executes during object creation, after setting all properties.
function eigBeob4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eigBeob4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
