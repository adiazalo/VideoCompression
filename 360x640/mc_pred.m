function pred = mc_pred (prev, curr, mx,my,N)

[row,col] = size(curr);
 pred = zeros(row,col); 
%  pred = double(pred);
% index_row = 0;
% index_col = 0;
a=1; b=1;
for i=1:N:row-1
    for j=1:N:col-1
        
        index_row = my(a,b);
        index_col = mx(a,b);
        b = b + 1;
            
         index_row = index_row + i;
         index_col = index_col + j;
%         ind_row = i:N;
%         ind_col = j:N;
%         ind_col
%         pred(i:8,j:8) = prev(index_row:N, index_col:N);
        
        for k=0:N-1
            for q=0:N-1
                pred(k+i,q+j) = prev(index_row + k, index_col + q);
            end
        end
%         
    end
    b = 1; 
    a = a +1;
end
whos pred
  pred = (pred);
figure, imshow(mat2gray(pred));
whos pred
title('Predicted New');

%         
%         if index_row == 0 
%             index_row = i;
%         elseif index_row < 0 
%                 index_row = index_row + i;
%         else 
%         end
%                     

%             
%             
%             
%         if index_col == 0 
%             index_col = j;
%         elseif index_col < 0 
%             index_col = index_col + j;
%         else
%             
%         end
