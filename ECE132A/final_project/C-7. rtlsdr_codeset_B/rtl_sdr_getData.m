function data = rtl_sdr_getData(soc,samps)
% data = rtl_sdr_getData(soc, samps)
%
% soc: tcp socket (from rtl_sdr_connect)
% sams: number of samples (default 1e6)
%


import java.net.Socket
import java.io.*

javaaddpath('./')
input_stream   = soc.getInputStream;
d_input_stream = DataInputStream(input_stream);

%maxBytes = soc.getReceiveBufferSize;
data_reader = DataReader(d_input_stream);

if nargin < 2
    samps = 1e6;
end

totBytes = samps*2;

data = double(data_reader.readBuffer(totBytes));

% Java does not support unsigned byte, but the data
% is unsigned, so fix it! Any other suggestions welcome!
data = data-128*(data>0) + 128*(data<0);

% convert from real, imag to complex
data = data(1:2:end) + 1i*data(2:2:end);




