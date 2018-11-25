clc
clear 
close all
mbSize = 8;
p = 16;
index = 0;

    %%% uncomment to open video files
% writer = VideoWriter('natalie_S_A_D.avi','Grayscale AVI');
% writer.FrameRate = 30;                    
% open(writer);
          
while index < 170
    
    index = index + 1;
    if index == 170
    
   %%% Read first frame once %%%%%%%%%%
    if index == 170
        disp('hello')
        prev = frame_read('natalie360.mp4', 360, 640, index);
        
    end
    
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %%%%%%%%%%%%%%%%%%% REad frames %%%%%%%%%%%%%%%%%
%     prev = frame_read('natalie_2.mp4', 720, 1280, index);
    curr = frame_read('natalie360.mp4', 360, 640, index + 1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
 %%%%%%%%%%% Motion estimation + MC   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    
    [f_e,MCPR, mx, my]= blockmatching(prev,curr,mbSize,p);
    whos mx my
%   mx(1:10)
%   my(1:10)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
 
%     pred_frame =mc_compensation(prev, curr,mx, my, mbSize, p);
    pred = mc_pred (prev, curr, mx,my,mbSize);
    
% % % %     %%%%%%%%%%%% DCT+Q + Enco && return imag to reconstruct prev %%%%
% % % %     [Nbits, img_back] = Enc_DCT_img(MCPR,'one.bit',95);
% % % %   
% % % %     %%%%%%%% Q^-1 & IDCT for prev %%%%%%%%%%%%%%%%%
% % % %     img_Back = Qinv_IDCT(img_back);
% % % % 
% % % %     whos f_e img_Back
% % % %     
% % % %     %%% must be the same type - double-double 
% % % %     prev = double(img_Back) + (f_e); 
% % % %     
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
%     imwrite(k, 'natalie_1_reconst.jpg');    
%     img = imread('natalie_1_reconst.jpg');
%     writeVideo(writer,img); 
    
%     writeVideo(writer,k); 
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5   
%     prev = 0; curr =0;
    end
    
%     disp(index);
end

%  close(writer);