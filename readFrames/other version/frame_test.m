function frame_Q = frame_test(vid, width, height, nFrame)


A = zeros(height,width);
fid=fopen(vid,'r','b');			  %Input image sequence%
figure;
for t=1:nFrame
   A(:,:)=transpose(fread(fid,[width,height],'uint8')); 	  %Reading the Y (luminance) information%
   %tmp=fread(fid,[width/2,height/2],'uint8');		  %Reading the U (chrominance) information%	
   %tmp=fread(fid,[width/2,height/2],'uint8');		   %Reading the V (chrominance) information%		
   B = A / max(A(:));
%     imshow(B);
   %imwrite(B,sprintf('c:\\foreman%03d.jpg',t),'jpg','Quality',100); %Writing 1 frame (the luminance information) to a file%
end
frame_Q = double(B);
 imshow(frame_Q);
fclose(fid);

