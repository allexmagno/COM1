% Lab_3 COM1
% ALLEX MAGNO ANDRADE
clear all;
close all;
clc

fa = 10e3;
ta = 1/fa;
r_t = randn(1, fa);

figure(1)
subplot(211)
hist(r_t, 100)

figure(2)
subplot(211)
% Plotando o ruido no periodo do tempo
t = 0:ta:1-ta;

plot(t, r_t)


% Plotando o ruído no dominio da freqz
R_f = fftshift(fft(r_t)/length(r_t));
f = -fa/2:1:(fa/2)-1;

subplot(212)
plot(f, R_f)
%
% Autocorrelação
figure(3)
x_cor = xcorr(r_t);
plot(x_cor)

% Filtro
figure(4)
filtro = fir1(50,(1000*2)/fa)';
freqz(filtro)

figure(5)
y = conv(r_t, filtro);
hist(y, 100)

figure(6)
Y_f = fftshift(fft(y));

subplot(211)
plot(t, y(1:end-50))
subplot(212)
plot(f, Y_f(end-50))




