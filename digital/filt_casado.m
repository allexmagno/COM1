clear all
close all
clc
N = 100;
SNR = 5;

% Criando sinal formatado
info = [1 0 1 1 0 1 0 0];
info_up = upsample(info, N);
filtro_Tx = ones(1, N);
sinal_Tx = filter(filtro_Tx, 1, info_up);

% Filto Casado
filtro_casado = fliplr(filtro_Tx);

% Sinal na recepcao com ruido awgn
rx_awgn = awgn(sinal_Tx, SNR );
sinal_Rx = filter(filtro_casado, 1, rx_awgn)/N;

figure(1)
subplot(311)
plot(sinal_Tx)
ylim([-0.5 1.5])
subplot(312)
plot(rx_awgn)
ylim([-1 2])
subplot(313)
plot(sinal_Rx)
