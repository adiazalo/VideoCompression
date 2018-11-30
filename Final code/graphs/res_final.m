%%% Data for ploting operational garph vs number of bits & PSNR vs number
%%% of frames for both videos 

%%% Uncomment to plot kirstine graph %%%%%%%
%kristine operational rate-distortion curves

% x_E_SAD_32 = [3689.24 3856.965 4050.899 5153.47];
% y_E_SAD_32 = [30.7461 34.7734 36.5714 37.2578];
% 
% x_E_SAD_16 = [3719.973 3891.556 4078.388 5211.13];
% y_E_SAD_16 = [30.5048 34.5283 36.3889 37.0878];
% 
% x_E_MAD_16 = [3709.464 3892.761 4080.904 5203.849];
% y_E_MAD_16 = [30.6042 34.5126 36.3876 37.0924];
% 
% x_D_SAD_16 = [3732.883 3913.247 4124.75 5292.953];
% y_D_SAD_16 = [30.0985 33.9035 35.6144 36.2757];
% 
% x_D_MAD_16 = [3732.629 3910.304 4125.478 5300.371];
% y_D_MAD_16 = [30.0995 33.9068 35.616 36.275];

%Natalie video operational rate-distortion curves

x_E_SAD_32 = [3746714 3928094 4081240 5111657];
y_E_SAD_32 = [30.7458 34.5885 36.5002 38.4936];

x_E_SAD_16 = [3753358  3947818 4099976 5152608];
y_E_SAD_16 = [30.5913 34.3312 36.3731 38.3404];

x_E_MAD_16 = [3731950  3941136 4153229 5358252];
y_E_MAD_16 = [30.3467 33.9068  36.0256 36.8602];

x_D_SAD_16 = [3731950 3941136 4153229 5358252];
y_D_SAD_16 = [30.3467 33.9068 36.0256 36.8602];

x_D_MAD_16 = [3731950 3941136 4153229 5358252];
y_D_MAD_16 = [30.3467 33.9068 36.0256 36.8602];

% figure
% plot(x_E_SAD_32,y_E_SAD_32,'r-o',x_E_SAD_16, y_E_SAD_16,'b-o',x_E_MAD_16, y_E_MAD_16,'g-o',x_D_SAD_16, y_D_SAD_16,'c-s',x_D_MAD_16, y_D_MAD_16,'m-s')
% xlabel('Total number of bytes');
% ylabel('PSNR (dB)');
% title('Operational rate-distortion curves');
% legend({'Exhaustive SAD +/-32','Exhaustive SAD +/-16','Exhaustive MAD +/-16','Diamond SAD +/-16','Diamond MAD +/-16'},'Location','southeast')
% 



%PSNR per frame **** NAtalie *******
x_frames = 1:120;

E_SAD_16_90 = load('PSNR_R16_Q90_F120.mat','PSNR');

E_MAD_16_90 = load('PSNR_ESMB_MAD_R16_Q90.mat','PSNR');

D_SAD_16_90 = load('PSNR_Dimond_SAD_R16_Q90.mat','PSNR');

D_MAD_16_90 = load('PSNR_Dimond_MAD_R16_Q90.mat','PSNR');

%%%%%%%% Uncomment below lines to obtain PSNR vs frame graph for Kirstine %

%%%%%%% **** Kristine ******************
% E_SAD_16_90 = load('PSNR_E_SAD_16_90.mat','PSNR');
% 
% E_MAD_16_90 = load('PSNR_E_MAD_16_90.mat','PSNR');
% % 
% D_SAD_16_90 = load('PSNR_D_SAD_16_90.mat','PSNR');
% 
% D_MAD_16_90 = load('PSNR_D_MAD_16_90.mat','PSNR');


 
figure
plot(x_frames,E_SAD_16_90.PSNR(:),'r',x_frames, E_MAD_16_90.PSNR(:),'b-o',x_frames, D_SAD_16_90.PSNR(:),'g',x_frames, D_MAD_16_90.PSNR(:),'c-o')
xlabel('Frame Number');
ylabel('PSNR (dB)');
title('PSNR per Frame at Quality 90');
legend({'Exhaustive SAD +/-16','Exhaustive MAD +/-16','Diamond SAD +/-16','Diamond MAD +/-16','Location','southeast'});


figure
subplot(2,1,1);
plot(x_frames,E_SAD_16_90.PSNR(:),'r',x_frames, E_MAD_16_90.PSNR(:),'b')
xlabel('Frame Number');
ylabel('PSNR (dB)');
title('PSNR per Frame at Quality 90');
legend({'Exhaustive SAD +/-16','Exhaustive MAD +/-16'});

subplot(2,1,2);
plot(x_frames, D_SAD_16_90.PSNR(:),'g-*',x_frames, D_MAD_16_90.PSNR(:),'c')
xlabel('Frame Number');
ylabel('PSNR (dB)');
title('PSNR per Frame at Quality 90');
legend({'Diamond SAD +/-16','Diamond MAD +/-16','Location','southeast'});


% use load(fullfile('kristen', 'Diamond',
% 'MAD','16-90','PSNR_D_16_90.mat')) to load files
