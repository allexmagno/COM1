% Lab_2 COM1
% ALLEX MAGNO ANDRADE

clear all
close all
clc

% Amplitudes
a1 = 5; a2 = 5/3; a3 = 1;

% Frequencia
f1 = 1; f2 = 3; f3 = 5;

% Amostras
fa = 50*f3;
ta = 1/fa;

t = 0:ta:5*f1;

% Gerando os sinais
s1_t = a1*cos(2*pi*f1*t);
s2_t = a2*cos(2*pi*f2*t);
s3_t = a3*cos(2*pi*f3*t);

s_t = s1_t + s2_t + s3_t;
% Plotando no dominio do tempo
figure(1)
subplot(411)
plot(t, s1_t)
xlabel("t [ms]")
ylabel("s1(t)")

subplot(412)
plot(t, s2_t)
xlabel("t [ms]")
ylabel("s2(t)")

subplot(413)
plot(t, s3_t)
xlabel("t [ms]")
ylabel("s3(t)")

subplot(414)
plot(t, s_t)
xlabel("t [ms]")
ylabel("s(t)")

% Plotando no dominio da frequencia
f = -fa/2:0.2:fa/2;

S1_f = fftshift(fft(s1_t)/length(s1_t));
S2_f = fftshift(fft(s2_t)/length(s2_t));
S3_f = fftshift(fft(s3_t)/length(s3_t));
S_f = fftshift(fft(s_t)/length(s_t));

figure(2)
subplot(411)
plot(f, abs(S1_f))
xlabel("f [Hz]")
ylabel("S1(f)")
xlim([-8 8])

subplot(412)
plot(f, abs(S2_f))
xlabel("f [Hz]")
ylabel("S2(f)")
xlim([-8 8])

subplot(413)
plot(f, abs(S3_f))
xlabel("f [Hz]")
ylabel("S3(f)")
xlim([-8 8])

subplot(414)
plot(f, abs(S_f))
xlabel("f [Hz]")
ylabel("S(f)")
xlim([-8 8])


%% Projetando filtro ideais

filtro_pb = ([zeros(1, 615) ones(1, 21) zeros(1, 615)]);
filtro_pa = ([ones(1, 605) zeros(1, 41) ones(1, 605)]);
filtro_pf = ([zeros(1, 605) ones(1, 11) zeros(1, 20) ones(1, 11) zeros(1, 604)]);

% Resposta em freq
figure(3)
subplot(311)
plot(f, filtro_pb)
ylabel("Hz")
xlim([-5 5])

subplot(312)
plot(f, filtro_pa)
ylabel("Hz")
xlim([-5 5])

subplot(313)
plot(f, filtro_pf)
ylabel("Hz")
xlim([-5 5])

% Passando o sinal por cada filtro
s_f1 = filtro_pb.*S_f;
s_f2 = filtro_pa.*S_f;
s_f3 = filtro_pf.*S_f;


% Sinal no tempo
figure(4)
s_t1 = ifft(ifftshift(s_f1));
subplot(311)
plot(t, s_t1)

s_t2 = ifft(ifftshift(s_f2));
subplot(312)
plot(t, s_t2)

s_t3 = ifft(ifftshift(s_f3));
subplot(313)
plot(t, s_t3)
