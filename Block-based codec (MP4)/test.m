
frame1 = read_MP4Frame ('dustpan.mp4', 1);
frame2 = read_MP4Frame ('dustpan.mp4', 2);

[mvx,mvy] = motion_estimation(frame1, frame2, 8, 8, 32);
[mcpr,pred] = mc_prediction(frame1,frame2,mvx,mvy);
pred = uint8(pred);


Nbits = image_dct_enc(mcpr,'dct.bit',50);

img_dec = image_dct_dec('dct.bit','frame_dec.jpg');
% whos img_dec
% whos pred
reconst = img_dec + pred;

imwrite(reconst, 'dustpan_reconst.jpg');

k = mat2gray(reconst);
figure;
imshow(k);

