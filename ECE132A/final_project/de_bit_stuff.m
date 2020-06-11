%% de_bit_stuff
%  Author: Thomas Kost
%  UID: 504989794
%  Date: 6/4/20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dbs = [0 1 0 1 1 1 1 1 0 1 0 0 0  1 1 1 1 1 0 1 1 1 1 1 0 0 0 1 1 1 1 1 1 0 0 1 1 1 1 1 1 0 1];
% 
% x = de_bit_stuff1(dbs);
% fprintf('%i', x);
function [ dbsd ] = de_bit_stuff( dbs )
%
% Take a bit stuffed sequence of bits, and eliminate the stuffed zero bits
%
x = conv(dbs,ones(1,5), 'full');
%plot(x);
i = x==5;
i= find(i);
end_msg=0;
for j=1:length(i)-1
    if(i(j)+1==i(j+1) && end_msg == 0)
        end_msg =j;
    end
end
i = i(1:end_msg);
dbs(i+1)=[];
dbsd=dbs(1:i(end_msg)-length(i)-5);
end