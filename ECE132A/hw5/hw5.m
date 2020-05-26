%% ECE132A: Computer Assignment 5
% Author: Thomas Kost
% UID: 504989794
% Date: 5/15/20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear, clc, close all;

%% 6.10-4:

% generate baseband waveforms
data = ceil(8*abs(rand(1,400)))-5;
Tau = 32;                                     %define Symbol Period
Tped = 0.001;                                 %true symbol period Tped in second
dataup = upsample(data,Tau);

yfw = conv(dataup,prect(Tau));
yfw = yfw(1:end-Tau+1);

Td =4;                                        %truncate raised cosine to 4 periods
rolloff = 0.6
yrcos = conv(dataup, prcos(rolloff,Td,Tau));
yrcos = yrcos(Td*Tau-Tau/2:end-2*Td*Tau+1);
txis = (1:1000)/Tau;
Baseband = figure(1);
subplot(211);
w1 = plot(txis, yfw(1:1000)); title('(i) Full Width Waveform');
axis([0,1000/Tau -4,3]); xlabel( 'time unit(T sec)');
subplot(212);
w2=plot(txis,yrcos(1:1000));title('(ii) Raised-Cosine Waveform');
axis([0,1000/Tau -5,4]); xlabel( 'time unit(T sec)');

Nwidth =2;
edged=1/Tau;
eyeplots = figure(2);
subplot(211);
eye1 = eyeplot(yfw,Nwidth,Tau,0); title('(i) Full width Eye Diagram');
axis([-edged Nwidth+edged,-5,4]);xlabel('time unit(T seconds)');
subplot(212);
eye2 = eyeplot(yrcos,Nwidth,Tau,0); title('(ii) Raised Cosine Eye Diagram');
axis([-edged Nwidth+edged,-5,4]);xlabel('time unit(T seconds)');

saveas(Baseband, 'baseband.jpg');
saveas(eyeplots, 'eyeplots.jpg');

%% Fucntions

% generate full width rectangular pulse  of width T
% usage pout = pnrz(T)
function pout = prect(T)
pout = ones(1,T);
end

% generate rolloff cosine, 
% usage y=prcos(rollfac,length,T)
function y=prcos(rollfac,length,T)
% 0 <= rollfac <= 1
% length is the one-sided pulse length in the number of T
% length  = 2T+1
% T is oversampling rate
y=rcosdesign(rollfac,length, T,'normal');
y = y/max(y);
end

function eyesuccess = eyeplot(onedsignal,Npeye, NsampT,Toffset)
Noff = floor(Toffset*NsampT);
Leye = ((1:Npeye*NsampT)/NsampT);
Lperiod=floor((length(onedsignal)-Noff)/(Npeye*NsampT));
Lrange = Noff+1:Noff+Lperiod*Npeye*NsampT;
mdsignal=reshape(onedsignal(Lrange),[Npeye*NsampT Lperiod]);
plot(Leye,mdsignal,'k');
eyesuccess=1;
return
end


