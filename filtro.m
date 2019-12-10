clear all
close all
clc
%%
fs = 100e3; % freq de amostragem
ts = 1/fs;
fc1 = 5e3; % freq de corte do filtro 1
fc2 = 10e3; % freq de corte do filtro 2
n = 100; % ordem do filtro
t = [0:ts:1-ts];

filt1 = fir1(n,(fc1*2)/fs)'; %frequencia de corte normalizado fazendo duas vezes a freq de corte
% fcut eh um vetor
%filtroPF = fir1(n, [f_pass1*2 f_pass2*2]/fa]); % f_pass1 freq que iniciao a passagem f_pass2 freq que encerra
figure(1)
freqz(filt1)

filt2 = fir1(n,(fc2*2)/fs)';
figure(2)
freqz(filt2)

ruido = randn(1, 1e5);
figure(3)
hist(ruido, 1e2)


% fun?ao filter que faz a convo?icao no tempo e multiplicacao na freq
y_1 = conv(ruido, filt1);
y_2 = conv(ruido, filt2);

figure(4)
subplot(321)
hist(ruido, 100)
%xlim([-6 6])
subplot(323)
hist(y_1, 100)
%xlim([-6 6])
subplot(325)
hist(y_2, 100)
%xlim([-6 6])] %limitando a potencia do sinal

figure(4)
subplot(322)
plot(t, ruido)
ylim([-5 5])
subplot(324)
plot(t, y_1(1:end-100))
ylim([-5 5])
subplot(326)
plot(t, y_2(1:end-100))
ylim([-5 5])