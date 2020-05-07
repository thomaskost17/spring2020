%%ECE132A: Homework 2
% Author: Thomas Kost
% UID: 504989794
% Date: 4/23/20
%% Hw3:lab
clear,clc,close all;
d = HM('fm_band.csv');
mv = min(min(d));
fig1=figure(1);
imshow(d,[mv,0]);
 saveas(fig1, 'lab_3_1.jpg');
d = loadFile('ab1355_10s.dat');
f = ffreq(d)
fig2=figure(2);
msg(d,1,1024,2000); 
saveas(fig2, 'lab_3_2.jpg');

fs = 2048000 % sampling frequency
dt = 1/fs % sampling time
t = [1:length(d)]'*dt; % time of each of the samples of d
dm = d.*exp(-i*2*pi*(-396000)*t); % d is the RF data loaded above, dm is is the
% demodulated data
fig3=figure(3);
msg(dm,1,1024,2000);
saveas(fig3, 'lab_3_3.jpg');

dmd = decimate(dm,8,'fir');
dmdd = decimate(dmd, 8, 'fir');
f1 = ffreq(dmdd)
fs = fs/64;
dt = 1/fs ;
t1 = [1:length(dmdd)]'*dt;
dmddd = dmdd.*exp(-i*2*pi*(-388000)*t1);
dmdddd = decimate(dmddd, 8, 'fir');

fig4=figure(4);
ds = msg(dmddd,1,256,512)
saveas(fig4, 'lab_3_4.jpg');

fig5 = figure(5);
plot(abs(ds(:,512)));
saveas(fig5, 'lab_3_5.jpg');

sound(abs(dmdddd), 16000);
