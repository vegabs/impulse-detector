close all, clear all, clc

%% GENERACION DE LA SENOIDAL

% variables
fs = 8000; % frecuencia de muestreo
r = 16; % bits/muestra
duracion = 5; % duracion de la señal
hz = 1234; % hz de la senoidal
snr = 30; % SNR con respecto al ruido
t = (0:1/fs:duracion-1/fs)'; % vector de tiempo
porcentaje_impulso = 0.5;

% graficas
grafica_tiempo = 1;
grafica_frecuencia = 0;

senal = sin(2*pi*hz*t);

% añadir ruido
senal_ruido = awgn(senal, snr);

% añadir 5 impulsos
a = 0; b = fs*duracion;
r = randi([a b],1,5);
impulso = senal*0;
for i = 1:length(r)
    impulso(r(i)) = 1;
    impulso(r(i)+1) = -1;
end
senal_ruido_impulso = senal_ruido + impulso;

%% TRANSFORMADAS

% transformada senoidal
[X_senal, frec_senal] = freqz(senal, 1, 16384, fs);

% transformada senoidal con ruido
[X_senal_ruido, frec_senal_ruido] = freqz(senal_ruido, 1, 16384, fs);

% transformada de la señal con impulsos
[X_senal_ruido_impulso, frec_senal_ruido_impulso] = freqz(senal_ruido_impulso, 1, 16384, fs);

%% HALLAR MAXIMA FRECUENCIA

[max_frec, index_max_frec] = max(abs(X_senal_ruido_impulso));
sinef = round(frec_senal_ruido_impulso(index_max_frec));
disp("La frecuencia de la senoidal es: " + sinef + " Hz.");

%% ARBOL DE DESCOMPOSICION

[h0,h1,f0,f1] = wfilters('db25');
[B11,B12] = dwwt(senal_ruido_impulso', h0, h1);

% nivel 2
[B21,B22] = dwwt(B11, h0, h1);
[B23,B24] = dwwt(B12, h0, h1);

% nivel 3
[B31,B32] = dwwt(B21, h0, h1); 
[B33,B34] = dwwt(B22, h0, h1); 
[B35,B36] = dwwt(B23, h0, h1); 
[B37,B38] = dwwt(B24, h0, h1);

% nivel 4
[B41,B42] = dwwt(B31, h0, h1); 
[B43,B44] = dwwt(B32, h0, h1); 
[B45,B46] = dwwt(B33, h0, h1); 
[B47,B48] = dwwt(B34, h0, h1); 
[B49,B410] = dwwt(B35, h0, h1); 
[B411,B412] = dwwt(B36, h0, h1); 
[B413,B414] = dwwt(B37, h0, h1); 
[B415,B416] = dwwt(B38, h0, h1); 

% energia de las señales
e_b41 = B41*B41'
e_b42 = B42*B42'
e_b43 = B43*B43'
e_b44 = B44*B44'
e_b45 = B45*B45'
e_b46 = B46*B46'
e_b47 = B47*B47'
e_b48 = B48*B48'
e_b49 = B49*B49'
e_b410 = B410*B410'
e_b411 = B411*B411'
e_b412 = B412*B412'
e_b413 = B413*B413'
e_b414 = B414*B414'
e_b415 = B415*B415'
e_b416 = B416*B416'

lista_e = [e_b41 e_b42 e_b43 e_b44 ...
                  e_b45 e_b46 e_b47 e_b48 ...
                  e_b49 e_b410 e_b411 e_b412 ...
                  e_b413 e_b414 e_b415 e_b416];

energy_max = max(lista_e);

switch energy_max
    case e_b41
        B41 = B41*0.01;
        disp("Banda B41 en 0");
    case e_b42
        B42 = B41;
        disp("Banda B42 en 0");
    case e_b43
        B43 = B43*0.01;
        disp("Banda B43 en 0");
    case e_b44
        B44 = B44*0.01;
        disp("Banda B44 en 0");
    case e_b45
        B45 = B45*0.01;
        disp("Banda B45 en 0");
    case e_b46
        B46 = B46*0.01;
        disp("Banda B46 en 0");
    case e_b47
        B47 = B47*0.01;
        disp("Banda B47 en 0");
    case e_b48
        B48 = B48*0.01;
        disp("Banda B48 en 0");
    case e_b49
        B49 = B49*0.01;
        disp("Banda B49 en 0");
    case e_b410
        B410 = B410*0.01;
        disp("Banda B410 en 0");
    case e_b411
        B411 = B411*0.01;
        disp("Banda B411 en 0");
    case e_b412
        B412 = B412*0.01;
        disp("Banda B412 en 0");
    case e_b413
        B413 = B413*0.01;
        disp("Banda B413 en 0");
    case e_b414
        B414 = B414*0.01;
        disp("Banda B414 en 0");
    case e_b415
        B415 = B415*0.01;
        disp("Banda B415 en 0");
    case e_b416
        B416 = B416*0.01;
        disp("Banda B416 en 0");
    otherwise
        disp('Banda no encontrada')
end

% energia de las señales
e_b41 = B41*B41';
e_b42 = B42*B42';
e_b43 = B43*B43';
e_b44 = B44*B44';
e_b45 = B45*B45';
e_b46 = B46*B46';
e_b47 = B47*B47';
e_b48 = B48*B48';
e_b49 = B49*B49';
e_b410 = B410*B410';
e_b411 = B411*B411';
e_b412 = B412*B412';
e_b413 = B413*B413';
e_b414 = B414*B414';
e_b415 = B415*B415';
e_b416 = B416*B416';

BR41 = B41*1;
BR42 = B42*1;
BR43 = B43*1;
BR44 = B44*1;
BR45 = B45*1;
BR46 = B46*1;
BR47 = B47*1;
BR48 = B48*1;
BR49 = B49*1;
BR410 = B410*1;
BR411 = B411*1;
BR412 = B412*1;
BR413 = B413*1;
BR414 = B414*1;
BR415 = B415*1;
BR416 = B416*1;

%% RECONSTRUCCION

% nivel 3
[BR31] = rwwt(BR41,BR42,f0,f1);
[BR32] = rwwt(BR43,BR44,f0,f1);
[BR33] = rwwt(BR45,BR46,f0,f1);
[BR34] = rwwt(BR47,BR48,f0,f1);
[BR35] = rwwt(BR49,BR410,f0,f1);
[BR36] = rwwt(BR411,BR412,f0,f1);
[BR37] = rwwt(BR413,BR414,f0,f1);
[BR38] = rwwt(BR415,BR416,f0,f1);

% nivel 2
[BR21] = rwwt(BR31,BR32,f0,f1);
[BR22] = rwwt(BR33,BR34,f0,f1);
[BR23] = rwwt(BR35,BR36,f0,f1);
[BR24] = rwwt(BR37,BR38,f0,f1);

% nivel 1
[BR11] = rwwt(BR21,BR22,f0,f1);
[BR12] = rwwt(BR23,BR24,f0,f1);

% senal reconstruida
senal_reconstruida = rwwt(BR11, BR12, f0, f1);
[X_recontruida, frec_recontruida] = freqz(senal_reconstruida, 1, 16384, fs);


%% HALLAR IMPULSOS

senal_energy =  senal_reconstruida.*senal_reconstruida;
max_impulse = max(senal_energy);
[valuep, indexp]= find(senal_energy > max_impulse*porcentaje_impulso);
indexp = indexp * 1/fs;

disp("Se encontraron: " + length(indexp) + " impulsos.");
for i=1:length(indexp)
    disp("Impulso: " + indexp(i) + " seg.")
end


senal_reconstruida_shift = circshift(senal_reconstruida,1);
resta = senal_reconstruida - senal_reconstruida_shift;
[c,lags] = xcorr(senal_reconstruida,senal_reconstruida_shift');
stem(lags,c)
%%resta = resta.*resta;
%% GRAFICAS EN EL TIEMPO
% grafica de la señal sin ruido
if(grafica_tiempo == 1)

figure
subplot(4,1,1);
plot(t, senal, 'b')
grid on, xlabel('Tiempo'), ylabel('Señal'),
title('Señal senoidal')

% grafica de la señal con ruido
subplot(4,1,2);
plot(t, senal_ruido, 'b')
grid on, xlabel('Tiempo'), ylabel('Señal'),
title('Señal con ruido')

% grafica de los impulsos
subplot(4,1,3);
stem(t, impulso, 'g')
grid on, xlabel('Tiempo'), ylabel('Señal'),
title('Impulsos')

% grafica de la señal con impulsos y ruido
subplot(4,1,4);
plot(t, senal_ruido_impulso, 'g')
grid on, xlabel('Tiempo'), ylabel('Señal'),
title('Señal con ruido y impulsos')

% grafica de la señal recontruida
figure
subplot(2,1,1);
plot(t, senal_reconstruida)
grid on, xlabel('Tiempo'), ylabel('Señal'),
title('Señal recontruida')

% grafica de la energia de la señal recontruida
subplot(2,1,2);
stem(t, senal_energy)
grid on, xlabel('Tiempo'), ylabel('Señal'),
title('Energia de la señal')

% grafica de la derivada
figure
subplot(2,1,1)
stem(t, resta)
grid on, xlabel('Tiempo'), ylabel('Señal'),
title('Gráfica de la derivada')

subplot(2,1,2);
stem(t, impulso, 'g')
grid on, xlabel('Tiempo'), ylabel('Señal'),
title('Señal con ruido y impulsos')
end

%% GRAFICAS EN FRECUENCIA

if(grafica_frecuencia == 1)
figure
subplot(4,1,1);
plot(frec_senal, abs(X_senal)),
grid on,
xlabel('Frecuencia'),
ylabel('Modulo'),
title('[SENOIDAL] Espectro de modulo')


subplot(4,1,2);
plot(frec_senal_ruido, abs(X_senal_ruido)),
grid on,
xlabel('Frecuencia'),
ylabel('Modulo'),
title('[SENOIDAL c/ RUIDO] Espectro de modulo')


subplot(4,1,3);
plot(frec_senal_ruido_impulso, abs(X_senal_ruido_impulso)),
grid on,
xlabel('Frecuencia'),
ylabel('Modulo'),
title('[SEÑAL c/ RUIDO + IMPULSOS] Espectro de modulo')


subplot(4,1,4);
plot(frec_recontruida, abs(X_recontruida)),
grid on,
xlabel('Frecuencia'),
ylabel('Modulo'),
title('[SEÑAL RECONSTRUIDA] Espectro de modulo')

end

