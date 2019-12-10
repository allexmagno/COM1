close all
clear all
clc

%% Analise de modula?ao no dominio da frequencia

% AM DSB SC (Amplitude Modulation Double-side Band Supressed Carrie)
ac = 1;
am = 1;
fm = 1e3;
fc = 20e3;
f_cut = 7e3;
n = 100;
fa = 20*fc;
t = [0:1/fa:1];
c_t = ac*cos(2*pi*fc*t);
m_t = 5*sin(2*pi*500*t) + 5/3*sin(2*pi*1500*t) + sin(2*pi*2500*t) + 5/7*sin(2*pi*3500*t) + 5/9*sin(2*pi* 4500*t) + 5/11*sin(2*pi*5500);

s_t = c_t.*m_t; % Sinal Modulado

r_t = s_t.*c_t; % Sinal demodulado

passa_baixa = fir1(n,(f_cut*2)/fa)';
info = filter(passa_baixa,1, r_t);

figure(1)
subplot(521)
plot(t, m_t)
xlim([0 4/500])
subplot(523)
plot(t,c_t)
xlim([0 4/500])
subplot(525)
plot(t, s_t)
xlim([0 4/500])
subplot(527)
plot(t, r_t)
xlim([0 4/500])
subplot(529)
plot(t, info)
xlim([0 4/500])

% Dominio da freq

M_f1 = fft(m_t)/length(m_t);
M_f =  fftshift(M_f1);
f = -fa/2:1:fa/2;
subplot(522)
plot(f, abs(M_f))
xlim([-1e5 1e5])
ylim([0 2])

C_f1 = fft(c_t)/length(c_t);
C_f =  fftshift(C_f1);
subplot(524)
plot(f, abs(C_f))
xlim([-1e5 1e5])

S_f1 = fft(s_t)/length(s_t);
S_f =  fftshift(S_f1);
subplot(526)
plot(f, abs(S_f))
xlim([-1e5 1e5])
ylim([0 2])

R_f1 = fft(r_t)/length(r_t);
R_f =  fftshift(R_f1);
subplot(528)
plot(f, abs(R_f))
xlim([-0.7e5 0.7e5])
ylim([0 1.5])
