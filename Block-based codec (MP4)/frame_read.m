function frame_Q = frame_read(vid, width, height, nFrame)

%%%%%%REad frames from mp4 clip and disply the frame then converted to
%%%%%%double

Frame = zeros(height,width);
count = 1;
v = VideoReader(vid);

for t=1:nFrame

    Frame = readFrame(v,'native');
%     whos Frame
    Frame = rgb2gray(Frame); %% chnage frame from MxNxd to MxN
%     whos Frame

   B = Frame;
%    imshow(B);
   %imwrite(B,sprintf('c:\\foreman%03d.jpg',t),'jpg','Quality',100); %Writing 1 frame (the luminance information) to a file%
end
%%% Uncomment the line below to see the image/frame 
% imshow(B);
frame_Q = double(B);
