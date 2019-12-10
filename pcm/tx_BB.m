%% Genrando um ruido
% Allex Magno Andrade
% aula 04/04

clear all
close all
clc

N = 1000; % Fator de superamostragem
%A = 1; % Amplitude do impluso
M = 2; % numero de simbolos da transmissao
Rb = 1e3; %taxa de transmissao/segundo
passo_t = 1/(N*Rb);
info = randi([0 M-1],1,10000); % Gerando um ruido
info_up = upsample(info, N); % super amostragem
%Fazendo o nivel de tensao variar
filtro_NRZ = ones(1, N); % filtro
tx = filter(filtro_NRZ, 1, info_up); % fazendo a convolucao e colocando no nivel de tensao
t = 0:passo_t:(length(info)/Rb)-passo_t;
i = 0;
for A = 0.5:0.5:5
    i = i + 1;
    tx = filter(filtro_NRZ, 1, info_up)*(2*A)-A; % fazendo a convolucao e colocando no nivel de tensao
%     figure(1)
%     title('Transmissao e recep?ao de um sinal PCM')
%     subplot(311)
%     plot(t,tx)
%     ylim([-1.2*A 1.2*A])
%     xlabel('Sinal a ser transmitido')
    %% [Tx] -> [canal AWGS] -> [Rx] (Rx = Tx + n) sendo n o ruido branco
    % Receptor
    var_n = 1; % Aumentando a variancia
    ruido = sqrt(var_n)*randn(1, length(tx)); % Desvio padrao * randn
    rx = tx + ruido;
%     subplot(312)
%     hist(ruido,100)
%     xlabel('Ruido termico - AWGN')

%     subplot(313)
%     plot(t,rx)
%     ylim([-1.2*A 1.2*A])
%     xlabel('sinal na recepcao')


    %% Detec?cao de sinais binarios em um canal AWGN
    % Probilidade de erro

    z_T = rx(N/2:N:end);
    limiar_NRZ = 0; 
    info_hat = z_T > limiar_NRZ; 
    erro_bit = sum(xor(info, info_hat));
    taxa_erro(i) = (erro_bit/length(info));
    
end;
%%vet_A = (0.5:0.1:5);
vet_A = ([1:i]*A)/i;
figure(1)
title('Taxa de erro com, a vaira?ao da amplitude')
semilogy(vet_A, taxa_erro)
% SNR = S/N (potencia do sinal/N de bits)
% S = Eb; n = T*N (tempo * numero de bits) 
% T = 1/Rb
% SNR = (Eb * Rb)/N = (Eb*Rb)/(N0*Bw)
% grafico(BER, SNR)
xlabel('SNR ou Eb/N0')
ylabel('err/bit [%]')
grid on