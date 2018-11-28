%%%%%%%%%%% range 16 %%%%%%%%%%%
%%% number of bytes ( bit + hist + (header*120) %%%%
%%%%% 16 Q50 -> 3901860+(8*120)+44998
x = [3947818 4099976  5152608];

%%% PNSR %%%%%%
%%%%%% 50 70 90 -->  sum(PSNR)/120%%%%%%%
y = [34.3312  36.3731 38.3404];


%%%%% Search range 32 %%%%%%%

u = [3928094  4081240 5111657];
%%PSNR%%%% 
v = [34.5885 36.5002 38.4936];
figure

plot(x,y, '-*')
title('Number of bytes vs PSNR')
xlabel('Number of bytes')
ylabel('PNSR (dB)')
hold on 
plot(u,v,'-o')
hold off
legend('Integer MC, +/- 16','Integer MC, +/- 32')