j=2;
% disp("frameRate")
[prev,frameRate] = read_MP4Frame('natalieLowCut.mp4',1);

% disp("outputVideo")
outputVideo = VideoWriter('natalie_out.mp4','MPEG-4');%NEW
outputVideo.FrameRate = frameRate;
open(outputVideo);

while j< 300
curr = read_MP4Frame('natalieLowCut.mp4',j); 

% disp("motion_estimation")
[mvx,mvy] = motion_estimation(prev, curr, 8, 8, 8);

% disp("mc_prediction")
[mcpr,pred] = mc_prediction(prev,curr,mvx,mvy);
pred = uint8(pred);

% disp("image_dct_enc")
img_enc = dct_enc(mcpr,50);

% disp("image_dct_dec")
img_dec = dct_dec(img_enc,'frame_dec.jpg');
reconst = img_dec + pred;

[NbitsImg,NbitsMVX,NbitsMVY] = entropyCoding(img_enc,mvx,mvy, 'dct.bit','mvx.bit','mvy.bit');

% disp("writeVideo")
imwrite(reconst, 'natalie_reconst.jpg');
img = imread('natalie_reconst.jpg');
writeVideo(outputVideo,img);
prev = reconst;
% prev = char(prev);
j=j+1
end
close(outputVideo);
% k = mat2gray(reconst);
% figure;
% imshow(k);

