function img_dec = dct_dec(imgq_dec_1x921600,outfile)
%% inverse shifting
imgq_dec_14400x64 = reshape(imgq_dec_1x921600',[64,14400])';
imgq_dec_14400x64 = imgq_dec_14400x64 - 1;
imgq_dec_14400x64 = imgq_dec_14400x64 - round(abs(min_index));
%% inverse DICM
for rIndex = 14400:-1:2
    imgq_dec_14400x64(rIndex,1) = imgq_dec_14400x64(rIndex,1) + imgq_dec_14400x64(rIndex-1,1);
end
%% inverse DCT
tempBlock8x8 = ones(8);
img_dec = zeros(720,1280);
rIndex = 1;
cIndex = 1;
nextBlockNum = 1;
vec = ones(1,64);

vecq = imgq_dec_14400x64(nextBlockNum,:);
while rIndex<720
    while cIndex<1280
        vecq = imgq_dec_14400x64(nextBlockNum,:);
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

