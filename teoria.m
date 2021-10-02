close all, clear all, clc

%% GENERACION DE LA SENOIDAL

% variables
fs = 8000; % frecuencia de muestreo
r = 16; % bits/muestra
duracion = 5; % duracion de la señal
hz = 432; % hz de la senoidal
snr = 20; % SNR con respecto al ruido
t = (0:1/fs:duracion-1/fs)'; % vector de tiempo
porcentaje_impulso = 0.5;

% graficas
grafica_tiempo = 1;
grafica_frecuencia = 1;

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

%% RECONSTRUCCION

% nivel 3
B31 = rwwt(B41, B42, f0, f1);
B32 = rwwt(B43, B44, f0, f1);
B33 = rwwt(B45, B46, f0, f1);
B34 = rwwt(B47, B48, f0, f1);
B35 = rwwt(B49, B410, f0, f1);
B36 = rwwt(B411, B412, f0, f1);
B37 = rwwt(B413, B414, f0, f1);
B38 = rwwt(B415, B416, f0, f1);

% nivel 2
B21 = rwwt(B31, B32, f0, f1);
B22 = rwwt(B33, B34, f0, f1);
B23 = rwwt(B35, B36, f0, f1);
B24 = rwwt(B37, B38, f0, f1);

% nivel 1
B11 = rwwt(B21, B22, f0, f1);
B12 = rwwt(B23, B24, f0, f1);

% senal reconstruida
senal_reconstruida = rwwt(B11, B12, f0, f1);
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
plot(t, senal_reconstruida-senal_ruido_impulso')
grid on, xlabel('Tiempo'), ylabel('Señal'),
title('Señal recontruida')

% grafica de la energia de la señal recontruida
subplot(2,1,2);
stem(t, senal_energy)
grid on, xlabel('Tiempo'), ylabel('Señal'),
title('Energia de la señal')

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

