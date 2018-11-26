function [Nbits, img_back] = Enc_DCT_img(infile,bitfile,quality)

% [img,map] = imread(infile);
img=double(infile)- 128;
w=zeros(8);

q=1;
tem =1;
inc = 1;
done = false ;
 
w_zag= zeros(1,64);
imgq = ones(64);
Quantize_DCT_8x8 = zeros(1,64);
counter =0;
[qt, zag] = init_jpeg(quality);

qt_zag = zeros(1,64);
    for i = 1:64
         
       qt_zag(i) = qt(find(zag == i));
    end
    
%%% number col 
vec1 = 1:8:641;    
vx= 0:8:352;

while ( ~done )
    
    %Divide matrix to 8*8
    for i=1:8               
            w(i,:) = img(i+vx(q),vec1(tem):vec1(tem + 1) - 1); 
        
    end
 
        %DCT
       w=dct(w);
    
    %Convert it to a vector of length 64 u  sing zig-zag scan.
        for i = 1:64
         
            w_zag(i) = w(find(zag == i));
         
        end
    
        % Quantize it using JPEG-like quantizers.
        for i = 1:64
        Quantize_DCT_8x8(i) = round(w_zag(i)/qt(i));
        end
       
         %Store it as a row in a matrix called imgq.
         imgq(inc,:) = Quantize_DCT_8x8; % check this one
        
     %imgq_Q(inc,:) = reshape(w',[1,64]); %
     
    w=zeros(8);
    tem = tem + 1;
    %%%%%%%%%length of vec1
      if tem == 81
       
        tem = 1;
        q= q + 1;
                
      end
    
       %%%%% (row*col)/64
    if inc == 3600
        done = 1;
    end
    
    inc = inc + 1;
end


% Differential Pulse Code Modulation (DPCM)
for i=2:3600  
        imgq(i,1) = imgq(i) - imgq(i-1);              
end

%shift all elements of imgq
min_index = min(min(imgq));
imgq = abs(min_index) + imgq;
imgq = reshape(imgq', [1,230400]);


[row,col] = size(img);

% make min_index positive 
min_index = abs(min_index);
ID = fopen('img_header.hdr', 'wb');
fwrite(ID,[row col],'uint16');
fwrite(ID,[min_index quality],'uint16');
fclose(ID);
counts =ones(1,max(imgq));

for i=0:max(imgq)
    
    for j=1:length(imgq)
        if imgq(j) == i
            counter = counter + 1;
        end
        
    end
    counts(i+1) = counter;
    counter=0;
    
end
% disp(sum(counts));
for i = 1:max(imgq)
    if (counts(i) == 0)
        counts(i) = 1;
    end
end


% % %The symbol sequence parameter must be a vector of positive finite integers.
% % % need imgq to be postive
imgq = imgq + 1;
img_back = imgq;
save dct_hist.mat counts;

% Encode 
Nbits = encArith(imgq,'dct_hist',bitfile);

clearvars -except Nbits img_back