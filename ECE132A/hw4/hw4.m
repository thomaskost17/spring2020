%% ECE132A: Computer Assignment 4
% Author: Thomas Kost
% UID: 504989794
% Date: 5/3/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear,clc,close all;


%%Relevant Code, Change subband by looking at values output from ffreq
%%this will give you various stations for each channel +/- 400000 and 
%%+/-800000 work to get from channel to channel and 0
subband = 000000;
data = loadFile('wfm941_10s.dat');
fig1 =figure(1);
ffreq( data)
fs = 2048000; % sampling frequency
dt = 1/fs; % sampling time
t = [1:length(data)]'*dt; % time of each of the samples of d
data = data.*exp(-i*2*pi*(-subband)*t);
msg(data,1,1024,2000);
saveas(fig1, 'fig1.jpg');
d = decimate(data,8,'fir'); 
fig2 = figure(2);
msg(d,1,1024,2000);
%dfm = angle(conj(d(1:end-1)).*d(2:end));
dl = d./abs(d); % Eliminate amplitude variations
load('hd.mat');
df = imag(conv(dl,hd,'same').*conj(dl));
dfd = decimate(decimate(df,8,'fir'),2,'fir');
dfd = dfd / max(abs(dfd));
fprintf('Playing Sound\n');
sound(dfd,16000);
%pause(10);
saveas(fig2,'fig2.jpg');

%This portuion of the code is commented our but was used to examine the
%subbands from the stereo
%listening to L-R
%{
fs = 2048000; % sampling frequency
dt = 1/fs; % sampling time
t = [1:length(data)]'*dt; % time of each of the samples of d
dm = data.*exp(-i*2*pi*(-67000)*t);
dfm = angle(conj(dm(1:end-1)).*dm(2:end));
dmd = decimate(dfm,8,'fir');
dmdd = decimate(dmd, 8,'fir');
dmddd = decimate(dmdd, 4, 'fir');
fprintf('Playing Second Sound');
sound(abs(dmddd),8000);
pause(10);
fs = 2048000; % sampling frequency
dt = 1/fs; % sampling time
t = [1:length(data)]'*dt; % time of each of the samples of d
dm = data.*exp(-i*2*pi*(-92000)*t);
dfm = angle(conj(dm(1:end-1)).*dm(2:end));
dmd = decimate(dfm,8,'fir');
dmdd = decimate(dmd, 8,'fir');
dmddd = decimate(dmdd, 4, 'fir');
fprintf('Playing Third Sound');
sound(abs(dmddd),8000);
%}