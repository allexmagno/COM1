%% Genrando um ruido
% Allex Magno Andrade
% aula 04/04

clear all
close all
clc

N = 10; % Fator de superamostragem
M = 2; % numero de simbolos da transmissao
Rb = 1000; %taxa de transmissao/segundo ~ Bw
Fs = N*Rb; % Freq de amostragem
A = 1; % Amplitude do sinal
passo_t = 1/(N*Rb);
info = randi([0 M-1],1,10000); % Gerando um ruido
info_up = upsample(info, N); % super amostragem
%Fazendo o nivel de tensao variar
filtro_NRZ = ones(1, N); % filtro
tx = filter(filtro_NRZ, 1, info_up); % fazendo a convolucao e colocando no nivel de tensao
t = 0:passo_t:(length(info)/Rb)-passo_t;
tx = filter(filtro_NRZ, 1, info_up)*A; % fazendo a convolucao e colocando no nivel de tensao

for SNR = 0:10
    %% [Tx] -> [canal AWGS] -> [Rx] (Rx = Tx + n) sendo n o ruido branco
    % Receptor
    %rx = awgn(tx, SNR); % Insere um ruido branco ao sinal Tx com a potencia variada
    rx = awgn(tx, SNR); % Insere um ruido com a mesma potencia em dB que o
    %sinal
    
    %% filtro casado
    filtro_casado = fliplr(filtro_NRZ);
    rx_filtrado = filter(filtro_casado, 1, rx)/N;
    
    %% Detec?cao de sinais binarios em um canal AWGN
    % Probilidade de erro
    
    % sem filtro
    z_T = rx(N:N:end);
    limiar_NRZ = A/2; 
    info_hat = z_T > limiar_NRZ; 
    erro_bit = sum(xor(info, info_hat));
    taxa_erro(SNR + 1) = (erro_bit/length(info));
    
    % Com filtro
    z_T2 = rx_filtrado(N:N:end);
    info_hat2 = z_T2 > limiar_NRZ; 
    erro_bit2 = sum(xor(info, info_hat2));
    taxa_erro2(SNR + 1) = (erro_bit2/length(info));
    
end;
SNR_vec = 0:10;
figure(1)
semilogy(SNR_vec, taxa_erro)
xlabel('SNR [dB]')
ylabel('Pb')
title('Desempenho da sinalizacao NRZ')

grid on
hold on

semilogy(SNR_vec, taxa_erro2)
legend('Sem filtro', 'Com filtro')
hold off