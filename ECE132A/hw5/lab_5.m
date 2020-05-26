%% ECE132A: Computer Assignment 5 (Hardware Lab)
% Author: Thomas Kost
% UID: 504989794
% Date: 5/18/20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear, clc, close all;

dk = loadFile('rke312590.dat');
fs = 2048000;
t = [1:length(dk)]/2048000;
figure(1);
plot(t(1:1000:end),abs(dk(1:1000:end)));
figure(2);
plot(t(2*fs:2.1*fs),abs(dk(2*fs:2.1*fs)));
figure(3)
plot(t(2.03*fs:2.04*fs),abs(dk(2.03*fs:2.04*fs)));
dkd = abs(dk)>15;
figure(4);
subplot(211);
plot(t(2.03*fs:2.06*fs),abs(dkd(2.03*fs:2.06*fs)));
axis([2.03,2.06, -0.5, 1.5]);
title('Key Press 1');
subplot(212);
plot(t(5.185*fs:5.215*fs),abs(dkd(5.185*fs:5.215*fs)));
axis([5.185,5.215, -0.5, 1.5]);
title('Key Press 2');
%signal span
%2.03-2.568
%5.185-5.717
key1 = dkd(2.03*fs:2.568*fs);
key2 = dkd(5.185*fs:5.717*fs);
starting_condition = 0;

%key1
width = 3832-2478; %found from data
%first midpoint
mid = (3832+2478)/2;
key1_bits = key1(mid:width:end);
%key2
width = 5963-4614;
mid = (5963+4614)/2;
key2_bits = key2(mid:width:end);

di = loadFile('ism910.dat');
figure(5);
msg(di,1,512,2048);
figure(6);
plot(abs(di(1:1000:end/8)));
spectrogram =figure(7);
msg(di, 1873000,128,512,20);
saveas(spectrogram, 'spectrogram.jpg');
dat = loadFile('vhf145.dat');
dfms = figure(8);
msg(dat, 1, 512,128,30);
ffreq(dat)
fs = 2048000; % sampling frequency
dt = 1/fs; % sampling time
t = [1:length(dat)]'*dt;
dat = dat.*exp(-i*2*pi*(-10000)*t);
d = decimate(dat,8,'fir');
d=decimate(d,8,'fir');
msg(d,1,200,128,30);

load('hd.mat');
df = imag(conv(d,hd,'same').*conj(d));
msg(df,1,128,512,30);
saveas(dfms,'dfm.jpg');
figure(9);
plot(df);
ddf = df(1:8e4);
plot(ddf);
ddf = (ddf>-20) + (ddf<-130);
figure(10);
%apply exponential smoother and then demarcate
% alpha = 0.8;
% for i = 3:length(ddf)
% ddf(i) = alpha*ddf(i) +(1-alpha)*ddf(i-1);
% end
% for i = 3:length(ddf)
% ddf(i) = alpha*ddf(i) +(1-alpha)*ddf(i-1);
% end
% for i = 3:length(ddf)
% ddf(i) = alpha*ddf(i) +(1-alpha)*ddf(i-1);
% end
window = ones(1,200);
window = [window, zeros(1,length(ddf)-200)];
for i=0:(length(ddf)/200)-1
    win =circshift(window,200*i);
    sum1 = sum(ddf'.*win);
    ddf(200*i+1: 200*(i+1))= sum1;
    
end
%threshhold about 20
ddf = ddf>20;
plot(ddf)
%examine the bit lengths
len =2000;
mid = 2000;
dfm_bits = ddf(mid:len:end);
fid = fopen('bits.txt','w');
fprintf(fid, 'Key 1 bits:\n');
fprintf(fid,'%i', key1_bits);
fprintf(fid,'\n');
fprintf(fid, 'Key 2 bits:\n');
fprintf(fid,'%i', key2_bits);
fprintf(fid, '\n');
fprintf(fid, 'DFM bits:\n');
fprintf(fid,'%i', dfm_bits);
fprintf(fid, '\n');
fclose(fid);

