
%Laboratorio de modulacao AM DSB
%%
clear all;
close all;
clc;
%% Modulacao

Am = 1; % Amplitude da onda
Ac = 1; % Amplitude da onda portadora
fm = 1e3; %freq do sinal banda base
fc = 10e3;  % freq da portadora
fa = 20*fc; % freq de amostragem
t = 0:1/fa:1; 
f = -fa/2:1:fa/2;

c_t = Am*cos(2*pi*fc*t); % sinal da portadora
m_t = Am*cos(2*pi*fm*t); % sinal banda base
s_t = m_t.*c_t;

figure(1)
subplot(321)
plot(t, m_t)
xlim([0 5/fm])
ylabel('m(t)')
xlabel('t [s]')

subplot(323)
plot(t, c_t)
xlim([0 5/fc])
ylabel('c(t)')
xlabel('t [s]')

subplot(325)
plot(t, s_t)
xlim([0 5/fm])
ylabel('s(t)')
xlabel('t [s]')

M_f = fftshift(fft(m_t)/length(m_t));
C_f = fftshift(fft(c_t)/length(c_t));
S_f = fftshift(fft(s_t)/length(s_t));

subplot(322)
plot(f, M_f)
xlim([-1.5e3 1.5e3])
ylabel('M(f)')
xlabel('f [Hz]')

subplot(324)
plot(f, C_f)
xlim([-10.5e3 10.5e3])
ylabel('C(f)')
xlabel('f [Hz]')

subplot(326)
plot(f, S_f)
xlim([-11.5e3 11.5e3])
ylabel('S(f)')
xlabel('f [Hz]')

sy_t = s_t.*c_t;
n = 50;
filtroPB  = fir1(n, 2e3*2/fa);

%my_t = conv(sy_t, filtroPB);
my_t = filter(filtroPB, 1, sy_t);

figure(2)
subplot(221)
plot(t, sy_t)
xlim([0 5/fm])
xlabel('t [s]')
ylabel('sy(t)')

SY_f = fftshift(fft(sy_t)/length(sy_t));
subplot(222)
plot(f, SY_f)
xlim([-21.5e3 21.5e3])
xlabel('f [Hz]')
ylabel('SY(f)')

subplot(223)
plot(t, my_t)
xlim([0 5/fm])
xlabel('t [s]')
ylabel('my(t)')

MY_f = fftshift(fft(my_t)/length(my_t));
subplot(224)
plot(f, MY_f);
xlim([-1.5e3 1.5e3])
xlabel('f [Hz]')
ylabel('MY(f)')
%%

%m = Am/A0;  indice de modulacao deve estar entre 0 e 1
% m = (Amax - Amin)/(Amax + Amin)
% Amax = valor de borda da onda maior; E Amin valor de borda da onda menor
% do sinal modulado
%
m1 = 0.25; % indice de modulacao
m2 = 0.5;
m3 = 0.75;
m4 = 1;
m5 = 1.5;
A0_1 = Am/m1;
A0_2 = Am/m2;
A0_3 = Am/m3;
A0_4 = Am/m4;
A0_5 = Am/m5;
s1_t = (A0_1 + m_t).*c_t; % Sinal modulado 1a formulda
s2_t = (A0_2 + m_t).*c_t;
s3_t = (A0_3 + m_t).*c_t;
s4_t = (A0_4 + m_t).*c_t;
s5_t = (A0_5 + m_t).*c_t;


figure(3)
subplot(511)
plot(t, s1_t);
xlim([0 9/fm])
xlabel('m(t)')
ylabel('t [s]')

subplot(512)
plot(t, s2_t);
xlim([0 9/fm])
xlabel('m(t)')
ylabel('t [s]')

subplot(513)
plot(t, s3_t);
xlim([0 9/fm])
xlabel('m(t)')
ylabel('t [s]')

subplot(514)
plot(t, s4_t);
xlim([0 9/fm])
xlabel('m(t)')
ylabel('t [s]')

subplot(515)
plot(t, s5_t);
xlim([0 9/fm])
xlabel('m(t)')
ylabel('t [s]')

%% Frequencia
%
%S1_f = fftshift(fft(s1_t)/length(s1_t));
%S2_f = fftshift(fft(s2_t)/length(s2_t));
%S3_f = fftshift(fft(s3_t)/length(s3_t));
%S4_f = fftshift(fft(s4_t)/length(s4_t));
%S5_f = fftshift(fft(s5_t)/length(s5_t));
%
%f = -fa/2:1:fa/2;
%
%subplot(522)
%plot(f, abs(S1_f));
%
%subplot(524)
%plot(f, abs(S1_f));
%
%subplot(526)
%plot(f, abs(S1_f));
%
%subplot(528)
%plot(f, abs(S1_f));
%
%subplot(5,2,10)
%plot(f, abs(S5_f));


