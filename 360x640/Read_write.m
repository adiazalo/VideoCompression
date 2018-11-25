%%% Read binary bits to reconstruct the original image 
%%% 1) Must remove third demisions on each element ( this is what we need
%%% in our case). ex 720x1280x3, third dim can be removed using built in
%%% function k = rgb2gray(x) 
%%% 2)Know number of bits of each image/frame 
%%% 3) Write all bits and image/frames in order then read them in order 

%   Copyright 2018 Saad Alkhalifah



img1= imread('frame1.jpg');
img1 = rgb2gray(img1);
% length(img1)
img1_bit= (921600);
img2= imread('frame170.jpg');

img2_bit= (25344);
img3= imread('lena512.bmp');
img3_bit= (262144);
whos img3
 res = [ 921600,  25344 , 262144];

FID = fopen('nine.bit','wb');
fwrite(FID,img1_bit, 'uint');
fwrite(FID,img1);
fwrite(FID,img2_bit, 'uint');
fwrite(FID,img2);
fwrite(FID,img3_bit, 'uint');
fwrite(FID,img3);
fclose(FID);

FID = fopen('nine.bit','rb');
    
A_numbit= fread(FID,1,'ulong');
disp(A_numbit);
whos A_numbit
A_numbit= fread(FID,A_numbit);
A_numbit = uint8(A_numbit);
k = reshape(A_numbit,[720,1280]);
figure;imshow(k);

second_img= fread(FID,1,'ulong');
second_img= fread(FID,second_img);
second_img = uint8(second_img);
k = reshape(second_img,[144,176]);
figure;imshow(k);

third_img= fread(FID,1,'ulong');
third_img= fread(FID,third_img);
third_img = uint8(third_img);
k = reshape(third_img,[512,512]);
figure;imshow(k);
 
 

fclose(FID);






% fID = fopen('nine.bit','rb');
% %  for i=1:3
%     
% 
% A_numbit= fread(fID,res(1));
% A_numbit = uint8(A_numbit);
% k = reshape(A_numbit,[720,1280]);
% figure;imshow(k);
% 
% A_numbit= fread(fID,res(2));
% A_numbit = uint8(A_numbit);
% k = reshape(A_numbit,[144,176]);
% figure;imshow(k);
% 
% A_numbit= fread(fID,res(3));
% A_numbit = uint8(A_numbit);
% k = reshape(A_numbit,[512,512]);
% figure;imshow(k);
%  
%   
% %  end
% 
% fclose(fID);
