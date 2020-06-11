%% Decode NRZI
%  Author: Thomas Kost
%  UID: 504989794
%  Date: 6/3/20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [db] = decode_NRZI(bit_stream)
%note that coming in we have a bit stream where each bit takes up only a
%single index
starting_condition = 0;
bitstream = [starting_condition bit_stream']';
len = length(bitstream);
db = zeros(len-1,1);
for i= 2: len;
    db(i-1) = ~xor(bitstream(i),bitstream(i-1));
end
end