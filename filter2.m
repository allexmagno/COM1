clear all
close all
clc

%%
fs = 1e3;
ts = 1/fs;
n = 1;
t = [0:ts:1-ts];

r1 = randn(1, 1e3);
figure(1)
hist(r1, 1e3)

figure(2)
subplot(211)
plot(t, r1)

R1 = fft(r1)/length(r1);
R1_s = fftshift(R1);
%f = [-fs/2:1e6:fs/2];
%subplot(212)
%plot(f, abs(R1))