function img_dec = DEC_DCT(bitfile,outfile)

infile_fid = fopen('img_header.hdr','rb');
hd_info = fread(infile_fid,'uint16');
fclose(infile_fid);

row_1= hd_info(1);
col_2= hd_info(2);
min_index=(-1)*hd_info(3);
quality=hd_info(4);
% whos row col min_index quality
% [img_x,map] = imread('frame1.jpg');

load('dct_hist.mat','counts');
[qt, zag] = init_jpeg(quality);
qt_zag = zeros(1,64);
    for i = 1:64  
       qt_zag(i) = qt(find(zag == i));
    end
    
%Decode -- return decoded image 
img_dec = decArith('dct_hist',bitfile);
% Reshift back by 1 due encode only accepting positive intergers 
img_dec = img_dec - 1;

%transpose because  img_dec      262144x1   
img_dec = img_dec';
whos img_dec
% Reshape to 4096x64 from 1xnum

img_dec = reshape(img_dec',[64,3600])';
whos img_dec

%subtarct back by min_index -- min_index is negative value 
 img_dec = min_index + img_dec ;

for i=3600:-1:2
    img_dec(i,1) = img_dec(i,1) + img_dec(i-1,1);         
end
% Reverse loop operations
img_vec = zeros(1,64);
m_8x8_block = ones(8);
q=1;
% inv_img = ones(512);
vx= 0:8:352;
vec1 = 1:8:641; 
tem =1;
for i=1:3600
   
     % Select one row
    img_vec = img_dec(i,:);
    
    %Dequantize, use dot product (two vectors)
    img_vec = img_vec .*qt;
    
     %Zag Rerverse 
    for j=1:64
       m_8x8_block(find(zag == j)) = img_vec(j);
    end
    
    %Reverse DCT
    m_8x8_block = idct(m_8x8_block);
    
    %Reconstruct blocks back to 512x512
    for j=1:8
        inv_img(j+vx(q),vec1(tem):vec1(tem + 1) - 1) = m_8x8_block(j,:);
    end
    tem = tem + 1;
    if tem == 81
        tem = 1;
        q= q + 1;      
    end
    
end
inv_img = inv_img + 128;
inv_img = uint8(inv_img);

x = linspace(0,1,256)';
map = [x x x];

img_dec = inv_img;
imwrite(inv_img,map,outfile);

% MSE = immse(img_x, img_dec);

%fprintf("MSE = %d\n",MSE);
% clearvars -except img_dec
clearvars -except img_dec