function frame_Q = frame_read(vid, width, height, nFrame)

A = zeros(height,width);
count = 1;
v = VideoReader(vid);
figure;
 for t=1:nFrame
   A(:,:)=transpose(readFrame(v,[width,height],'uint8')); 	  %Reading the Y (luminance) information%	
   B = A / max(A(:));
   %imwrite(B,sprintf('c:\\foreman%03d.jpg',nFrame),'jpg','Quality',100); %Writing 1 frame (the luminance information) to a file%
 end
frame_Q = double(B);
imshow(frame_Q);
