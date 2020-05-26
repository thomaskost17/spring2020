function soc = rtl_sdr_setFreq(soc,freq)

import java.net.ServerSocket
import java.io.*

output_stream   = soc.getOutputStream;
d_output_stream = DataOutputStream(output_stream);

d_output_stream.writeByte(1);

d_output_stream.writeInt(freq)

%soc.close
%soc = rtl_sdr_connect
