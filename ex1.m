clear all
close all
clc

A1 = 10;
A2 = 1;
A3 = 4;

f1 = 100;
f2 = 200;
f3 = 300;

fa = 3e3;

t = [0:1/fa:100*(1/f3)];
s_t = A1*cos(2*pi*t*f1) + A2*cos(2*pi*t*f2) + A3*cos(2*pi*t*f3) + 2;

P = sum(s_t.^2)/length(s_t)
mean(s_t)


figure(1)
%subplot(qtd linha, coluna, n figura)

% Funcao
subplot(221)
plot(t, s_t)

% Transformada ja normalizada
x_f = fft(s_t);
subplot(222)
plot(abs(x_f))

% Shift
f = [-fa/2:3:fa/2];

x_f_shift = fftshift(x_f);
subplot(223)
plot(f, abs(x_f_shift))

% Janela de amostragem
subplot(224)
plot(f, abs(x_f))


