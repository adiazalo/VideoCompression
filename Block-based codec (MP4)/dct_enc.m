function imgq_1x921600 = dct_enc(infile,quality)
[qt, zag] = init_jpeg(quality);
imgDouble_720x1280 = imread(infile);
imgDouble_720x1280 = double(imgDouble_720x1280) - 128;

[imgR,imgC] = size(imgDouble_720x1280);

cIndex = 1;
rIndex = 1;
vecq_1x64 = ones(1,64);
imgq_14400x64 = ones(14400,64);
qtZag = ones(8);
B_8x8 = ones(8);

for qIndex = 1:64
    qtZag(find(zag==qIndex)) = qt(qIndex);
end

%% loop through the image extracting non-overlapping 8x8 blocks
% disp("loop through the image extracting non-overlapping 8x8 blocks")
nextblockNum = 1;
while rIndex<imgR
    while cIndex<imgC
        
        % transform the block using 8x8 DCT
        tempBlock8x8 =  imgDouble_720x1280(rIndex:rIndex+7,cIndex:cIndex+7);
        tempBlock8x8_DCT = dct(tempBlock8x8);
        
        %quantize it using JPEG-like quantizers
        for qRow = 1:8
            for qCol = 1:8
            B_8x8(qRow,qCol) = round(tempBlock8x8_DCT(qRow,qCol)/qtZag(qRow,qCol));
            end
        end
        %convert it to a vector of length 64 using zig zag scan
        for zIndex = 1:64
            vecq_1x64(zIndex) = B_8x8(find(zag==zIndex));
        end
        
        %store it as a row in a matrix called imgq
        imgq_14400x64(nextblockNum,:)=vecq_1x64; 
        nextblockNum = nextblockNum + 1;
        cIndex = cIndex + 8;
    end
    cIndex = 1;
    rIndex = rIndex + 8;
end
%% differential pulse code modulation
% disp("differential pulse code modulation")
for rIndex=2:14400
    imgq_14400x64(rIndex,1) = imgq_14400x64(rIndex,1) - imgq_14400x64(rIndex-1,1);
end

%% shifting
% disp("shifting")
min_index = min(min(imgq_14400x64));
imgq_14400x64 = abs(min_index) + imgq_14400x64 + 1;

imgq_1x921600 = reshape(imgq_14400x64',[1,921600]);
imgq_1x921600 = round(imgq_1x921600);

%% header info
% disp("header info")
header_fid = fopen('img_header.hdr','wb');
[imgR,imgC] = size(imgDouble_720x1280);
min_index = abs(min_index);
fwrite(header_fid,[imgR imgC],'uint16');
fwrite(header_fid,[quality min_index],'uint16');
fclose(header_fid);

clearvars -except imgq_1x921600;