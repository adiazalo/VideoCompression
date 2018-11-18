i=1;
j=2;

[frameInit,frameRate] = read_MP4Frame('natalie_1.mp4',1);

outputVideo = VideoWriter(fullfile(natalie_1_out.avi));
outputVideo.FrameRate = frameRate;
open(outputVideo);

while j< 30

frame1 = read_MP4Frame('natalie_1.mp4',i);
frame2 = read_MP4Frame('natalie_1.mp4',j);

disp("motion_estimation")
[mvx,mvy] = motion_estimation(frame1, frame2, 24, 24, 24);
disp("mc_prediction")
[mcpr,pred] = mc_prediction(frame1,frame2,mvx,mvy);
pred = uint8(pred);

disp("image_dct_enc")
%enc not good for natalie_1
Nbits = image_dct_enc(mcpr,'dct.bit',50);
disp("image_dct_dec")
img_dec = image_dct_dec('dct.bit','frame_dec.jpg');
% whos img_dec
% whos pred
reconst = img_dec + pred;

imwrite(reconst, 'natalie_1_reconst.jpg');
img = imread('natalie_1_reconst.jpg');
writeVideo(outputVideo,img);

end
close(outputVideo);
% k = mat2gray(reconst);
% figure;
% imshow(k);

