%% ECE132A: Computer Assignment 2
%Author : Thomas Kost
%Date : 4/14/20

%% 3.10-3
clear; clc; clf; hold off; clear;
%generate triangle wave
tau = 1;
B  = 4/tau;
Ts = 1/(2*B);
T0 = 4*tau;
N0 = T0/Ts;
k = 0:N0-1; 
fsamp = (0:4*N0)/(4*N0*Ts)-B;
gtd = zeros(1, N0);
A = 1;
Tmid = ceil(N0/2);
for i = 1:Tmid+1
    gtd(i) = (1-2*(i-1)*Ts)*rectangularPulse(-0.5,0.5,(i-1)*Ts);
end
%tedge = round(tau/(2*Ts));
%if abs(tau-tedge*2*Ts) < 1.e-13
%    gtd(tedge+1) = A/2;
%end
gtd(N0:-1:N0-Tmid+2) = gtd(2:Tmid);
tvec = k*Ts;
fvec = k/(N0*Ts)-B;
Gq = real(fftshift(fft(Ts*gtd)));
fig1 = figure(1);
stem([tvec-T0 tvec], [gtd gtd], 'b');
xlabel('Time (s)');
ylabel('Magnitude (units)');
grid;
saveas(fig1, 'time_domain_input.jpg');

fig2 = figure(2);
stem(fvec,Gq,'b:');
xlabel('Frequency (1/s)');
ylabel('Magnitude (units)');
grid;
saveas(fig2, 'fourier_input.jpg');
%now transform and filter
q = 0:N0-1;
fcutoff = 2/tau;
fs = 1/(N0*Ts);
qcutoff = ceil(fcutoff/fs);
Hq(1:Tmid+1)=0;
Hq(1:qcutoff)=1;
Hq(qcutoff+1)=0.5;
Hq(N0:-1:N0-Tmid+2) = Hq(2:Tmid);
Yq = (Gq).*fftshift(Hq);
yk = ifft(fftshift(Yq))/Ts;
fig3 = figure(3);
stem(k, fftshift(yk));
title ('filtered frequency');
xlabel( 'index')
ylabel('H(f)G(f)'0);
saveas(fig3, 'filtered_frequency.jpg');

gtshift = fftshift(gtd);
hk = fftshift(ifft(Hq));
ykconv = conv(gtshift, hk);
ykpad = [zeros(1,N0/2) fftshift(yk) zeros(1,N0/2)];
fig4 = figure(4); hold off; 
tvec2 = Ts*[1:2*N0-1];
subplot(311);
stem(fvec,Gq, 'b');grid;
title('Input Frequency Response');
xlabel('f Hz');
ylabel('G(f)');
subplot(312);
stem(fvec,fftshift(Hq), 'b'); grid;
title('Lowpass Filter Gain');
xlabel('f Hz')
ylabel('H(f)');
subplot(313);
stem(tvec2,ykconv,'b'); grid;
title('Lowpass filter output');
xlabel(' t sec');
ylabel('y(t)');
saveas(fig4,'filter_results.jpg');
