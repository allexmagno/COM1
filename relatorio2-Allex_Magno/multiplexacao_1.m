%% Multiplexação
% ALLEX MAGNO ANDRADE
%
clear all;
close all;
clc

% Definindo os sinais de informacao
a1 = 4; a2 = 7; a3 = 3;
f1 = 1e3; f2 = 2e3; f3 = 3e3;
w1 = 2*pi*f1; w2 = 2*pi*f2; w3 = 2*pi*f3;

fa = 50e3;
ta = 1/fa;
t = 0:ta:1;
f = -fa/2:1:fa/2;

m1_t = a1*cos(w1*t);
m2_t = a2*cos(w2*t);
m3_t = a3*cos(w3*t);

% dominio do tempo e da frequencia
figure(1)
subplot(321)
plot(t, m1_t)
xlim([0 5/f1])
ylabel('m1(t)')
xlabel('t [s]')

subplot(323)
plot(t, m2_t)
xlim([0 5/f2])
ylabel('m2(t)')
xlabel('t [s]')

subplot(325)
plot(t, m3_t)
xlim([0 5/f3])
ylabel('m3(t)')
xlabel('t [s]')

m1_f = fftshift(fft(m1_t)/length(m1_t));
subplot(322)
plot(f, m1_f)
ylabel('M1(f)')
xlabel('f [Hz]')
xlim([-5e3 5e3])

m2_f = fftshift(fft(m2_t)/length(m2_t));
subplot(324)
plot(f, m2_f)
ylabel('M2(f)')
xlabel('f [Hz]')
xlim([-5e3 5e3])

m3_f = fftshift(fft(m3_t)/length(m3_t));
subplot(326)
plot(f, m3_f)
ylabel('M3(f)')
xlabel('f [Hz]')
xlim([-5e3 5e3])

% Sinais modulantes
fc1_t = 9e3; fc2_t = 10e3; fc3_t =11e3;
c1_t = cos(2*pi*fc1_t*t);
c2_t = cos(2*pi*fc2_t*t);
c3_t = cos(2*pi*fc3_t*t);

% Crindo os filtros passa faixa
filtroPA1 = fir1(50, [9.5e3*2]/fa, 'high')'; 
filtroPF2 = fir1(50, [11.5e3*2 12.5e3*2]/fa)';
filtroPF3 = fir1(50, [13e3*2 15e3*2]/fa)';


%Modulando os sinais
xs1_t = m1_t.*c1_t;
xs2_t = m2_t.*c2_t;
xs3_t = m3_t.*c3_t;

figure(2)
XS1_f = fftshift(fft(xs1_t)/length(xs1_t));
XS2_f = fftshift(fft(xs2_t)/length(xs2_t));
XS3_f = fftshift(fft(xs3_t)/length(xs3_t));

subplot(321)
plot(t, xs1_t)
xlim([0 5/f1])
ylabel('s1(t)')
xlabel('t [s]')

subplot(323)
plot(t, xs2_t)
xlim([0 5/f2])
ylabel('s2(t)')
xlabel('t [s]')

subplot(325)
plot(t, xs3_t)
xlim([0 5/f3])
ylabel('s2(t)')
xlabel('t [s]')

subplot(322)
plot(f, XS1_f)
ylabel('S1(f)')
xlabel('f [Hz]')
xlim([-17e3 17e3])

subplot(324)
plot(f, XS2_f)
ylabel('S2(f)')
xlabel('f [Hz]')
xlim([-17e3 17e3])

subplot(326)
plot(f, XS3_f)
ylabel('S3(f)')
xlabel('f [Hz]')
xlim([-17e3 17e3])
  
% Filtrando
x1_t = filter(filtroPA1, 1, xs1_t);
x2_t = filter(filtroPF2, 1, xs2_t);
x3_t = filter(filtroPF3, 1, xs3_t);

% Multiplexação dos sinais
s_t = x1_t + x2_t + x3_t;
figure(3)
subplot(211)
plot(t, s_t)
xlim([0 10/f1])
ylabel('s(t)')
xlabel('t [s]')

S_f = fftshift(fft(s_t)/length(s_t));
f = -fa/2:1:fa/2;
subplot(212)
plot(f, S_f)
ylabel('S(f)')
xlabel('f [Hz]')


%% Recuperando os sinais

%filtro PF
filtroPF1 = fir1(50, [9.8e3 10.2e3*2]/fa)';
filtroPA3 = fir1(50, [13.5e3*2]/fa, 'high')';
ys1_t = filter(filtroPF1, 1, s_t);
ys2_t = filter(filtroPF2, 1, s_t);
ys3_t = filter(filtroPA3, 1, s_t);

% Demodulando
y1d_t = ys1_t.*c1_t;
y2d_t = ys2_t.*c2_t;
y3d_t = ys3_t.*c3_t;

% Passando os sinais por filtro passa-baixa
filtroPB1 = fir1(100, [2e3*2]/fa)'; 
filtroPB2 = fir1(100, [3e3*2]/fa)';
filtroPB3 = fir1(100, [4e3*2]/fa)';

y1_t = filter(filtroPB1, 1, y1d_t);
y2_t = filter(filtroPB2, 1, y2d_t);
y3_t = filter(filtroPB3, 1, y3d_t);

figure(4)
subplot(321)
plot(t, y1_t)
xlim([0 20/f1])
ylabel('s1(t)')
xlabel('t [s]')

subplot(323)
plot(t, y1_t)
xlim([0 20/f2])
ylabel('s1(t)')
xlabel('t [s]')

subplot(325)
plot(t, y3_t)
xlim([0 20/f3])
ylabel('s1(t)')
xlabel('t [s]')

Y1_f = fftshift(fft(y1_t)/length(y1_t));
Y2_f = fftshift(fft(y2_t)/length(y2_t));
Y3_f = fftshift(fft(y3_t)/length(y3_t));

subplot(322)
plot(f, Y1_f)
xlim([-5e3 5e3])
ylabel('S1(f)')
xlabel('f [Hz]')

subplot(324)
plot(f, Y2_f)
xlim([-5e3 5e3])
ylabel('S2(f)')
xlabel('f [Hz]')

subplot(326)
plot(f, Y3_f)
xlim([-5e3 5e3])
ylabel('S3(f)')
xlabel('f [Hz]')