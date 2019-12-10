clear all
close all
clc

N = 20;
M = 2;
info = randint(1, 10000, M);
info_MPSK = pskmod(info, M);

for SNR = 0:10
    rx_awgn = awgn(info_MPSK, SNR);
    rx = pskdemod(rx_awgn, M);
    [num(SNR + 1), taxa(SNR +1)] = biterr(info, rx);
end

semilogy([0:10], taxa)