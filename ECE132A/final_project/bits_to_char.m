%% bits_to_char
%  Author: Thomas Kost
%  UID: 504989794
%  Date: 6/4/20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ cs ] = bits_to_char( b )
%
% Take a bit stream and convert it to ascii characters
%
    bv = b(1)*1 + b(2)*2 + b(3)*4 + b(4)*8 + b(5)*16 + b(6)*32 + b(7)*64 + b(8)*128;
    cs = char(bv);
end