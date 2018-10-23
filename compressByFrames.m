function compressByFrames (infile, outfile)

Dir = 'Frames';
mkdir(Dir);
mkdir(Dir,'Images');
mkdir(Dir,'Audio');
inputVideo = VideoReader(infile);

[y,Fs] = audioread(infile);
filename = 'VideoToAudio.wav';
fullname = fullfile(Dir, 'Audio', filename);

audiowrite(fullname,y,Fs);

clear y;
clear Fs;

i = 1;
while hasFrame(inputVideo)
    img = readFrame(inputVideo);
    filename = [sprintf('%04d',i) '.png'];
    fullname = fullfile(Dir,'Images',filename);
    imwrite(img,fullname);
    i = i + 1;
end

imageNames = dir(fullfile(Dir,'Images','-.png'));
imageNames = {imageNames.name}';

writeObj = VideoWriter(fullfile(Dir,outfile));
video = VideoReader('3.wav');
video_temp = get(video);
frame = video_temp.FrameRate;

for j = 1:length(imageNames)
    frame = imread(fullfile(Dir,'Images',imageNames(j)));
    frame = imresize(frame,0.5);
    writeVideo(writeObj,im2frame(frame));
end
