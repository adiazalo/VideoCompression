clc
clear 
close all
mbSize = 8;
p = 16;
index = 0;
          
while index < 1000
    
    index = index + 1
    curr = frame_read('natalieCutNew.mp4', 360, 640, index);

end

