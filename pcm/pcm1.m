%% Formatacao do sinal PCM
% Allex Magno Andrade
% aula 27/03

clear all
close all
clc

info = [0 1 1 0 1];

figure(1)
% observando as amostrar com stem
subplot(321)
stem(info)
ylim([0 5])

% observando em nivel de tensao 0 e 5
subplot(322)
stem(info*5)
ylim([0 5])

% Aumentar a amostragem para perceber o sinal com continuo(superamostragem - upsamle)
subplot(323)
stem(upsample(info*5, 10))
ylim([0 5])

filtro_NRZ = ones(1, 1000);
subplot(324)
stem(filtro_NRZ)

% filtrar o sinal para obter o formato de onda
info_NRZ = filter(filtro_NRZ,1, upsample(info*5, 1000));
subplot(325)
stem(info_NRZ) % observar em amostras
ylim([0 10])

subplot(326)
plot(info_NRZ) % observar em tempo continuo
ylim([0 10])


%% Lendo um som
figure(2)
[y, Fs] = wavread('Scream+1.wav');
subplot(211)
plot(y)
%sound(y,Fs);
Y_f = fftshift(fft((y)/length(y)));
f = -Fs/2:1/(length(y)/Fs):Fs/2-(1/(length(y)/Fs));
subplot(212)
plot(f, Y_f) 
plot(f, transpose(abs(Y_f)));
xlim([-6e3 6e3])


%% quantizacao
% A = 2*V/2^n % passo de quantizacao V = tensao n = bits
% de2bi() funcao decimal para binario
% round() funcao que arredonda para o inteiro mais proximo
% reshape(transpose(bin), linha, coluna) transposto

n = 3;
passo = 2*max(y)/2^3;
amostras =  [min(y)+(1-passo/2) max(y) + (1-passo/2)];
amostras_deslc = amostras/passo;
amostras_arr = round(amostras_deslc);

amostras = amostras_arr - (amostras_arr == 8);
bin = de2bi(amostras);
q = reshape(transpose(bin), 1, 6);

som = filter(upsample(q,1000), 1, y);
figure(3)
plot(som)