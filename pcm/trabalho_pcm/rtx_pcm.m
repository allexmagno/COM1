clear all
close all
clc


%% Lendo um som
figure(2)
[y, Fs] = wavread('you-dont-know-how.wav');
subplot(211)
plot(y)
%sound(y,Fs);
Y_f = fftshift(fft((y)/length(y)));
f = -Fs/2:1/(length(y)/Fs):Fs/2-(1/(length(y)/Fs));
subplot(212)
plot(f, Y_f) 
plot(f, transpose(abs(Y_f)));
xlim([-6e3 6e3])
Vpp = max(y);
k = 13; % qtd de bits do quantizador
passo = Vpp/2^k; % Passo de quantizacao
t = [0:1/fa:1/fm];
%%
x_desl = x_n + ((Vpp/2) - (passo/2)); % Deslocando o sinal
x_desl2 = x_desl/passo; % Dividindo pelo passo para ter os niveis
x_qtz = round(x_desl2);
%aux_1 =  x_qtz == 2^k; % Caso daria 8
%aux_2 =  x_qtz == -1; % caso surgisse -1
%x_qtz = x_qtz - aux_1 + aux_2; % Para ficar dentro de 0 e 2^k
x_bin = de2bi(x_qtz); % vai gerar uma matriz
[x, y] = size(x_bin);
x_bin_linha = reshape(transpose(x_bin), 1, x*y); % Para colocar tudo em uma unica linha 
% Fim da quantizacao

%% Recuperando o Sinal

xdec_qtz = reshape(x_bin_linha, y, x); % sinal ainda quantizado
xdec_qtz1 = transpose(xdec_qtz); % o sinal original em uma coluna
xdec = bi2de(xdec_qtz1); % ou xdec = bi2de(transpose(xdec_qtz1)) 
xdec_passo = xdec * passo;
xdec_rec = xdec_passo - ((Vpp/2) - (passo/2));
plot(t,xdec_rec);

%% analizando o espctro
X_f = fftshift(fft(x_n)/length(x_n));
Xdec_f = fftshift(fft(xdec_rec)/length(xdec_rec));
f = -fa/2:1/(length(x_n)/fa):fa/2-(1/length(x_n)/fa)-1;
subplot(211)
stem(f, X_f)
xlim([-fm-fm*2/3 fm+fm*2/3])

subplot(212)
stem(f, Xdec_f)
xlim([-fm-fm*2/3 fm+fm*2/3])