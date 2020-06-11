%% Fame_byte_sync
%  Author: Thomas Kost
%  UID: 504989794
%  Date: 6/4/20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [dbs] = frame_byte_sync( db )
% Take a packet that has been NRZI decoded, and synchronize to the frame bytes
% Find the first frame byte
% Skip over all of the following frame bytes
% Return the bit stream following the last frame bytes

fb = [0 1 1 1 1 1 1 0]';
last_index =0;
for kk=1:(length(db)-7)
if (sum(~xor(db(kk:kk+7), fb)) == 8)
    if(kk-last_index <= 8 || last_index ==0),
        last_index = kk;
    end
end
end
dbs = db(last_index+8:end);
end