clear all
close all

N = 20;
M = 4;
fc = 10e3;
info = randint(1, 10,M);
passo = ((2*length(info))/fc)/(length(info)*N);
% Sinal digital (PAM, PWM, PCM). 
info_rect = rectpulse(info, N); % sinal PAM
t = [0:passo:((2*length(info))/fc)-passo];

%% M-PSK
sinal_MPSK = exp(j*2*pi*info/M);
s_t_MPSK = cos(2*pi*fc*t + ((2*pi*info_rect)/M));
%s_t_BPSK = ((((2*pi*info_rect)/2)*2)-1)*cos(2*pi*fc*t); 

%% FSK
s_t_MFSK = cos(2*pi*fc*t.*(info_rect + 1));

%% ASK
s_t_MASK = info_rect.* cos(2*pi*fc*t);

%% plots

figure(1)
subplot(411)
plot(t, info_rect)

subplot(412)
plot(t, s_t_MPSK)
subplot(413)
plot(t, s_t_MFSK)
subplot(414)
plot(t, s_t_MASK)