clc
clear 
close all
mbSize = 8;
p = 16;
index = 0;
nFrames = 330;

    %%% uncomment to open video files
writer = VideoWriter('natalie_S_A_D.avi','Grayscale AVI');
writer.FrameRate = 30;                    
open(writer);
mse = zeros(1,nFrames);
PSNR = zeros(1,nFrames);
NbitsV = zeros(1,nFrames);
bitFileBytes= zeros(1,nFrames);
histFileBytes= zeros(1,nFrames);
          
while index < nFrames
    
    index = index + 1
    
    
   %%% Read first frame once %%%%%%%%%%
    if index == 1
%         disp('hello')
        prev = frame_read('natalieLowCut.mp4', 360, 640, index);
                
    end
    
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %%%%%%%%%%%%%%%%%%% REad frames %%%%%%%%%%%%%%%%%
%     prev = frame_read('natalie_2.mp4', 720, 1280, index);
    curr = frame_read('natalieLowCut.mp4', 360, 640, index + 1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        mse = immse(prev,curr);
        PSNR(1,index) = 10*log10((255^2)/mse);
 %%%% %%%%%%% Motion estimation + MC   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    
    [pred,MCPR, mx, my]= blockmatching(prev,curr,mbSize,p);
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
 
%     pred_frame =mc_compensation(prev, curr,mx, my, mbSize, p);
% % %     pred = mc_pred (prev, curr, mx,my,mbSize);
    
% % % %     %%%%%%%%%%%% DCT+Q + Enco && return imag to reconstruct prev %%%%
    [Nbits, img_back] = Enc_DCT_img(MCPR,'one.bit',50);
    NbitsV(1,index) = Nbits;
    s = dir('one.bit');
    bitFileBytes(1,index) = s.bytes;
    t = dir('dct_hist.mat');
    histFileBytes(1,index) = t.bytes;
% % % %     %%%%%%%% Q^-1 & IDCT for prev %%%%%%%%%%%%%%%%%
    img_Back = Qinv_IDCT(img_back);

% % % %     whos f_e img_Back
% % % %     
% % % %     %%% must be the same type - double-double 
    prev = double(img_Back) + (pred); 
    
    
    %%%%% Decode frame %%%%%%%%%%%%%%
    img_dec = DEC_DCT('one.bit');
    
    %%% previous frame for decoding + decoded frame %%%%
    if index == 1
    pred = mc_pred (prev, curr, mx,my,mbSize);
    else
     pred = mc_pred (prev_dec, curr, mx,my,mbSize);   
    end
%     whos img_dec pred
    recon_img = double(img_dec) + pred;
    
    prev_dec = recon_img;
    
% % % %     chk = MCPR + f_e;
% % % % %       
% % % %       k = mat2gray(prev);
% % % %     chk = mat2gray(chk);
% % % % %     %%% Uncomment to disply the predicated image 
% % % %     figure
% % % %     imshow(k);
% % % %     title('prev')
% % % %     figure; imshow(chk); title('dir')
% % % % %     
  

%%%%%%%%%% Write images/frames to output file %%%%%%%%%%%%%%%%%%%%%%%%%%%
    if index == 1
    k = mat2gray(prev);
    else
    k = mat2gray(prev_dec);  
    end
    imwrite(k, 'natalie_1_reconst.jpg');    
    img = imread('natalie_1_reconst.jpg');
    writeVideo(writer,img); 
    
    writeVideo(writer,k); 
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5   
%     prev = 0; curr =0;
    
    
%     disp(index);
end

  close(writer);