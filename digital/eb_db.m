clear all;
close all;
clc;

eb_dB = 0:14;
ebno = 10.^(eb_dB/10);  %valor dB

Pb1 = qfunc(sqrt(ebno))
Pb2 = qfunc(sqrt(2*ebno))


semilogy(eb_dB,Pb1); grid on; ylim([10e-7 1]);
title('Compara??o de desempenho'); xlabel('Eb/N_0(dB)');ylabel('Bit error probability, P_B');
hold on; 
semilogy(eb_dB,Pb2);legend('Unipolar' , 'Bipolar');
hold off;