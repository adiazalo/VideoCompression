function [mcpr,pred] = mc_prediction(prevInput,currInput,mvx,mvy)
prevTemp = imread(prevInput);
prev = rgb2gray(prevTemp);

currTemp = imread(currInput);
curr = rgb2gray(currTemp);
[rFrame,cFrame] = size(curr)
[rV,cV] = size(mvx);
blky = rFrame/rV;
blkx = cFrame/cV;
mcpr = zeros(rFrame,cFrame);
pred = zeros(rFrame,cFrame);

n = 1;
rIndex = 1;
cIndex = 1;
while cIndex<cFrame
    while rIndex<rFrame
        %extract block from curr
        currBlk = curr(rIndex:rIndex+blky-1, cIndex:cIndex+blkx-1);
        
        cPrevIndex = cIndex-mvx(n);
        rPrevIndex = rIndex-mvy(n);
        
%         disp(cIndex)
%         disp(rIndex)
%         disp(rPrevIndex)
%         disp(cPrevIndex)
%         disp(blky)
%         disp(blkx)

        %extract the block from prev
        prevBlk = prev(rPrevIndex:rPrevIndex+blky-1, cPrevIndex:cPrevIndex+blkx-1);
       
        %store previous blk in in same location where current blk is in curr
        pred(rIndex:rIndex+blky-1, cIndex:cIndex+blkx-1) = prevBlk;
        
        %store the diff
        mcpr(rIndex:rIndex+blky-1, cIndex:cIndex+blkx-1) = currBlk-prevBlk;
        
        n = n + 1;
        rIndex = rIndex + blky;
    end
    rIndex = 1;
    cIndex = cIndex + blkx;
end
imwrite(uint8(pred), 'dustpan_pred_frame.jpg');
imwrite(uint8(mcpr), 'dustpan_mcpr_frame.jpg');

mcpr = sprintf('dustpan_mcpr_frame.jpg');

%  write_Yframe(pred, 'dustpan_pred_frame.jpg');
%  k = mat2gray(pred);
%  figure;
%  imshow(k);