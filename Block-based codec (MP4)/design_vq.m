function codebook = design_vq(training_set, codebook, tol, maxiter)
[M,N] = size(codebook);
training_setNumRows = size(training_set,1);
if training_setNumRows > 1
    training_set = training_set';
end

[index,xq,MSE] = vq(training_set,codebook);
iter = 1; % count number of iterations
dMSE = 10*tol+1; % relative change between iterations

while  (iter <= maxiter) && (dMSE > tol)
    for i = 1:M
        ind = find(index == (i));
        if ~isempty(ind)
            codebook(i,:) = mean(training_set(ind));
        end
    end
    [index, xq, newMSE] = vq(training_set,codebook);
    dMSE = abs(newMSE-MSE)/MSE;
    MSE = newMSE;
    iter = iter + 1
end

clear iter;
clear MSE;
clear dMSE;
clear index;
clear xq;
clear index;
clear training_set;
clear to1;