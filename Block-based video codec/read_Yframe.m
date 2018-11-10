function frameY = read_Yframe (infile, height, width, frame_index)
infile_fid = fopen(infile,'r','b');
readData = fread(infile_fid,'*uchar');
frameSize = width * height;
frame = readData((frame_index-1)*frameSize+1:frame_index*frameSize);
yImage = reshape(frame(1:width*height), width, height)';
frameY = uint8(yImage);
frameY = double(frameY);
fclose(infile_fid);
clearvars -except frameY;
