function vid_dec = VideoCoder(vid)

a=1;
b=2;
while hasFrame(vid)
    frame1 = read_MP4Frame(vid, a);
    frame2 = read_MP4Frame(vid, b);
   
    [mvx,mvy] = motion_estimation(frame1, frame2, 8, 8, 16);
    [mcpr,pred] = mc_prediction(frame1,frame2,mvx,mvy);
    Nbits = image_dct_enc(mcpr,'dct.bit',90);
    
    img_dec = image_dct_dec('dct.bit','frame_dec.bmp');

    
end