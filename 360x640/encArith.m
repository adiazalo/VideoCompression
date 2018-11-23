function Nbits = encArith(message_int, histfile, outfile)
load(histfile,'counts');
Nsymbols = length(message_int);
message_enc = arithenco(message_int,counts);
Nbits = length(message_enc);

outfile_fid = fopen(outfile,'wb');
fwrite(outfile_fid,Nsymbols,'uint');
fwrite(outfile_fid,message_enc,'ubit1');
fclose(outfile_fid);

clear Nsymbols;
clear message_enc;

