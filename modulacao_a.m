clear all
close all
clc
%%
ac = 1;
am = 1;
fm = 1e3;
fc = 1000e3;
f_cut = 2e3;
n = 100;
fa = 20*fc;
t = [0:1/fa:1];
c_t = ac*cos(2*pi*fc*t);
m_t = am*cos(2*pi*fm*t);
s_t = c_t.*m_t; % Sinal Modulado

r_t = s_t.*c_t; % Sinal demodulado
passa_baixa = fir1(n,(f_cut*2)/fa)';
info = filter(passa_baixa,1, r_t);

figure(1)
subplot(511)
plot(t, m_t)
xlim([0 2/fm])
subplot(512)
plot(t,c_t)
xlim([0 2/fm])
subplot(513)
plot(t, s_t)
xlim([0 2/fm])
subplot(514)
plot(t, r_t)
xlim([0 2/fm])
subplot(515)
plot(t, info)
xlim([0 2/fm])