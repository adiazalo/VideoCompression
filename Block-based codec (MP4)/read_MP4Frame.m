function frameMP4 = read_MP4Frame (infile, frame_index)
ReadObj = VideoReader(infile); 
CurFrame = 0;
GetFrame = [0 frame_index];
while hasFrame(ReadObj)
    CurImage = readFrame(ReadObj);
    CurFrame = CurFrame+1;
    if ismember(CurFrame, GetFrame)
        imwrite(CurImage, sprintf('frame%d.jpg', CurFrame));
        whos CurFrame
        frameMP4 = sprintf('frame%d.jpg', CurFrame);
    end
end