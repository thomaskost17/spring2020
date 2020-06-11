%% ECE132A: Final Project -- Project 5
%  Author: Thomas Kost
%  UID: 504989794
%  Date: 6/3/20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc, clear, close all;
%% APRS RF Decoding

data  = loadFile('aprs23.dat');
dd    = decimate(decimate(data,8,'fir'),8,'fir');
dd(1) = 0;
plot(abs(dd));

[boundaries,m] = identify_message(dd);
% message boundaries have been found
for k =1:m
    lower = boundaries(k,1);
    upper = boundaries(k,2);
   % dp    = dd(lower:upper);
    dp  = dd(3.8e5+(1:16900));
    dp  = dp-sum(dp)/length(dp);
    dps = resample(dp,3,4);
    dpf = angle(conj(dps(1:end-1)).*dps(2:end));
    plot(dpf(500:2500))

t20 = [-10:9]/20;
mf1200 = exp(i*2*pi*t20*1.0);
mf2200 = exp(i*2*pi*t20*1.8);

d12 = conv(dpf,mf1200,'same');
d22 = conv(dpf,mf2200,'same');
ddif = abs(d12)-abs(d22);
figure(2);
plot(ddif)

offset = center_eye(ddif);
bts = ddif((offset+1:20:end)-offset)>0;
 n1 = 2000;
 n2 = n1 + 20*256 - 1;

 boff = [-10:9];
eyed = reshape(ddif((n1:n2)-10-offset),20,256);
 figure(10);
 plot(boff,eyed);
% bts = ddif((7:20:end)-6)>0;
% figure(4);
% plot(bts);
% xlim([0 200]);
% ylim([ -0.2 1.2]);

text = aprs_decode(bts);
fprintf(text);
end