
PSNR = zeros(1,399);
x = 1:399;
for n = 1:399
    prev = read_Yframe ('foreman_qcif.y',144,176, n);
    curr = read_Yframe ('foreman_qcif.y',144,176, n+1);
    
    [mvx,mvy] = motion_estimation(prev,curr,8,8,16);
    [mcpr,pred] = mc_prediction(prev,curr,mvx,mvy);
    
    %store predicted frame in 'foreman_qcif_pred.y'
    write_Yframe(pred, 'foreman_qcif_pred.y');
    
    %store MSE in vector
    mse = immse(prev,curr);
    PSNR(1,n) = 10*log10((255^2)/mse);    
    disp(n)
end
 
plot(x,PSNR,'b')
xlabel('Frame Number');
ylabel('PSNR (dB)');
title('PSNR of predicted frames');