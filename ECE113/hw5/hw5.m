%% ECE113: Homework 5
% Author: Thomas Kost
% Date: 5/7/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc, clear, close all;
%% 5:
% create signal
fs = 100; %sampling frequency
t = 0:1/fs:50;%time axis
x = 2*sin(2*pi*30*t)+ 3*sin(2*pi*20*(t-2))+3*sin(2*pi*10*(t-4));%signal
N = length(x);

%A:
omega = 2*pi*(0:N-1)/N;
omega = fftshift(omega);
omega = unwrap(omega-2*pi);
X = fft(x,N); %compute N point of DFT of x
X = X/max(X);%rescale
fig1 = figure(1);
plot(omega,abs(fftshift(X)), 'LineWidth', 2);
title('DTFT of x[n]', 'fontsize', 14);
set(gca, 'fontsize', 14);
xlabel('Radians', 'fontsize', 14);
saveas(fig1, '5_a.jpg');
%B
w_r = t<=2;
x_r = x.*w_r;
X_r = fft(x_r,N);
X_r = X_r/max(X_r);

fig2 = figure(2);
plot(omega,abs(fftshift(X_r)), 'LineWidth', 2);
title('DTFT of x_r[n]', 'fontsize', 14);
set(gca, 'fontsize', 14);
xlabel('Radians', 'fontsize', 14);
saveas(fig2, '5_b.jpg');
%C
w_h = hamming(sum(w_r));
w_h = [w_h',zeros(1,N-length(w_h))];
x_h = w_h.*x;
X_h = fft(x_h,N);
X_h = X_h/max(X_h);

fig3 = figure(3);
plot(omega,abs(fftshift(X_h)), 'LineWidth', 2);
title('DTFT of x_h[n]', 'fontsize', 14);
set(gca, 'fontsize', 14);
xlabel('Radians', 'fontsize', 14);
saveas(fig3, '5_c.jpg');
