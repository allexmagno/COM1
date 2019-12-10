% COM1
% ALLEX MAGNO
% Gerando um ruido em um sinal


close all;
clear all;
clc;

L = 1000000;
x = randn(1, L);

figure(1)
hist(x, 100)

figure(2)
subplot(211)
var_x = var(x)
u_x = mean(x)

% xcorr faz a autocorrelacao do sinal aleatorio
x_cor = xcorr(x);
plot(x_cor);

r = x + 5;
var_r = var(r)
u_r = mean(r)

%n = x*sqrt(10); para normalizar o desvio padrao 
n = x*10;
var_n = var(n)
u_n = mean(n)
u2_n = std(n)
subplot(212)
hist(n, 100)

