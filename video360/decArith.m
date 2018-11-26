function message_dec_int = decArith(histfile,infile)
load(histfile,'counts');
infile_fid = fopen(infile,'rb');
Nsymbols = fread(infile_fid,1,'ulong');
bitstream = fread(infile_fid,'ubit1');
fclose(infile_fid);
%disp(Nsymbols)
message_dec_int = arithdeco(bitstream,counts,Nsymbols);

clear Nsymbols;
clear bitstream;