%% ECE Final Project Problem 1
% Author: Thomas Kost, Felie Areces, Wenxu Gu, Jayson Shinn
% UID: 504989784
% Date: 5/13/20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear,clc, close all;
%% 1A:
chords = 10;

%read audio files
[a,Fs_a]   = audioread('wav\a\a1.wav');
[am,Fs_am] = audioread('wav\am\am1.wav');
[bm,Fs_bm] = audioread('wav\bm\bm1.wav');
[c,Fs_c]   = audioread('wav\c\c1.wav');
[d,Fs_d]   = audioread('wav\d\d1.wav');
[dm,Fs_dm] = audioread('wav\dm\dm1.wav');
[e,Fs_e]   = audioread('wav\e\e1.wav');
[em,Fs_em] = audioread('wav\em\em1.wav');
[f, Fs_f]  = audioread('wav\f\f1.wav');
[g,Fs_g]   = audioread('wav\g\g1.wav');

%generate the frequency axes
[omega_a,N_a] = dft_freq(a);
[omega_am,N_am] = dft_freq(am);
[omega_bm,N_bm] = dft_freq(bm);
[omega_c,N_c] = dft_freq(c);
[omega_d,N_d] = dft_freq(d);
[omega_dm,N_dm] = dft_freq(dm);
[omega_e,N_e] = dft_freq(e);
[omega_em,N_em] = dft_freq(em);
[omega_f,N_f] = dft_freq(f);
[omega_g,N_g] = dft_freq(g);

%scale frequencies
omega_a = omega_a*Fs_a;
omega_am = omega_am*Fs_am;
omega_bm = omega_bm*Fs_bm;
omega_c = omega_c*Fs_c;
omega_d = omega_d*Fs_d;
omega_dm = omega_dm*Fs_dm;
omega_e = omega_e*Fs_e;
omega_em = omega_em*Fs_em;
omega_f = omega_f*Fs_f;
omega_g = omega_g*Fs_g;

%generate FFT
A  =  fft(a,N_a);
AM =  fft(am,N_am);
BM =  fft(bm,N_bm);
C  =  fft(c,N_c);
D  =  fft(d,N_d);
DM =  fft(dm,N_dm);
E  =  fft(e,N_e);
EM =  fft(em,N_em);
F  =  fft(f,N_f);
G  =  fft(g, N_g);

%A = A/max(A);
%plot
chord_plot = figure(1);
subplot(5,2,1);
plot(omega_a, abs(fftshift(A)));
xlim([-20000 20000]);
%axis 'auto x';
title('A');
subplot(5,2,2);
plot(omega_am, abs(fftshift(AM)));
xlim([-20000 20000]);
title('AM');
subplot(5,2,3);
plot(omega_bm, abs(fftshift(BM)));
xlim([-20000 20000]);
title('BM');
subplot(5,2,4);
plot(omega_c, abs(fftshift(C)));
xlim([-20000 20000]);
title('C');
subplot(5,2,5);
plot(omega_d, abs(fftshift(D)));
xlim([-20000 20000]);
title('D');
subplot(5,2,6);
plot(omega_dm, abs(fftshift(DM)));
xlim([-20000 20000]);
title('DM');
subplot(5,2,7);
plot(omega_e, abs(fftshift(E)));
xlim([-20000 20000]);
title('E');
subplot(5,2,8);
plot(omega_em, abs(fftshift(EM)));
xlim([-20000 20000]);
title('EM');
subplot(5,2,9);
plot(omega_f, abs(fftshift(F)));
xlim([-20000 20000]);
title('F');
subplot(5,2,10);
plot(omega_g, abs(fftshift(G)));
xlim([-20000 20000]);
title('G');
saveas(chord_plot, 'chord_plot.jpg');
%% 1B:
%function identify_chord implemented at bottom

%% 1C:
%pull in the test data

test_1  = audioread('test\1.wav');
test_2  = audioread('test\2.wav');
test_3  = audioread('test\3.wav');
test_4  = audioread('test\4.wav');
test_5  = audioread('test\5.wav');
test_6  = audioread('test\6.wav');
test_7  = audioread('test\7.wav');
test_8  = audioread('test\8.wav');
test_9  = audioread('test\9.wav');
test_10 = audioread('test\10.wav');

%make testing matrix for consise implemtation
test_lengths = [length(test_1), length(test_2), length(test_3),...
    length(test_4), length(test_5), length(test_6), length(test_7), ...
    length(test_8), length(test_9), length(test_10)];
testing = zeros(max(test_lengths), chords);
testing(1:length(test_1),1) = test_1;
testing(1:length(test_2),2) = test_2;
testing(1:length(test_3),3) = test_3;
testing(1:length(test_4),4) = test_4;
testing(1:length(test_5),5) = test_5;
testing(1:length(test_6),6) = test_6;
testing(1:length(test_7),7) = test_7;
testing(1:length(test_8),8) = test_8;
testing(1:length(test_9),9) = test_9;
testing(1:length(test_10),10) = test_10;

results = zeros(chords, chords);

for i=1: length(results)
    results(:,i) = identify_chord(testing(:,i), a,am,bm,c,d,dm,e,em,f,g);
end
%print result interpretation
FileID = fopen('test_results.txt', 'w');
interpret(results,FileID); %console output
fclose(FileID);
%make confusion matrix
confusion_matrix = zeros(chords);
%pull in labeled training data 
%read audio files, pick 100th index
[a1,Fs_a1]   = audioread('wav\a\a150.wav');
[am1,Fs_am1] = audioread('wav\am\am150.wav');
[bm1,Fs_bm1] = audioread('wav\bm\bm150.wav');
[c1,Fs_c1]   = audioread('wav\c\c150.wav');
[d1,Fs_d1]   = audioread('wav\d\d150.wav');
[dm1,Fs_dm1] = audioread('wav\dm\dm150.wav');
[e1,Fs_e1]   = audioread('wav\e\e150.wav');
[em1,Fs_em1] = audioread('wav\em\em150.wav');
[f1, Fs_f1]  = audioread('wav\f\f150.wav');
[g1,Fs_g1]   = audioread('wav\g\g150.wav');

%make matrix for testing confusion
c_test_length = [length(a1), length(am1), length(bm), length(c1), ...
    length(d1), length(dm1), length(e1), length(em1), length(f1), length(g1)];
c_test = zeros(max(c_test_length),chords);
c_test(1:length(a1),1) = a1;
c_test(1:length(am1),2) = am1;
c_test(1:length(bm1),3) = bm1;
c_test(1:length(c1),4) = c1;
c_test(1:length(d1),5) = d1;
c_test(1:length(dm1),6) = dm1;
c_test(1:length(e1),7) = e1;
c_test(1:length(em1),8) = em1;
c_test(1:length(f1),9) = f1;
c_test(1:length(g1),10) = g1;

for i= 1:chords
    confusion_matrix(i,:) = identify_chord(c_test(:,i),a,am,bm,c,d,dm,e,em,f,g)';
end

confusion_mat =figure(2);
imagesc(confusion_matrix);
xlabel('Predicted Chord');
ylabel('Actual Chord');
title('Rows/Colums Order: A,AM,BM,C,D,DM,E,EM,F,G');
saveas(confusion_mat, 'conf_mat.jpg');


%% 1B & 1C FFT Implementation

%pull in the test data

test_1  = audioread('test\1.wav');
test_2  = audioread('test\2.wav');
test_3  = audioread('test\3.wav');
test_4  = audioread('test\4.wav');
test_5  = audioread('test\5.wav');
test_6  = audioread('test\6.wav');
test_7  = audioread('test\7.wav');
test_8  = audioread('test\8.wav');
test_9  = audioread('test\9.wav');
test_10 = audioread('test\10.wav');

%make testing matrix for consise implemtation
test_lengths = [length(test_1), length(test_2), length(test_3),...
    length(test_4), length(test_5), length(test_6), length(test_7), ...
    length(test_8), length(test_9), length(test_10)];
testing = zeros(max(test_lengths), chords);
testing(1:length(test_1),1) = test_1;
testing(1:length(test_2),2) = test_2;
testing(1:length(test_3),3) = test_3;
testing(1:length(test_4),4) = test_4;
testing(1:length(test_5),5) = test_5;
testing(1:length(test_6),6) = test_6;
testing(1:length(test_7),7) = test_7;
testing(1:length(test_8),8) = test_8;
testing(1:length(test_9),9) = test_9;
testing(1:length(test_10),10) = test_10;

results = zeros(chords, chords);

for i=1: length(results)
    results(:,i) = identify_chord(testing(:,i), a,am,bm,c,d,dm,e,em,f,g);
end
%print result interpretation
FileID2 = fopen('test_results_fft.txt', 'w');
interpret(results,FileID2); %console output
fclose(FileID2);
%make confusion matrix
confusion_matrix2 = zeros(chords);
%pull in labeled training data 
%read audio files, pick 100th index
[a1,Fs_a1]   = audioread('wav\a\a150.wav');
[am1,Fs_am1] = audioread('wav\am\am150.wav');
[bm1,Fs_bm1] = audioread('wav\bm\bm150.wav');
[c1,Fs_c1]   = audioread('wav\c\c150.wav');
[d1,Fs_d1]   = audioread('wav\d\d150.wav');
[dm1,Fs_dm1] = audioread('wav\dm\dm150.wav');
[e1,Fs_e1]   = audioread('wav\e\e150.wav');
[em1,Fs_em1] = audioread('wav\em\em150.wav');
[f1, Fs_f1]  = audioread('wav\f\f150.wav');
[g1,Fs_g1]   = audioread('wav\g\g150.wav');

%make matrix for testing confusion
c_test_length = [length(a1), length(am1), length(bm), length(c1), ...
    length(d1), length(dm1), length(e1), length(em1), length(f1), length(g1)];
c_test = zeros(max(c_test_length),chords);
c_test(1:length(a1),1) = a1;
c_test(1:length(am1),2) = am1;
c_test(1:length(bm1),3) = bm1;
c_test(1:length(c1),4) = c1;
c_test(1:length(d1),5) = d1;
c_test(1:length(dm1),6) = dm1;
c_test(1:length(e1),7) = e1;
c_test(1:length(em1),8) = em1;
c_test(1:length(f1),9) = f1;
c_test(1:length(g1),10) = g1;

for i= 1:chords
    confusion_matrix2(i,:) = identify_chord(c_test(:,i),a,am,bm,c,d,dm,e,em,f,g)';
end

confusion_mat2 =figure(3);
imagesc(confusion_matrix2);
xlabel('Predicted Chord');
ylabel('Actual Chord');
title('Rows/Colums Order: A,AM,BM,C,D,DM,E,EM,F,G');
saveas(confusion_mat2, 'conf_mat.jpg');


%% Functions:
function [omega,N] = dft_freq(data)
N = length(data);
omega = 2*pi*(0:N-1)/N;
omega = fftshift(omega);
omega = unwrap(omega-2*pi);
end
function result = identify_chord_fft(test,a,am,bm,c,d,dm,e,em,f,g)
% this requires all of the arrays to be of the same length, if we are to do
% a computationally efficent spectral comparison
chords = 10;
result = zeros(chords, 1);
%make a matrix
%note: columns [a,am,bm,c,d,dm,e,em,f,g]
lengths = [length(a), length(am), length(bm), length(c),...
    length(d),length(dm),length(e), length(em), length(f), length(g)];
training = zeros(max(lengths),chords);
training(1:length(a),1) = a;
training(1:length(am),2) = am;
training(1:length(bm),3) = bm;
training(1:length(c),4) = c;
training(1:length(d),5) = d;
training(1:length(dm),6) = dm;
training(1:length(e),7) = e;
training(1:length(em),8) = em;
training(1:length(f),9) = f;
training(1:length(g), 10)= g;
%normalize the energy too
for i = 1:chords
    training(:,i) = fft(training(:,i),max(lengths));
    energy = training(:,i)'*conj(training(:,i));
    training = training/energy;
end

l_norm_test = zeros(max(lengths),1);
l_norm_test(1:length(test)) = test;
test_fft = fft(l_norm_test, max(lengths));
test_energy = test_fft'*conj(test_fft);
test_fft = test_fft/test_energy;

% equivalent to autocoorelation
for i=1:cords
coor_fft = training(:,i).*conj(test_fft);
result(i) = norm(coor_fft);
end

result = result -max(result);
result = result>=0;

%take care of possible draws, note this will always favor the lower index
if(sum(result) >1)
   found_one = false;
    for i =1: length(result)
        if(found_one)
            result(i)=0;
        else
            if(result(i)==1)
                found_one= true;
            end
        end
    end
end
end
function result = identify_chord(test,a,am,bm,c,d,dm,e,em,f,g)
chords = 10;
result = zeros(chords, 1);
%make a matrix
%note: columns [a,am,bm,c,d,dm,e,em,f,g]
lengths = [length(a), length(am), length(bm), length(c),...
    length(d),length(dm),length(e), length(em), length(f), length(g)];
training = zeros(max(lengths),chords);
training(1:length(a),1) = a;
training(1:length(am),2) = am;
training(1:length(bm),3) = bm;
training(1:length(c),4) = c;
training(1:length(d),5) = d;
training(1:length(dm),6) = dm;
training(1:length(e),7) = e;
training(1:length(em),8) = em;
training(1:length(f),9) = f;
training(1:length(g), 10)= g;

%normalize energy
for i=1:chords
    training(:,i) = training(:,i)/norm(training(:,i));
end

%run test
for j=1: length(result)
    %compute energy with corsscorrelation
    %note: crosscorr(x[n], h[n] = convolve(x[n],h[-n])
    test_reversed = flip(test);
    cross_corr = conv(training(:,j),test_reversed);
    result(j) = norm(cross_corr)/length(cross_corr);
end
%process result
result = result -max(result);
result = result>=0;

%take care of possible draws, note this will always favor the lower index
if(sum(result) >1)
   found_one = false;
    for i =1: length(result)
        if(found_one)
            result(i)=0;
        else
            if(result(i)==1)
                found_one= true;
            end
        end
    end
end
end
function interpret(results, FileId)
for i =1:length(results)
    decode(results(:,i),i, FileId);
end
end
function decode(result,test_number, fileID)
index =0;
for i =1:length(result)
    if(result(i) == 1)
        index =i;
    end
end
switch index
    case 1
        fprintf(fileID, "File %i.wav was classified as A\n", test_number);
    case 2
        fprintf(fileID, "File %i.wav was classified as AM\n", test_number);
    case 3
        fprintf(fileID, "File %i.wav was classified as BM\n", test_number);
    case 4
        fprintf(fileID, "File %i.wav was classified as C\n", test_number);
    case 5
        fprintf(fileID, "File %i.wav was classified as D\n", test_number);
    case 6
        fprintf(fileID, "File %i.wav was classified as DM\n", test_number);
    case 7
        fprintf(fileID, "File %i.wav was classified as E\n", test_number);
    case 8
        fprintf(fileID, "File %i.wav was classified as EM\n", test_number);
    case 9
        fprintf(fileID, "File %i.wav was classified as F\n", test_number);
    case 10
        fprintf(fileID, "File %i.wav was classified as G\n", test_number);

end
end