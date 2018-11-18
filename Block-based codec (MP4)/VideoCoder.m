function VideoCoder(infile)
a = 1;
b = 2;
ReadObj = VideoReader(infile); 
CurFrame = 0;
GetFrame = [0 a b];
while hasFrame(ReadObj)
    CurImage = readFrame(ReadObj);
    CurFrame = CurFrame+1;
    if ismember(CurFrame, GetFrame)
        imwrite(CurImage, sprintf('frame%d.jpg', CurFrame));
        whos CurFrame
        frameMP4 = sprintf('frame%d.jpg', CurFrame);
    end
    
    [mvx,mvy] = motion_estimation(frame1, frame2, 8, 8, 16);
    [mcpr,pred] = mc_prediction(frame1,frame2,mvx,mvy);
    Nbits = image_dct_enc(mcpr,'dct.bit',90);
    
    img_dec = image_dct_dec('dct.bit','frame_dec.bmp');
    %write_Yframe(img_dec, 'vid_dec.mp4')
    
    a=a+1;
    b=b+1;
    if b==3
        break
    end
    
    
end


%     frame1 = read_MP4Frame(v, a);
%     frame2 = read_MP4Frame(v, b);
   
