% Modulacao PSK
% BPSK, QPSK
%
% 0-> |INFO| -> 011010 -> |MODULACAO| ->

% MODULACAO = (FI)i= (2*pi*i)/M
% Ae^((j*pi*i)/M)

%% BPSK M = 2
M = 2;
fc = 10e3; %freq da portadora
info = [1 0 0 1];
info_BPSK = exp((j*2*pi*info)/M); % Modulacao em banda base
%Para deixar temporal (T) tem que deixar em funcao de um cos(W0t)
info_BPSK = rectpulse(info_BPSK, 40); % multiplicou cada simbolo por 20
% Definir periodos da portadora para cada simbolo., Nesse caso, 2/simbolo
% Se foram 4 simbolos * 2 = 8. 
passo = (8/fc)/160;
t = [0:passo:(8/fc)-passo];
% portadora
c_t = cos(2*pi*fc*t);
s_t = info_BPSK.*cos(2*pi*fc*t);
subplot(311)
plot(t, info_BPSK)
subplot(312)
plot(t, c_t)
subplot(313)
plot(t, s_t)

%% BPSK M = 2 superamostrado
clc
clear all
close all

M = 2;
N = 40;
fc = 10e3; %freq da portadora
info = randint(1, 10000);
info_BPSK = exp((j*2*pi*info)/M); % Modulacao em banda base
%Para deixar temporal (T) tem que deixar em funcao de um cos(W0t)
info_BPSK = rectpulse(info_BPSK, N); % multiplicou cada simbolo por N
% Definir periodos da portadora para cada simbolo., Nesse caso, 2/simbolo
% Se foram 4 simbolos * 2 = 8. 
passo = ((2*length(info))/fc)/length(info_BPSK);
t = [0:passo:((2*length(info))/fc)-passo];
% portadora
c_t = cos(2*pi*fc*t);
s_t = info_BPSK.*cos(2*pi*fc*t);
%%
figure(1)
subplot(311)
plot(t, info_BPSK)
xlim([0 30/fc])
subplot(312)
plot(t, c_t)
xlim([0 30/fc])
subplot(313)
plot(t, s_t)
xlim([0 30/fc])

%%
INFO_BPSK = fftshift(fft(info_BPSK));
S_t = fftshift(fft(s_t));
f = [-100e3:0.5:(100e3)-0.5];
figure(2)
subplot(211)
plot(f, abs(INFO_BPSK).^2); %Densidade espectral de frequencia
subplot(212)
plot(f, abs(S_t).^2);