function [NbitsImg,NbitsMVX,NbitsMVY] = entropyCoding(imgq_1x921600,mvx,mvy, bitfile,bitfileMVX,bitfileMVY)
%coding image
minValue = min(imgq_1x921600);
maxValue = max(imgq_1x921600);
counts = zeros(1,maxValue);
for scan = 1:921600
    scanValue = imgq_1x921600(scan);
    counts(scanValue) = counts(scanValue) + 1;
end
counts(counts<1) = 1; 
save('dct_hist','counts');
NbitsImg = encArith(imgq_1x921600,'dct_hist',bitfile);

%coding MV
[rX,cX] = size(mvx);
[rY,cY] = size(mvy);

mvx = mvx+16;
mvy = mvy+16;

mvx_reshaped = reshape(mvx',[1,3600]);
mvy_reshaped = reshape(mvy',[1,3600]);

%MVX
minValueMVX = min(mvx_reshaped);
maxValueMVX = max(mvx_reshaped);
countsMVX = zeros(1,maxValue);
for scan = 1:3600
    scanValue = mvx_reshaped(scan);
    countsMVX(scanValue) = countsMVX(scanValue) + 1;
end
countsMVX(countsMVX<1) = 1;
save('mvx_hist','countsMVX');

%MVY
minValueMVY = min(mvy_reshaped);
maxValueMVY = max(mvy_reshaped);
countsMVY = zeros(1,maxValue);
for scan = 1:3600
    scanValue = mvy_reshaped(scan);
    countsMVY(scanValue) = countsMVY(scanValue) + 1;
end
countsMVY(countsMVY<1) = 1;
save('mvy_hist','countsMVY');

NbitsMVX = encArith(mvx_reshaped,'mvx_hist',bitfileMVX);
NbitsMVY = encArith(mvy_reshaped,'mvy_hist',bitfileMVY);


%%Contcatinate bit files??
clearvars -except Nbits;