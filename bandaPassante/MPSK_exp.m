clear all
close all
clc
%%
M = 256; % LOG(2)(M) = numero de bits por simbolo
fc = 10e3;
SNR = 25;

info = randint(1, 1000,M);
%sinal_MPSK = exp(j*2*pi*info/M);
sinal_MPSK = qammod(info, M);
%sinal_MPSK = pskmod(info, M)
sinal_MPSK_rx = awgn(sinal_MPSK, SNR);
scatterplot(sinal_MPSK_rx)
grid on


% plot([-1 0 1], [1 0 1])
% plot([-1 0 1], [-1 0 -1])
% hold off