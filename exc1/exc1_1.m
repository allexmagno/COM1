% Lab_1 COM1
% ALLEX MAGNO ANDRADE
%clear all
close all
clc
%% 1)
% Gerar um sinal s(t) composto pela somat?ria de 3 senos com
% amplitudes de 6V, 2V e 4V e frequ?ncias de 1, 3 e 5 kHz,
% respectivamente.

% Determinando as amplitudes
A1 = 6;
A2 = 2;
A3 = 4; 
% Determinando as frequencias
f1 = 1e3;
f2 = 3e3;
f3 = 5e3;
% Amostras (Minimo 2x a maior frequencia)
fa = 50*f3;
ta = 1/fa;

% Numero de ciclos que deseja ver
t = 0:ta:2/f1;

% Sinal s1, s2, s3
s1_t = A1*sin(2*pi*f1*t);
s2_t =A2*sin(2*pi*f2*t);
s3_t = A3*sin(2*pi*f3*t);

% Sinal composto s(t)
s_t =  s1_t + s2_t + s3_t;

%% Plotando os sinais no dominio do tempo
figure(1)
subplot(421)
plot(t, s1_t)

subplot(423)
plot(t, s2_t)

subplot(425)
plot(t, s3_t)

subplot(427)
plot(t, s_t)

%% Passando para o dominio da ferequencia

S1_f = fftshift(fft(s1_t)/length(s1_t));
S2_f = fftshift(fft(s2_t)/length(s2_t));
S3_f = fftshift(fft(s3_t)/length(s3_t));
S_f = fftshift(fft(s_t)/length(s_t));

f = -fa/2:500:fa/2;

%% Plotando os sinais no dominio da frequencia
figure(2)
subplot(412)
plot(f, abs(S1_f));

subplot(412)
plot(f, abs(S2_f));

subplot(413)
plot(f, abs(S3_f));

subplot(414)
plot(f, abs(S_f))

%% Potencia media do sinal
norm(s_t)

%% Densidade espectral de potencia
pwelch(s_t)


