function [NbitsImg,NbitsMVX,NbitsMVY] = entropyCoding(imgq_1x230400,mvx,mvy, bitfile,bitfileMVX,bitfileMVY)
%coding image
minValue = min(imgq_1x230400);
maxValue = max(imgq_1x230400);
counts = zeros(1,maxValue);
for scan = 1:230400
    scanValue = imgq_1x230400(scan);
    counts(scanValue) = counts(scanValue) + 1;
end
counts(counts<1) = 1; 
save('dct_hist','counts');
NbitsImg = encArith(imgq_1x230400,'dct_hist',bitfile);

%coding MV
[rX,cX] = size(mvx);
[rY,cY] = size(mvy);

mvx = mvx+32;
mvy = mvy+32;

totalX = rX*cX;
totalY = rY*cY;
mvx_reshaped = reshape(mvx',[1,totalX]);
mvy_reshaped = reshape(mvy',[1,totalY]);

%MVX
minValueMVX = min(mvx_reshaped);
maxValueMVX = max(mvx_reshaped);
counts = ones(1,maxValue);
for scan = 1:totalX
    scanValue = mvx_reshaped(scan);
    if scanValue == 0
        scanValue = scanValue+1;
    end
    counts(scanValue) = counts(scanValue) + 1;
end
counts(counts<1) = 1;
save('mvx_hist','counts');
NbitsMVX = encArith(mvx_reshaped,'mvx_hist',bitfileMVX);
%MVY
minValueMVY = min(mvy_reshaped);
maxValueMVY = max(mvy_reshaped);
counts = ones(1,maxValue);
for scan = 1:totalX
    scanValue = mvy_reshaped(scan);
    if scanValue == 0
        scanValue = scanValue+1;
    end
    counts(scanValue) = counts(scanValue) + 1;
end
counts(counts<1) = 1;
save('mvy_hist','counts');
NbitsMVY = encArith(mvy_reshaped,'mvy_hist',bitfileMVY);

%%Contcatinate bit files??
clearvars -except NbitsImg NbitsMVX NbitsMVY;