function [ c ] = aprs_decode( b )
%
% c = aprs_decode(b)
%   
%   Simple decode of a bit stream b as an aprs packet.  Doesn't look for checksum or 
%	the ending frame byte.  You need to supply the decode_NRZI.m, de_bit_stuff.m 
%	and bits_to_char.m routines.
%
%   Output looks like
%
%       |PCKID |K6SRC  |K6DST1 |WIDE1  |:The ascii packet payload .... noise chars
%
%   where
%       PCKID -- seven chars that identifies the packet type
%       K6SRC -- seven char source call sign
%       K6DSTn-- one or more seven char destination call signs
%       WIDEn -- one or more seven char instructions for repeaters
%       ascii payload -- our data!
%       Noise chars -- we aren't detecting the end of the packet so we end up 
%			decoding noise at the end. 
%
%   These characters are used for formatting
%     .   -- frame byte found
%     |   -- address delimiter
%     :   -- flag bits ending addresses have been found
%
%

c = [];

db = decode_NRZI(b);

% find frame bytes, and skip them

dbs = frame_byte_sync(db);

% we are past the frame bytes, so we need to de_bit_stuff the rest

dbsd = de_bit_stuff(dbs);

% now at first data byte
% The address bytes are all shifted up one bit, so the low bit can be used as a flag
% We keep decoding address bytes, until we find a low bit set
c = [c '|'];
jj = 1;
while dbsd(jj) == 0,
    % decode a 7 byte address
    for kk = 0:6,
        c = [c; bits_to_char([dbsd(jj+1:jj+7); 0])];
        jj = jj+8;
    end
    c = [c; '|'];
    if (jj+8)>length(dbsd),
        break;
    end
end

% Two flag bytes with bit 1 set, indicate with ':'
c = [c; ':'];

jj = jj+16;

% Turn the rest of the bits into characters.  
% We should look for the checksum, and the final frame byte ... 
while jj < (length(dbsd)-8),
    c = [c; bits_to_char(dbsd(jj:jj+7))];
    jj = jj+8;
end

c = c';

end
