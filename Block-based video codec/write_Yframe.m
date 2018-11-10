%append the frame in frameY to the end of outfile
function write_Yframe(frameY, outfile)

%converting to column vector
frameY = frameY';
frameY = reshape(frameY,[],1);

outfile_fid = fopen(outfile,'a');
fwrite(outfile_fid,frameY,'ubit8');
fclose(outfile_fid);