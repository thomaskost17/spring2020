function soc = rtl_sdr_setFreqCorr(soc,ppm)

import java.net.ServerSocket
import java.io.*

output_stream   = soc.getOutputStream;
d_output_stream = DataOutputStream(output_stream);

d_output_stream.writeByte(5);

d_output_stream.writeInt(ppm)

%soc.close
%soc = rtl_sdr_connect
