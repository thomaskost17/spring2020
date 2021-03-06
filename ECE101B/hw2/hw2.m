%% ECE101B: Hw2
% Author: Thomas Kost
% UID: 504989794
%Date: 4/15/20

clc;clear;close all;
%% 7.18
ur =1;
er=80;
sigma=4;
E = er*8.854e-12;
mu = ur*1.256e-6;

E_prime = E;
frequency = [1000:1000:10e9];
E_double_prime = sigma./(2*pi*frequency);
alpha = zeros(1,length(frequency));

for i =1: length(alpha)
    alpha(i) = 2*pi*frequency(i)*sqrt((mu*E_prime/2)*...
        (sqrt(1+(E_double_prime(i)/E_prime)^2)-1));
end

skin_depth_plot = figure(1);
loglog(frequency, 1./alpha);
xlabel('frequency (Hz)');
ylabel('Skin Depth (m)');
title('7.18 :skin depth v.s. frequency');
saveas(skin_depth_plot, 'skin_depth_plot.jpg');