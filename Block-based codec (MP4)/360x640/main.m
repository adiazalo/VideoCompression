
mbSize = 8;
p = 16;
index = 0;

    %%% uncomment to open video files
% writer = VideoWriter('natalie_S_A_D.avi','Grayscale AVI');
% writer.FrameRate = 30;                    
% open(writer);
          
while index < 90
    index = index + 1;
   %%% Read first frame once %%%%%%%%%%
    if index == 1
        disp('hello')
        prev = frame_read('natalie360.mp4', 360, 640, index);
    end
 
    curr = frame_read('natalie360.mp4', 360, 640, index + 1);
    [f_e,MCPR, mx, my]= blockmatching(prev,curr,mbSize,p);
    
    %%%%%%%%%%%% DCT+Q + Enco && return imag to reconstruct prev %%%%
    [Nbits, img_back] = Enc_DCT_img(MCPR,'one.bit',80);
  
    %%%%%%%% Q^-1 & IDCT for prev %%%%%%%%%%%%%%%%%
    img_Back = Qinv_IDCT(img_back);
    
    %%% must be the same type - double-double 
    prev = double(img_Back) + (f_e); 
    chk = MCPR + f_e;
%       
    k = mat2gray(prev);
    chk = mat2gray(chk);
%     %%% Uncomment to disply the predicated image 
%     figure
%     imshow(k);
%     title('prev')
%     figure; imshow(chk); title('dir')

%%%%%%%%%% Write images/frames to output file %%%%%%%%%%%%%%%%%%%%%%%%%%%
%     imwrite(k, 'natalie_1_reconst.jpg');    
%     img = imread('natalie_1_reconst.jpg');
%     writeVideo(writer,img); 
%     writeVideo(writer,k); 
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5   
%     prev = 0; curr =0;
end

done = 1;
while done == 1
    %assuming we read QuantizedFrame, mvx and mvy
    deqFrame = Qinv_IDCT(qFrame);
    
    
    
    
    
    
end

%  close(writer);



