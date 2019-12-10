% Lab_3 COM1
% ALLEX MAGNO ANDRADE
clear all;
close all;
clc

fa = 10e3;
ta = 1/fa;
r_t = randn(1, fa);

figure(1)
hist(r_t, 100)

figure(2)
subplot(211)
% Plotando o ruido no periodo do tempo
t = 0:ta:1-ta;

plot(t, r_t)


% Plotando o ru??do no dominio da freqz
R_f = fftshift(fft(r_t)/length(r_t));
f = -fa/2:1:(fa/2)-1;

subplot(212)
plot(f, abs(R_f))
%
% Autocorrela????o
figure(3)
x_cor = xcorr(r_t);
plot(x_cor)

% Filtro
figure(4)
filtro_pb = fir1(50,(1000*2)/fa)';
freqz(filtro_pb)

figure(5)
y_t = conv(r_t, filtro_pb);
hist(y_t, 100)

figure(6)
Y_f = fftshift(fft(y_t));
subplot(211)
plot(t, y_t(1:end-50))
xlabel('t [s]')
ylabel('y(t)')

subplot(212)
plot(f, abs(Y_f(1:end-50)))
xlim([-2e3 2e3])
xlabel('f [Hz]')
ylabel('Y(f)')




