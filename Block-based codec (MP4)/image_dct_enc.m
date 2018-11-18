function Nbits = image_dct_enc(infile,bitfile,quality)
[qt, zag] = init_jpeg(quality);
imgDouble_1920x3840 = imread(infile);
%imgDouble_1080x1920 = rgb2gray(imgDouble_1080x1920_temp);
imgDouble_1920x3840 = double(imgDouble_1920x3840) - 128;

[imgR,imgC] = size(imgDouble_1920x3840);

% D = dctmtx(8); %Calculate the discrete cosine transform matrix
% dct = @(block_struct) D * block_struct.data * D';

%processes the image imgDouble by applying the function dct to each distinct block of size 8x8 and concatenating the results into the output matrix, B.
%imgDTC_512x512 = blockproc(imgDouble_512x512,[8 8],dct); 

% imshow(imgDouble_512x512);
% h = imagesc(imgDTC_512x512);
% impixelregion(h);al

cIndex = 1;
rIndex = 1;
vecq_1x64 = ones(1,64);
imgq_115200x64 = ones(115200,64);
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
        tempBlock8x8 =  imgDouble_1920x3840(rIndex:rIndex+7,cIndex:cIndex+7);
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
        imgq_115200x64(nextblockNum,:)=vecq_1x64; 
        nextblockNum = nextblockNum + 1;
        cIndex = cIndex + 8;
    end
    cIndex = 1;
    rIndex = rIndex + 8;
end
%% differential pulse code modulation
% disp("differential pulse code modulation")
for rIndex=2:115200
    imgq_115200x64(rIndex,1) = imgq_115200x64(rIndex,1) - imgq_115200x64(rIndex-1,1);
end

%% shifting
% disp("shifting")
min_index = min(min(imgq_115200x64))
imgq_115200x64 = abs(min_index) + imgq_115200x64 + 1;

imgq_1x7372800 = reshape(imgq_115200x64',[1,7372800]);
imgq_1x7372800 = round(imgq_1x7372800);

%% header info
% disp("header info")
header_fid = fopen('img_header.hdr','wb');
[imgR,imgC] = size(imgDouble_1920x3840);
min_index = abs(min_index);
fwrite(header_fid,[imgR imgC],'uint16');
fwrite(header_fid,[quality min_index],'uint16');
fclose(header_fid);

%% arith encoding
% disp("arith encoding")
minValue = min(imgq_1x7372800);
maxValue = max(imgq_1x7372800);
counts = zeros(1,maxValue);
for scan = 1:7372800
    scanValue = imgq_1x7372800(scan);
    counts(scanValue) = counts(scanValue) + 1;
end
counts(counts<1) = 1;
save('dct_hist','counts');
Nbits = encArith(imgq_1x7372800,'dct_hist',bitfile);

clearvars -except Nbits;