function [mvx,mvy] = motion_estimation(prev, curr, blkx, blky, search_range)
[currFrRow, currFrCol] = size(curr);
%SAD_Matrix = zeros(1+2*(search_range/blky),1+2*(search_range/blkx))
SAD_Matrix = zeros(currFrRow/blky,currFrCol/blkx);
SAD_elements = numel(SAD_Matrix);
nBlks = (currFrRow*currFrCol)/(blkx*blky);
    vRange = search_range;
    hRange = search_range;

%initaliaze mvx and mvy
mvx = zeros(currFrRow/blky,currFrCol/blkx);
mvy = zeros(currFrRow/blky,currFrCol/blkx);

n = 1;
n_mvy = 1;
n_mvx = 1;
rIndex = 1;
cIndex = 1;
rWinIndex = 1;
cWinIndex = 1;
while cIndex<176
    while rIndex<144
        %extract block from curr
        currBlk = curr(rIndex:rIndex+blky-1, cIndex:cIndex+blkx-1);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        while cWinIndex<176
            while rWinIndex<144
                
                % check if window is in range
                if abs(rIndex-rWinIndex) <= search_range && abs(cIndex-cWinIndex) <= search_range
                    window = prev(rWinIndex:rWinIndex+blky-1,cWinIndex:cWinIndex+blkx-1);

                    % SAD
                    ab = abs(double(window(:)) - double(currBlk(:)));
                    s = sum(ab(:));                            
                    SAD_Matrix(n) = s;
                    if SAD_Matrix(n) == 0
                        SAD_Matrix(n) = 1;
                    end
                    
                    %test
                    if rIndex == 41 && cIndex == 41
                        Test = SAD_Matrix;
                    end
                end
                
                if n<SAD_elements
                    n=n+1;
                end
                rWinIndex = rWinIndex + blky;
            end
            rWinIndex = 1;
            cWinIndex = cWinIndex + blkx;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % coordinates of min SAD
        [r,c] = find(SAD_Matrix == min(SAD_Matrix(SAD_Matrix>0)));
        
        [rR, rC] = size(r);
        [cR, cC] = size(c);
        
        if rR > 1
            r = r(1);
        end
        if cR > 1
            c = c(1);
        end
        
        SAD_Matrix(SAD_Matrix==1) = 0;

        %rMatch = r*blky+1;
        %cMatch = c*blky+1;
        
        rMatch = (r-1)*blky+1;
        cMatch = (c-1)*blkx+1;
        
        match = prev(rMatch:rMatch+blky-1, cMatch:cMatch+blkx-1);
        
        %store changes between curr and prev
        mvy(n_mvy)= rIndex-rMatch;
        mvx(n_mvx)= cIndex-cMatch;
        
%         mvy(n_mvy)= rMatch-rIndex;
%         mvx(n_mvx)= cMatch-cIndex;

        n_mvy = n_mvy+1;
        n_mvx = n_mvx+1;
        
        rIndex = rIndex + blky;
        
        % reset values
        rWinIndex = 1;
        cWinIndex = 1;
        n=1;
        SAD_Matrix = zeros(currFrRow/blky,currFrCol/blkx);
     end
     rIndex = 1;
     cIndex = cIndex + blkx;
end
% quiver(mvx,mvy)
% disp(Test)
clearvars -except mvx mvy;





