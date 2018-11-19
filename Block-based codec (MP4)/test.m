i=1;
j=2;

disp("frameRate")
[frameInit,frameRate] = read_MP4Frame('dustpan.mp4',1);

disp("outputVideo")
outputVideo = VideoWriter('dustpan_out.avi');
outputVideo.FrameRate = frameRate;
open(outputVideo);

 while j< 10

frame1 = read_MP4Frame('dustpan.mp4',i);
frame2 = read_MP4Frame('dustpan.mp4',j);

disp("motion_estimation")
[mvx,mvy] = motion_estimation(frame1, frame2, 15, 15, 30);
disp("mc_prediction")
[mcpr,pred] = mc_prediction(frame1,frame2,mvx,mvy);
pred = uint8(pred);

disp("image_dct_enc")
Nbits = image_dct_enc(mcpr,'dct.bit',10);
disp("image_dct_dec")
img_dec = image_dct_dec('dct.bit','frame_dec.jpg');
% whos img_dec
% whos pred
reconst = img_dec + pred;

disp("writeVideo")
imwrite(reconst, 'dustpan_reconst.jpg');
img = imread('dustpan_reconst.jpg');
writeVideo(outputVideo,img);

i=i+1;
j=j+1
end
close(outputVideo);
% k = mat2gray(reconst);
% figure;
% imshow(k);

