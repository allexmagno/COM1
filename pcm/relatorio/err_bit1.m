%% Analise de desempenho de eroo
% Allex Magno Andrade
% Laboratorio 4

clear all
close all
clc

N = 10; % Fator de superamostragem
A = 1; % Amplitude do impluso
Rb = 10; %taxa de transmissao/segundo
A = 1; % Amplitude do sinal
lim = A - A/2;
SNR = 10; %dB
passo_t = 1/(N*Rb);
info = [0 1 1 0 1 0 1 1 0 1 0];
info_up = upsample(info, N)*A; % super amostragem


%% Sinal transmitido
filtro_NRZ = ones(1, N); % filtro
tx = filter(filtro_NRZ, 1, info_up); % fazendo a convolucao e colocando no nivel de tensao
t = 0:passo_t:(length(info)/Rb)-passo_t;
subplot(521)
plot(t, tx);
ylim([-A+lim A+lim]);
title('Sinal a ser transmitido')

%% Sinal Recebido
rx = awgn(tx, SNR);
subplot(523)
plot(t, rx)
ylim([-A+lim A+lim]);
title('Sinal na recep?ao com ruido')

%% Crindo filtro casado
filtro_casado = fliplr(filtro_NRZ);

%% Sinal Recebido filtrado
rx_filtrado = filter(filtro_casado, 1, rx)/N;
subplot(525)
plot(t, rx_filtrado)
ylim([-A+lim A+lim]);
title('Sinal na recepcao apos ser filtrado')

%% Recuperando o sinal sem ter passado pelo filtro
z1_T = rx(N:N:end);
limiar_NRZ = 0.5; 
info_hat = z1_T > limiar_NRZ; 
info_rx_up = upsample(info_hat, N)*A;
info_rx = filter(filtro_NRZ, 1, info_rx_up);
subplot(527)
plot(t, info_rx)
ylim([-A+lim A+lim]);
title('Sinal recuperado em rx - Sem filtro')

%% Recuperando o sinal apos passar pelo filtro
z2_T = rx_filtrado(N:N:end);
info_hat2 = z2_T > limiar_NRZ; 
info_rx_up2 = upsample(info_hat2, N)*A;
info_rx2 = filter(filtro_NRZ, 1, info_rx_up2);
subplot(529)
plot(t, info_rx2)
ylim([-A+lim A+lim]);
title('Sinal recuperado em rx - Com filtro')

%% Comparacao do sinal transmitido com o sinal recuperado

subplot(6,2,[2 4 6])
plot(t, tx, 'g')
ylim([-A+lim A+lim]);
hold on
plot(t, info_rx, 'r')
ylim([-A+lim A+lim]);
legend('Sinal transmitido','Sinal recebido')
hold off
title('Comparacao do sinal transmitido e recuperado sem filtro casado e com filtro casado')


subplot(6,2,[8 10 12])
plot(t, tx, 'g')
ylim([-A+lim A+lim]);
hold on
plot(t, info_rx2, 'r')
ylim([-A+lim A+lim]);
legend('Sinal transmitido','Sinal recebido')
hold off