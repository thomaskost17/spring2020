%%ECE132A: Homework 2
% Author: Thomas Kost
% UID: 504989794
% Date: 4/23/20
%% 4.13-1
clear, clc;close all;
%generate signal

ts=1.e-4;
t=-0.04 : ts :0.04;
Ta=0.01; 

m_sig  = zeros(1,length(t));

for i =1:length(t)
    if(t(i) <-0.02 && t(i) >= -0.04)
        m_sig(i) = -0.125*(100*t(i)+4)^3;
    elseif (t(i)>= -0.02 && t(i) <0.02)
        m_sig(i) = 0.125*(100*t(i))^3;
    elseif (t(i)>= 0.02 && t(i) <= 0.04)
        m_sig(i) = -0.125*(100*t(i)-4)^3;
    end
end


Lfft=length(t) ; Lfft=2^ceil(log2(Lfft)) ;
M_fre=fftshift( fft (m_sig,Lfft)) ;
freqm= (-Lfft/2:Lfft/2-1) / (Lfft*ts) ;
s_dsb=m_sig.*cos(2*pi*500*t);
Lfft=length(t) ; Lfft=2^ceil(log2(Lfft)+1) ;
S_dsb=fftshift(fft(s_dsb,Lfft)) ;
freqs=( -Lfft/2: Lfft/2-1)/(Lfft*ts) ;
Trange=[-0.03 0.03 -2 2]
fig1 = figure(1)
subplot(221); tdl=plot(t,m_sig);
axis(Trange); set(tdl, 'Linewidth' , 1) ;
xlabel('{\it t} (sec)') ; ylabel('{\it m}({\it t})')
subplot(223) ; td2=plot(t,s_dsb);
axis(Trange) ; set(td2, 'Linewidth' , 1) ;
xlabel('{\it t} (sec)') ; ylabel('{\it s}_{\rm DSB}({\it t}) ') 
Frange=[-600 600 0 200]
subplot(222) ; fdl=plot(freqm,abs(M_fre));
axis(Frange); set(fdl, 'Linewidth' ,1);
xlabel ('{\it f} (Hz)') ; ylabel ('{\it M} ({\it f})')
subplot (224);fd2=plot(freqs,abs(S_dsb));
axis(Frange); set(fd2, 'Linewidth',1);
xlabel ( '{\it f}(Hz)') ; ylabel ( '{\it S}_{\rm DSB} ({\it f}) ') 
saveas(fig1, '4_13_1_a_b.jpg');

B_m=250; %Bandwidt h of the signal is B_m Hz.
h=fir1(40,(B_m*ts)); 

fc=500;
% Demodulation begins by multiplying with the carrier
s_dem=s_dsb.*cos(2*pi*fc*t)*2;
S_dem=fftshift(fft(s_dem,Lfft));
% Using an ideal LPF with bandwidth 150 Hz
s_rec=filter(h,1,s_dem);
S_rec=fftshift(fft(s_rec,Lfft));
Trange=[-0.025 0.025 -2 2];
fig2 = figure(2)
subplot(221) ; tdl=plot(t, m_sig) ;
axis(Trange) ; set(tdl, 'Linewidth' ,1) ;
xlabel('{\it t} (sec)') ; ylabel('{\it m}({\it t})') ;
title('message signal');
subplot(222); td2=plot(t,s_dsb);
axis(Trange) ; set(td2 , 'Linewidth',1) ;
xlabel (' {\it t} (sec)') ; ylabel ( ' {\it s}_{\rm DSB} ({\it t }) ')
title( ' DSB-SC modulated signal') ;
subplot(223);td3=plot(t,s_dem);
axis(Trange) ; set(td3, 'Linewidth',1) ;
xlabel('{\it t} (sec)') ; ylabel('{\it e}({\it t)) ')
title(' {\it e}({\it t}) ' ) ;
subplot(224);td4=plot(t, s_rec) ;
axis(Trange) ; set(td4, 'Linewidth' , 1);
xlabel ('{\it t} (sec)'); ylabel('{ \it m}_d( {\it t })')
title('Recovered signal' );
Frange=[-700 700 0 2001] ;

saveas(fig2, '4_13_1_c_d_1.jpg');
fig3 = figure(3)
subplot(221); fd1=plot(freqm,abs(M_fre));
axis(Frange) ; set(fdl,'Linewidth',1) ;
xlabel('{\it f} ( Hz ) '); ylabel('{\it M}({\it f})') ;
title('message spectrum');
subplot(222);fd2=plot(freqs,abs(S_dsb)) ;
axis(Frange); set(fd2, 'Linewidth' ,1) ;
xlabel('{\it f } ( Hz )'); ylabel('{\it S}_{\rm DSB} ({\it f})') ;
title('DSB-SC spectrum') ;
subplot(223) ; fd3=plot(freqs,abs(S_dem)) ;
axis (Frange) ; set(fd3 ,'Linewidth' , 1);
xlabel('{\it f } (Hz )'); ylabel('{ \it E}({ \it f }) ');
title('spectrum of {\it e}({\it t })' ) ;
subplot(224) ; fd4=plot(freqs,abs(S_rec));
axis(Frange) ; set(fd4, 'Linewidth' ,1) ;
xlabel('{\it f} (Hz)') ; ylabel('{\it M} _d({\it f}) ');
title(' recovered spectrum' ) ; 

saveas(fig3, '4_13_1_c_d_2.jpg');

 