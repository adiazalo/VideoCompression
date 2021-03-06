j=2;
% disp("frameRate")
prev = frame_read('natalieLowCut.mp4', 360, 640, 1);

% disp("outputVideo")
outputVideo = VideoWriter('natalie_out.mp4','MPEG-4');%NEW
outputVideo.FrameRate = 30;
open(outputVideo);

while j< 90
    curr = frame_read('natalieLowCut.mp4', 360, 640, j);

% disp("motion_estimation")
%     [mvx,mvy] = motion_estimation(prev, curr, 8, 8, 16);

% disp("mc_prediction")
%     [mcpr,pred] = mc_prediction(prev,curr,mvx,mvy);
%     pred = uint8(pred);
    % whos prev curr
    [pred,mcpr,mvx,mvy]=blockmatching(prev,curr,8,8);

% disp("image_dct_enc")
    img_enc = dct_enc(mcpr,30);

% disp("image_dct_dec")
    [NbitsImg,NbitsMVX,NbitsMVY] = entropyCoding(img_enc,mvx,mvy, 'dct.bit','mvx.bit','mvy.bit');

    img_dec = dct_dec(img_enc,'frame_dec.jpg');
    reconst = img_dec + pred;
% disp("writeVideo")
    imwrite(reconst, 'natalie_reconst.jpg');
    img = imread('natalie_reconst.jpg');
    writeVideo(outputVideo,img);
    prev = reconst;
    prev = char(prev);
    j=j+1
end
close(outputVideo);
% k = mat2gray(reconst);
% figure;
% imshow(k);

