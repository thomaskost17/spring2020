%%ECE132A: Homework 2
% Author: Thomas Kost
% UID: 504989794
% Date: 4/23/20
%% 4.13-5
clear,clc,close all;
ts=1.e-4 ;
t=- 0.04 : ts:0.04 ;
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
Lfft=length (t); Lfft=2^ceil(log2(Lfft));
M_fre=fftshift(fft (m_sig,Lfft));
freqm=( -Lfft/2 :Lfft/ 2- 1) /(Lfft*ts) ;
B_m=100; %Bandwidth of the signal i s B_m Hz .
% Design a simple lowpass filter with bandwidth B_rn Hz .
h=fir1(80,[B_m*ts]) ;
%
kf=50*pi;
m_intg=kf*ts*cumsum(m_sig);
s_fm=cos(2*pi * 400*t+m_intg) ;
s_pm=cos(2*pi* 300 *t+pi*m_sig) ;
Lfft=length(t) ; Lfft=2^ceil(log2(Lfft) +1) ;
S_fm=fftshift(fft(s_fm, Lfft)) ;
S_pm=fftshift(fft(s_pm,Lfft)) ;
freqs=(-Lfft/2 :Lfft/2-1)/(Lfft*ts) ;
s_fmdem=diff ( [s_fm(1) s_fm]) /ts /kf; 
s_fmrec=s_fmdem.*(s_fmdem>0);
s_dec=filter(h,1,s_fmrec) ;
% Demodulation
% Using an ideal LPF with bandwidth 200 Hz
Trange1=[-0.04 0.04 -1.2 1.2] ;
fig1 = figure(1)
subplot(211);m1=plot(t,m_sig);
axis(Trange1); set(m1, 'Linewidth' ,2);
xlabel('{\it t} (sec)'); ylabel(' {\it m}({ \it t})') ;
title('Message signal ' ) ;
subplot(212);m2=plot(t,s_dec) ;
set(m2, 'Linewidth' ,2);
xlabel('{\it t} (sec) ' ) ; ylabel( '{ \it m}_d({ \it t}) ' )
title('demodulated FM signal');
saveas(fig1, '4_13_5_1.jpg');
fig2 = figure(2)
subplot (211);tdl=plot(t,s_fm) ;
axis(Trange1); set(tdl,'Linewidth' , 2) ;
xlabel('{\it t} (sec) ' ) ; ylabel('{\it s}_{\rm FM}({\it t})');
title('FM signa l ');
subplot(212) ; td2=plot(t, s_pm) ;
axis( Trange1) ; set ( td2, 'Linewidth' , 2 ) ;
xlabel('{\it t } (sec) ' ) ; ylabel('{\it s}_{\rm PM} ({\it t) ) ' )
title( 'PM signal ' ) ;
saveas(fig2, '4_13_5_2.jpg');

fig3 = figure(3)
subplot(211);fpl=plot(t,s_fmdem) ;
set(fpl, 'Linewidth' , 2);
xlabel('{\it t} (sec) ' ) ; ylabel('{\it d s}_{\rm FM}({\it t}J/dt')
title( 'FM derivative') ;
subplot(212) ; fp2=plot(t, s_fmrec) ;
set(fp2,'Linewidth' , 2) ;
xlabel(' { \it t } (sec) ' );
title( 'rectified FM derivative');
Frange=[-600 600 0 300] ;
saveas(fig3, '4_13_5_3.jpg');

fig4 = figure(4)
subplot(211);fdl=plot(freqs,abs(S_fm));
axis(Frange); set(fdl, 'Linewidth' ,2);
xlabel('(\it f} (Hz)'); ylabel( '{ \it S}_{\rm FM} ( ( \it f}l');
title('FM amplitude spectrum') ;
subplot(212) ; fd2=plot(freqs, abs(S_pm));
axis(Frange); set(fd2, 'Linewidth' ,2) ;
xlabel('{\it f} (Hz) ' ); ylabel( '{\it S}_{\rm PM} ({\it f}) ' )
title('PM amplitude spectrum') ; 
saveas(fig4, '4_13_5_4.jpg');
