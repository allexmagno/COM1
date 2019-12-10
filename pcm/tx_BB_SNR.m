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
f_cut = 1.5e3; % freq de corte
N_ordem = 10;% Isso pq o filtro vai gerar atraso. Para pegar o sinal
filtro_PB = fir1(N_ordem, (f_cut*2)/Fs); % Filtro PB normalizado
A = 1; % Amplitude do sinal
passo_t = 1/(N*Rb);
info = randi([0 M-1],1,10000); % Gerando um ruido
info_up = upsample(info, N); % super amostragem
%Fazendo o nivel de tensao variar
filtro_NRZ = ones(1, N); % filtro
tx = filter(filtro_NRZ, 1, info_up); % fazendo a convolucao e colocando no nivel de tensao
t = 0:passo_t:(length(info)/Rb)-passo_t;
tx = filter(filtro_NRZ, 1, info_up)*(2*A)-A; % fazendo a convolucao e colocando no nivel de tensao

for SNR = 10:10
    %% [Tx] -> [canal AWGS] -> [Rx] (Rx = Tx + n) sendo n o ruido branco
    % Receptor
    %rx = awgn(tx, SNR); % Insere um ruido branco ao sinal Tx com a potencia variada
    rx = awgn(tx, SNR); % Insere um ruido com a mesma potencia em dB que o
    %sinal
    
    %% filtro passa baixa
    rx_filtrado = filter(filtro_PB, 1, rx);
    
    %% Detec?cao de sinais binarios em um canal AWGN
    % Probilidade de erro
    z_T = rx(N/2+(N_ordem/2):N:end);
    limiar_NRZ = 0; 
    info_hat = z_T > limiar_NRZ; 
    erro_bit = sum(xor(info, info_hat));
    taxa_erro(SNR + 1) = (erro_bit/length(info));
    
end;
SNR_vec = 0:10;
figure(1)
semilogy(SNR_vec, taxa_erro)
% SNR = S/N (potencia do sinal/N de bits)
% S = Eb; n = T*N (tempo * numero de bits) 
% T = 1/Rb
% SNR = (Eb * Rb)/N = (Eb*Rb)/(N0*Bw)
% grafico(BER, SNR) BER = bit error rate
% Eb/No[dB] = 10log(Eb/No)
xlabel('SNR [dB]')
ylabel('BER')
title('Desempenho da sinalizacao NRZ')
grid on

figure(2)
subplot(211)
plot(t, rx)
xlim([0 20/Rb])

subplot(212)
plot(t, rx_filtrado)
xlim([0 20/Rb])
max(taxa_erro)