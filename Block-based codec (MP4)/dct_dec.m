function img_dec = dct_dec(imgq_dec_1x230400,outfile)
load('dct_hist.mat','counts');
header_fid = fopen('img_header.hdr','rb');
header = fread(header_fid,'uint16');
rows = header(1);
cols = header(2);
quality = header(3);
min_index = (-1)*header(4);

[qt, zag] = init_jpeg(quality);

% imgq_dec_921600x1 = decArith('dct_hist',bitfile);
% imgq_dec_1x921600 = imgq_dec_921600x1';
%% inverse shifting
imgq_dec_3600x64 = reshape(imgq_dec_1x230400',[64,3600])';
imgq_dec_3600x64 = imgq_dec_3600x64 - 1;
imgq_dec_3600x64 = imgq_dec_3600x64 - round(abs(min_index));
%% inverse DICM
for rIndex = 3600:-1:2
    imgq_dec_3600x64(rIndex,1) = imgq_dec_3600x64(rIndex,1) + imgq_dec_3600x64(rIndex-1,1);
end
%% inverse DCT
tempBlock8x8 = ones(8);
img_dec = zeros(360,640);
rIndex = 1;
cIndex = 1;
nextBlockNum = 1;
vec = ones(1,64);

vecq = imgq_dec_3600x64(nextBlockNum,:);
while rIndex<360
    while cIndex<640
        vecq = imgq_dec_3600x64(nextBlockNum,:);
        for qIndex = 1:64
            vec(qIndex) = round(vecq(qIndex).*qt(qIndex));
        end
        
        %inverse zig zag
        for zIndex = 1:64
            tempBlock8x8(find(zag==zIndex)) = vec(zIndex);
        end
        
        %inverse DCT
        img_dec(rIndex:rIndex+7,cIndex:cIndex+7) = idct(tempBlock8x8);
        cIndex = cIndex + 8;
       
        nextBlockNum = nextBlockNum + 1;
    end
    cIndex = 1;
    rIndex = rIndex + 8;
end
%%%D = dctmtx(8); %Calculate the discrete cosine transform matrix
%%%inv_dct = @(block_struct) D'* block_struct.data * D;
%%%img_dec = blockproc(img_dec_512x512,[8 8],inv_dct); 

x = linspace(0,1,256)';
map = [x x x];
img_dec = uint8(img_dec+128);
% sc = imagesc(img_dec);
% impixelregion(sc);
imwrite(img_dec,map, outfile);

clearvars -except img_dec;