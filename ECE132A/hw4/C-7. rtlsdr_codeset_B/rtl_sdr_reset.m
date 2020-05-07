function soc = rtl_sdr_reset(soc)

addr = soc.getInetAddress;
soc.close;
pause(3);
soc = rtl_sdr_connect(addr);
