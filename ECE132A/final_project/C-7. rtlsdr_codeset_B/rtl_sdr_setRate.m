function soc = rtl_sdr_setRate(soc,rate)

import java.net.ServerSocket
import java.io.*

output_stream   = soc.getOutputStream;
d_output_stream = DataOutputStream(output_stream);

d_output_stream.writeByte(2);

d_output_stream.writeInt(rate)

%soc.close
%soc = rtl_sdr_connect
