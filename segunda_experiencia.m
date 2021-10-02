function varargout = segunda_experiencia(varargin)
% SEGUNDA_EXPERIENCIA MATLAB code for segunda_experiencia.fig
%      SEGUNDA_EXPERIENCIA, by itself, creates a new SEGUNDA_EXPERIENCIA or raises the existing
%      singleton*.
%
%      H = SEGUNDA_EXPERIENCIA returns the handle to a new SEGUNDA_EXPERIENCIA or the handle to
%      the existing singleton*.
%
%      SEGUNDA_EXPERIENCIA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEGUNDA_EXPERIENCIA.M with the given input arguments.
%
%      SEGUNDA_EXPERIENCIA('Property','Value',...) creates a new SEGUNDA_EXPERIENCIA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before segunda_experiencia_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to segunda_experiencia_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help segunda_experiencia

% Last Modified by GUIDE v2.5 10-May-2021 11:21:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @segunda_experiencia_OpeningFcn, ...
                   'gui_OutputFcn',  @segunda_experiencia_OutputFcn, ...
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


% --- Executes just before segunda_experiencia is made visible.
function segunda_experiencia_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to segunda_experiencia (see VARARGIN)

% Choose default command line output for segunda_experiencia
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes segunda_experiencia wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = segunda_experiencia_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% LOGO UPC
axes(handles.axes6);
bkgrnd=imread('upc.jpg');
imshow(bkgrnd);
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Aqui se guardara el nombre del archivo que ingrese el usuario
%ingresamos el nombre del string que dará el profesor
%nosdan=get(handles.textitonombre,'String')
clc;
nosdan = get(handles.textitoarchivo,'String');
%nosdan='doblepico.mat';
load(nosdan);%lo cargamos
Fs=8000;
%ESTA ES LA GRÁFICA DE LA SEÑAL DE ENTRADA EN EL TIEMPO
plot(handles.axes1,t,senal),grid on,ylim(1.1*[min(senal) max(senal)]);

%ESTA ES LA GRÁFICA DEL ESPECTRO DEL MÓDULO DE LA SEÑAL DE ENTRADA
[X,frec]=freqz(senal,1,8192,2*pi);
plot(handles.axes2,frec,abs(X),'g'),grid on,xlim([0,pi]);
xlim([0 2*pi]);
zoom on;
%% Descomposición

[h0,h1,f0,f1]=wfilters('db25');%[h0, h1, f0, f1] =[hd,gd,hr,gr]
%h: pasabajas
%g: pasaaltas
%d: descomposicion
%r: reconstruccion
%primer nivel de descomposición
[B11,B12] = dwt(senal,h0,h1);
%segundo nivel de descomposición
[B21,B22] = dwt(B11,h0,h1);
[B23,B24] = dwt(B12,h0,h1);
%tercer nivel de descomposición
[B31,B32] = dwt(B21,h0,h1);
[B33,B34] = dwt(B22,h0,h1);
[B35,B36] = dwt(B23,h0,h1);
[B37,B38] = dwt(B24,h0,h1);
%Cuarto nivel de descomposición
[B41,B42] = dwt(B31,h0,h1);
[B43,B44] = dwt(B32,h0,h1);
[B45,B46] = dwt(B33,h0,h1);
[B47,B48] = dwt(B34,h0,h1);
[B49,B410] = dwt(B35,h0,h1);
[B411,B412] = dwt(B36,h0,h1);
[B413,B414] = dwt(B37,h0,h1);
[B415,B416] = dwt(B38,h0,h1);
%% Reconstrucción
%Cuarto nivel de reconstrucción
BR41 = B41*0;
BR42 = B42*0;
BR43 = B43*0;
BR44 = B44*0;
BR45 = B45*0;
BR46 = B46*0;
BR47 = B47*0;
BR48 = B48*0;
BR49 = B49*0;
BR410 = B410*0;
BR411 = B411*0;
BR412 = B412*0;
BR413 = B413*0;
BR414 = B414*0;
BR415 = B415*0;
BR416 = B416*1;
%Tercer nivel de reconstrucción 
[BR31] = idwt(BR41,BR42,f0,f1);
[BR32] = idwt(BR43,BR44,f0,f1);
[BR33] = idwt(BR45,BR46,f0,f1);
[BR34] = idwt(BR47,BR48,f0,f1);
[BR35] = idwt(BR49,BR410,f0,f1);
[BR36] = idwt(BR411,BR412,f0,f1);
[BR37] = idwt(BR413,BR414,f0,f1);
[BR38] = idwt(BR415,BR416,f0,f1);
%Segundo nivel de reconstrucción
[BR21] = idwt(BR31,BR32,f0,f1);
[BR22] = idwt(BR33,BR34,f0,f1);
[BR23] = idwt(BR35,BR36,f0,f1);
[BR24] = idwt(BR37,BR38,f0,f1);
%Primer nivel de reconstrucción
[BR11] = idwt(BR21,BR22,f0,f1);
[BR12] = idwt(BR23,BR24,f0,f1);
% Señal reconstruida
[new_senal] = idwt(BR11,BR12,f0,f1); %Esta es la señal reconstruida que sale
[new_X,frec]=freqz(new_senal,1,8192,2*pi);
limpiado=new_senal; %Se borra todo el ruido y nos quedamos con los impulsos
for i=1:length(limpiado)
    if new_senal(i)<(0.475*max(limpiado))
        limpiado(i)=0;
    end
end
vals=[];
for i=1:length(limpiado)
    if limpiado(i)~=0
        vals=[vals i];
    end    
end
inicios=[];
inicios=[inicios vals(1)];
ind_inicios=[1];
for i=2:length(vals)
    if vals(i)-vals(i-1)~=3;
        inicios=[inicios vals(i)];
        ind_inicios=[ind_inicios i];
    end       
end

ind_finales=[];

for i=2:length(inicios)
   ind_finales=[ind_finales ind_inicios(i)-1];
   if ind_inicios(i)==ind_inicios(length(ind_inicios));
       ind_finales=[ind_finales length(vals)];
   end   
end
grupos=[];
n=0;
vals_extraidos=[];
max_vals=[];
limpiado_extraidos=[];
ind_max_vals=[];
ind_vals1=[];
for i=1:length(ind_finales);
    n=ind_inicios(i);
    for j=1:ind_finales(i)-ind_inicios(i)+1;
        grupos=[grupos n];
        n=n+1;
    end
    for k=1:length(grupos);
       vals_extraidos=[vals_extraidos vals(grupos(k))]; 
    end
    for p=1:length(vals_extraidos);
        limpiado_extraidos=[limpiado_extraidos limpiado(vals_extraidos(p))];
    end
    [max_vals0,ind_max_vals0]=max(limpiado_extraidos);
    max_vals=[max_vals max_vals0];
    ind_max_vals=[ind_max_vals ind_max_vals0];
     
    ind_vals1=[ind_vals1 grupos(ind_max_vals(i))];
    
    vals_extraidos=[];
    grupos=[];
    limpiado_extraidos=[];
end
posiciones0=[];
for u=1:length(ind_vals1);
    posiciones0=[posiciones0 vals(ind_vals1(u))];
end
posiciones1=posiciones0+1;
tiempos0=[];
for o=1:length(posiciones0);
    tiempos0=[tiempos0 posiciones0(o)*T];
end
tiempos1=tiempos0+T;
Amplitud_pulsos=zeros(1,length(t));

for v=1:length(posiciones0);
   Amplitud_pulsos(posiciones0(v))=max_vals(v);
end

for w=1:length(posiciones1);
   Amplitud_pulsos(posiciones1(w))=-max_vals(w);
end
tiempos=[];
for h=1:length(tiempos0);
    tiempos=[tiempos tiempos0(h)];
    tiempos=[tiempos tiempos1(h)];
end
posiciones=[];
for q=1:length(posiciones0);
    posiciones=[posiciones posiciones0(q)];
    posiciones=[posiciones posiciones1(q)];
end
%ESTA ES LA GRÁFICA DE LOS PULSOS RECUPERADOS EN EL TIEMPO
plot(handles.axes3,t,Amplitud_pulsos,'r'),grid on,ylim(1.1*[min(Amplitud_pulsos) max(Amplitud_pulsos)]);
texto1=['Se detectaron ',num2str(length(posiciones0)),' pulsos dobles',' que inician en: ',num2str(posiciones0)];
disp(texto1) %Esto es lo que se va a mostrar en el cuadro

texto2=['y terminan en: ',num2str(posiciones1)];
disp(texto2)

%% mostrar texto:

mostrar1=texto1;
set(handles.textitomostrar,'string',mostrar1);

mostrar2=texto2;
set(handles.textitomostrar2,'string',mostrar2);

%% graficas aparte
figure,plot(t,senal,'b'),grid on,ylim(1.1*[min(senal) max(senal)]),title('Señales de entrada y salida'),xlabel('Tiempo (seg)'),ylabel('Amplitud'),hold on;
plot(t,Amplitud_pulsos,'r'),legend('Señal original','Pulsos recuperados');
hold off;

[X,frec]=freqz(senal,1,8192,Fs);
figure,plot(frec,abs(X),'b'),grid on,xlabel('Frecuencia (Hz)'),ylabel('Módulo'),title('Espectro de módulo Señal entrada');xlim([0,Fs/2]),hold on,
[new_X,frec]=freqz(new_senal,1,8192,Fs);
plot(frec,abs(new_X),'r'), legend('Señal original','Señal resultante');
hold off;

disp(tiempos0)
% LOGO UPC
axes(handles.axes6);
bkgrnd=imread('upc.jpg');
imshow(bkgrnd);





function textitonombre_Callback(hObject, eventdata, handles)
% hObject    handle to textitonombre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textitonombre as text
%        str2double(get(hObject,'String')) returns contents of textitonombre as a double


% --- Executes during object creation, after setting all properties.
function textitonombre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textitonombre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textitoseg_Callback(hObject, eventdata, handles)
% hObject    handle to textitoseg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textitoseg as text
%        str2double(get(hObject,'String')) returns contents of textitoseg as a double


% --- Executes during object creation, after setting all properties.
function textitoseg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textitoseg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textitoindices_Callback(hObject, eventdata, handles)
% hObject    handle to textitoindices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textitoindices as text
%        str2double(get(hObject,'String')) returns contents of textitoindices as a double


% --- Executes during object creation, after setting all properties.
function textitoindices_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textitoindices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textitomostrar_Callback(hObject, eventdata, handles)
% hObject    handle to textitomostrar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textitomostrar as text
%        str2double(get(hObject,'String')) returns contents of textitomostrar as a double


% --- Executes during object creation, after setting all properties.
function textitomostrar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textitomostrar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textitoarchivo_Callback(hObject, eventdata, handles)
% hObject    handle to textitoarchivo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textitoarchivo as text
%        str2double(get(hObject,'String')) returns contents of textitoarchivo as a double


% --- Executes during object creation, after setting all properties.
function textitoarchivo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textitoarchivo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textitomostrar2_Callback(hObject, eventdata, handles)
% hObject    handle to textitomostrar2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textitomostrar2 as text
%        str2double(get(hObject,'String')) returns contents of textitomostrar2 as a double



% --- Executes during object creation, after setting all properties.
function textitomostrar2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textitomostrar2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
