function [mcpr,pred] = mc_prediction(prev,curr,mvx,mvy)

[rFrame,cFrame] = size(curr);
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

% write_Yframe(pred, 'foreman_qcif_pred_frame.y');
% k = mat2gray(mcpr);
% figure;
% imshow(k);