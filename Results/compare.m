% I = imread('lena512.bmp');
% imwrite(I,'lena512_compressed.jpg','jpg','quality',90);
% D = imread('lena512_compressed.jpg');
% err = immse( I , D )

% s=dir('yourfile')
% the_size=s.bytes

% xDec = [25.3092 35.056 41.635 46.496 51.011 55.719 62.607 73.478 96.508];
% yDec = [23.210 26.878 29.759 31.407 32.594 33.728 35.219 37.114 40.210];
% xJ = [7.82 11.6 14.8 17.6 20.4 23.5 28.6 37.0 57.9];
% yJ = [30.401 32.949 34.262 35.108 35.785 36.434 37.301 38.507 40.784];
% plot(xDec,yDec,'r-o',xJ, yJ,'b-o')
% xlabel('Total number of bytes (KB)');
% ylabel('PSNR (dB)');
% title('Operational rate-distortion curves');
% legend({'Developed Codec','JPEG Codec'},'Location','southeast')

%kristine operational rate-distortion curves
% x = bytes
% y = PSNR
x_E_SAD_32 = [3689.24 3856.965 4050.899 5153.47];
y_E_SAD_32 = [30.7461 34.7734 36.5714 37.2578];

x_E_SAD_16 = [3719.973 3891.556 4078.388 5211.13];
y_E_SAD_16 = [30.5048 34.5283 36.3889 37.0878];

x_E_MAD_16 = [3709.464 3892.761 4080.904 5203.849];
y_E_MAD_16 = [30.6042 34.5126 36.3876 37.0924];

x_D_SAD_16 = [3732.883 3913.247 4124.75 5292.953];
y_D_SAD_16 = [30.0985 33.9035 35.6144 36.2757];

x_D_MAD_16 = [3732.629 3910.304 4125.478 5300.371];
y_D_MAD_16 = [30.0995 33.9068 35.616 36.275];

plot(x_E_SAD_32,y_E_SAD_32,'r-o',x_E_SAD_16, y_E_SAD_16,'b-o',x_E_MAD_16, y_E_MAD_16,'g-o',x_D_SAD_16, y_D_SAD_16,'c-s',x_D_MAD_16, y_D_MAD_16,'m-s')
xlabel('Total number of bytes (KB)');
ylabel('PSNR (dB)');
title('Operational rate-distortion curves');
legend({'Exhaustive SAD +/-32','Exhaustive SAD +/-16','Exhaustive MAD +/-16','Diamond SAD +/-16','Diamond MAD +/-16'},'Location','southeast')









