%% Desempenho de erro PbxSNR
% Allex Magno Andrade
% Laboratorio 4

clear all
close all
clc

N = 10; % Fator de superamostragem
M = 2; % numero de simbolos da transmissao
Rb = 1000; %taxa de transmissao/segundo ~ Bw
Fs = N*Rb; % Freq de amostragem
f_cut = 1.5e3; % freq de corte
A = 1; % Amplitude do sinal
passo_t = 1/(N*Rb);
info = randi([0 M-1],1,10000); % Gerando um ruido
info_up = upsample(info, N); % super amostragem
%Fazendo o nivel de tensao variar
filtro_NRZ = ones(1, N); % filtro
tx = filter(filtro_NRZ, 1, info_up); % fazendo a convolucao e colocando no nivel de tensao
t = 0:passo_t:(length(info)/Rb)-passo_t;
filtro_casado = fliplr(filtro_NRZ);

for i = 0:1
    %% Determinando se sera unipolar ou bipolar
    if i == 0
        tx = filter(filtro_NRZ, 1, info_up)*A; % fazendo a convolucao e colocando no nivel de tensao
    else
        tx = filter(filtro_NRZ, 1, info_up)*(2*A)-A;
    end
    
    for SNR = 0:10
    %% [Tx] -> [canal AWGS] -> [Rx] (Rx = Tx + n) sendo n o ruido branco
    % Receptor
    rx = awgn(tx, SNR); % Insere um ruido branco ao sinal Tx com a potencia variada
        
    %% Rx filtrado
    rx_filtrado = filter(filtro_casado, 1, rx)/N;
    
    %% Deteccao de sinais binarios em um canal AWGN
    % Probilidade de erro
    z_T = rx(N:N:end);
    if i == 0
        limiar_NRZ = A/2;
    else
        limiar_NRZ = 0;
    end;
    info_hat = z_T > limiar_NRZ; 
    erro_bit = sum(xor(info, info_hat));
    taxa_erro(SNR + 1) = (erro_bit/length(info));
    end;
    SNR_vec = 0:10;
    figure(1)
    semilogy(SNR_vec, taxa_erro)
    xlabel('SNR [dB]')
    ylabel('BER')
    title('Desempenho da sinalizacao NRZ')
    grid on
    hold on  
end;
legend('Uniopolar', 'Bipolar')
hold off