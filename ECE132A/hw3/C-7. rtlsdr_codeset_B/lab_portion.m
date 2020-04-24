%% ECE132A: Computer Assignment 2
%Author : Thomas Kost
%Date : 4/14/20

clear,clc;
%% Find and Display Signals
data = loadFile('ab1355_10s.dat');
n_scale = 2048000;
n0 = 5*n_scale;
frequency = 2000;
block_size = n_scale/frequency;
ds = msg(data,n0,block_size, 2000)
fig3 =figure(3);
plot(abs(ds(:,1000)));
saveas(fig3, 'frequency_peak.jpg');
% we looked at time starting at 5 seconds
%we notice another signal, so plotting this we find a peak at line 401


fig4 = figure(4);
plot(abs(ds(401,:)));
xlabel('Time (s)');
ylabel('Amplitude (units)');
saveas(fig4, 'captured_signal.jpg');