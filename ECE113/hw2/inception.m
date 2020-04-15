close all; 
clear all; 
clc;

% Load the sound track
[X, Fs] = audioread('inception_sound_track.wav');

% -------------------------------------------------------------------------------
% Please enter your code here
% Design the system as shown in the figure that performs upsampling followed by a smoother
Y = zeros( 3*length(X),2);
% Upsampling
for j =1:length(Y)
    if(~mod(j,3))
        Y(j,:) = X(j/3,:);
    end
end

% Smoother using moving average and exponential smoother
%moving average
n=100;
Y1 = zeros( 3*length(X),2);
for i = 1:length(Y)
    sum=[0,0];
    for j =0:n
        if(i-j >=1)
            sum = sum + Y(i-j);
        end
    end
    avg =sum/(n+1);
    Y1(i,:) = avg;
end
%10 best without losing volume
%exponential smoother
alpha =0.8;
Y2 = zeros( 3*length(X),2);
for i = 1:length(Y)
    if(i-1)>=1
        Y2(i,:) = (1-alpha)*Y2(i-1,:) + alpha*Y(i,:);
    end
end

% -------------------------------------------------------------------------------
% Play the output signal Y (y[n]) from the system should be slower

ap_x = audioplayer(Y2, Fs); % Play the output audio file with original sampling frequency
play(ap_x)

% Please attach/print your code to the homework submission