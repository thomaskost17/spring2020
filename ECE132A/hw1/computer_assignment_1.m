%% ECE132A: Computer Assignment 1
%Author: Thomas Kost
%UID: 504989794
%Date: 4/7/2020

%% 2.10-1
clc,clear;
%variables used for generating our signals
dt =0.00001;
M=3;

%% Part A:
T=2*pi; %set period
time_a =[(-T/2):dt:(T/2)];%generate time 
f_a = zeros(1,length(time_a));
for i =1:length(f_a)
    if(time_a(i) >0)
        f_a(i) = exp(-time_a(i)/10);
    else
        f_a(i) = -exp(-(time_a(i)+pi)/10);
    end
end
power_a = periodic_power(f_a, T,dt, M);
%% Part B:
T =4;
time_b = [-T/2:dt:T/2];%generate time 
f_b = time_b.^3;
power_b = periodic_power(f_b,T,dt,M);
%% Part C:
x_c =f_a;
for i=1:length(x_c)
    x_c(i) = x_c(i)*2*cos(10*time_a(i));
end
T = 2*pi;
power_c = periodic_power(x_c,T,dt,M);
%% Part D:
x_d =f_b;
for i=1:length(x_d)
    x_d(i) = -x_d(i)*cos(5*pi*time_a(i));
end
T=4;
power_d = periodic_power(x_d,T,dt,M);

%generate some plots
figure(1);
subplot(2,2,1);
plot(time_a, f_a);
xlabel("t");
title("A");
subplot(2,2,2);
plot(time_b, f_b);
xlabel('t');
title('B');
subplot(2,2,3);
plot(time_a, x_c);
xlabel('t');
title('C');
subplot(2,2,4);
plot(time_b, x_d);
xlabel('t');
title('D');
saveas(1,"signal_plots.jpg");

fprintf("power of A: %f\n", power_a);
fprintf("power of B: %f\n", power_b);
fprintf("power of C: %f\n", power_c);
fprintf("power of D: %f\n", power_d);


function [power] = periodic_power(signal, period,dt, M_periods)
t = [-period/2:dt:period/2];
time=[];
y_periodic =[];
for i =-M_periods:M_periods-1
    time = [time i*period + t]; %#ok<AGROW>
    y_periodic = [y_periodic signal]; %#ok<AGROW>
end
power = sum(y_periodic*y_periodic')*dt/(max(time)-min(time));
end
