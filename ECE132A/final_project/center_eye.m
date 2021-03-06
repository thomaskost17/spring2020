%% center_eye
%  Author: Thomas Kost
%  UID: 504989794
%  Date: 6/6/20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [offset] = center_eye(ddif)
len = length(ddif);
n1 = ceil(len/2)-mod(ceil(len/2),20);
n2 = n1 + 20*256 - 1;
 
boff = [-10:9];
eyed = reshape(ddif((n1:n2)-10),20,256);
fl = floor(eyed);
cl = ceil(eyed);
z_fl =fl==0;
z_cl = cl==0;
x = sum(z_cl,2) +sum(z_fl,2);
x= x-min(x);
figure(3);
plot(boff,x);
figure(4);
plot(boff,eyed);

cross_pt = floor(x'*boff'/sum(x));%get average value
offset = 10-(cross_pt);
end