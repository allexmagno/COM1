clear all
close all
clc

A = 10;
fa = 20e3;
f1 = 1e3;
t = [0:1/fa:100*(1/f1)];

x_t = cos(2*pi*t*f1);
%plot (t, x_t)

X_f = fft(x_t);
figure(1)
subplot(221)
plot(t, x_t)

subplot(222)
plot(abs(X_f))

% Nesse caso, o matlab vai jogar as amostras, mas nao esta na janela
% correta
X_f_shift = fftshift(X_f);
%subplot(512)
%plot(abs(X_f_shift))

% Para ficar na janela correta, deve-se come?ar pelo n de amostragem/2 com
% o mesmo numero de passos. Nesse caso 2001. O Numero de passo nao fica so
% em fun?ao de fa, mas tambem do periodo e deve ser analisado a cada caso.
f = [-fa/2:10:fa/2];
subplot(223)
plot(f, abs(X_f_shift))

% A amplitude por enquanto esta mostrando a quantidade de amostra que tem.
% Para normalizar, divide-ser pelo tamanho do vetor de x_t
X_fe = fft(x_t)/length(x_t);
subplot(224)
plot(f, X_fe)