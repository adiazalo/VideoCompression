function [pred, mcpr]=mCompensation(prev,curr,mx,my) 
%function [f_e dfd fd tot_sad tot_sado comp]=blockmatching(f_r,f_t,8,M)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% % %%%%%%%%%%Full Exhaustive Block Matching Motion Estimation Method%%% 
% Inputs % f_r ---> Reference Image % f_t ---> Target Image % 8 ---> Block Size % M ---> Search Window 
% th ---> Threshold Value % Outputs % f_e ---> Estimated Image % dfd ---> Displaced Frame Difference 
% fd ---> Frame Difference % tot_sad ---> Total SAD value % tot_sado ---> Total SAD value at v=0 
% comp --> Number of Iterations/Computations Performed 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%% 
%Converting the images from uint8 to Double Format 

% Uncomment the below line if you pass an image 
% prev = imread(f_r); curr = imread(f_t);

% prev = rgb2gray(prev); curr = rgb2gray(curr);
% f_r = mat2gray(f_r);  f_t = mat2gray(f_t); 

%%%% original code line one line which is below %%%%%%
prev=double(prev); curr=double(curr);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Determining the Image Size 
[row col]=size(curr); 
%Initializing a Estimated Image 
pred=zeros(row,col); pred=double(pred); a=1; b=1; 
%Number of Computations 
comp=1; 
tic; 
for i=1:8:row 
    for j=1:8:col 
        %Initializing Motion Vectors and SAD matrices 
        v1_min=0; v2_min=0; sad=[]; v1_mat=[]; v2_mat=[]; it=1;
        %Searching for the optimal motion vector over the entire search range M 
%         for v1=-M:M 
%             for v2=-M:M 
%                 %Incrementing the number of Computations 
%                 comp=comp+1; 
%                 %Determining the Row start points for Target and Reference Blocks to be compared for Motion Estimation 
                start_t_i=i; 
%                 start_r_i=v1+i; 
%                 %Determining the Row end points for Target and Reference Blocks 
%                 if(start_t_i+8>row)                 
%                     end_t_i=row; 
%                     end_r_i=v1+row; 
%                 else
%                     end_t_i=start_t_i+8-1;
%                     end_r_i=start_r_i+8-1; 
%                 end 
%                 %Determining the Column Start Points for Target and Reference Blocks 
                start_t_j=j; 
%                 start_r_j=j+v2; 
%                 %Determining the Column end points for Target and Reference Blocks 
%                 if(start_t_j+8>col) 
%                     end_t_j=col; 
%                     end_r_j=v2+col; 
%                 else
%                     end_t_j=start_t_j+8-1; 
%                     end_r_j=start_r_j+8-1; 
%                 end 
%                 if(end_r_i<row && end_r_j<col && start_r_i>0 && start_r_j>0) 
%                     %Calculating the SAD value for the current motion vector 
%                     dif=curr(start_t_i:end_t_i,start_t_j:end_t_j)-prev(start_r_i:end_r_i,start_r_j:end_r_j);
%                     dif=abs(dif);
%                     sadx=sum(sum(dif));
%                     if(it==1)
%                         sad=sadx; 
%                         v1_mat=v1;
%                         v2_mat=v2; 
%                         it=it+1; 
%                     else
%                         sad=[sad ;sadx]; 
%                         v1_mat=[v1_mat; v1]; 
%                         v2_mat=[v2_mat; v2];
%                         it=it+1;
%                     end
%                 end
%             end
%         end
        % Finding the Motion vectors for Minimum SAD value 
%         if(isempty(sad)==0)
%             pos=find(sad==min(sad));
%             v1_min=v1_mat(pos(1),1); 
%             v2_min=v2_mat(pos(1),1); 
%         end
        
        %Storing the determined motion vectors in an array 
        v1_min = my(a,b);
        v2_min = mx(a,b);
        b=b+1;
        
%         V1(a,b)=v1_min;
%         V2(a,b)=v2_min;
%         b=b+1; 
        %Calculating the start and end points in the Predicted and to be
        %assigned Reference Block 
        start_r_j=j+v2_min; 
        start_r_i=v1_min+i; 
        if(start_r_j+8-1>col && start_t_j+8-1<=col) 
            end_r_j=2*start_r_j+8-col -1; 
            end_t_j=col; 
        end
        if(start_t_j+8-1>col&&start_r_j+8-1<=col) 
            end_r_j=start_r_j+start_t_j+8-col -2; 
            end_t_j=col; 
        end
        if(start_t_j+8-1>col && start_r_j+8-1>col ) 
            end_t_j=col; 
            end_r_j=start_r_j+end_t_j-start_t_j; 
        end
        if(start_t_j+8-1<=col ) 
            end_r_j=start_r_j+8-1; 
            end_t_j=start_t_j+8-1; 
        end
        if(start_r_i+8-1>row || start_t_i+8-1<=row)
            end_r_i=2*start_r_i+8-row -1; 
            end_t_i=row; 
        end
        if(start_t_i+8-1>row || start_r_i+8-1<=row) 
            end_r_i=start_r_i+start_t_i+8-row -2;
            end_t_i=row; 
        end
        if(start_t_i+8-1>row && start_r_i+8-1>row ) 
            end_t_i=row;
            end_r_i=start_r_i+end_t_i-start_t_i; 
        end
        if(start_t_i+8-1<=row )
            end_t_i=start_t_i+8-1; 
            end_r_i=start_r_i+8-1; 
        end
        
        disp("start_t_i")
        disp(start_t_i)
        disp("end_t_i")
        disp(end_t_i)
        disp("start_t_j")
        disp(start_t_j)
        disp("start_r_i")
        disp(start_r_i)
        disp("end_r_i")
        disp(end_r_i)
        disp("start_r_j")
        disp(start_r_j)
        disp("end_r_j")
        disp(end_r_j)
        pred(start_t_i:end_t_i,start_t_j:end_t_j)=prev(start_r_i:end_r_i,start_r_j:end_r_j); 
    end
    b=1; 
    a=a+1;
end
%Getting the Displaced Difference Frame Image 
mcpr = curr - pred;
% dfd=imsubtract(pred,curr);
% % Getting the minimum value so as to properly match -ve values for better 
% min_dfd=min(min(dfd)); 
% dfd=dfd+abs(min_dfd); 
% % % % Getting the Frame Difference 
% fd=imsubtract(f_r,f_t); 
% % % % Getting the minimum value so as to properly match -ve values for better
% % % % display 
% min_fd=min(min(fd)); 
% fd=fd+abs(min_fd); 
% figure,imshow(mat2gray(f_r));
% title('Reference Image');
% figure,subplot(1,2,1),imshow(mat2gray(f_t));
% title('Target Image'); 
% subplot(1,2,2),imshow(mat2gray(f_e)); 
% title('Predicted Image'); 
% figure,subplot(1,2,1),imshow(mat2gray(dfd));
% title('Displaced Frame Difference');
% subplot(1,2,2),imshow(mat2gray(fd)); 
% title('Frame Difference');
%  figure,quiver(V2,V1)%quiver(V2,V1);
% set(gca,'xaxislocation','top','yaxislocation','left','xdir','default','ydir','reverse');
% title('Motion Vector Field');
% xlabel('Columns');
% ylabel('Rows'); 
% figure, imshow(mat2gray(pred));
% title('Predicted Image');

% Reference %%
% https://www.slideshare.net/dswazalwar/block-matching-project %