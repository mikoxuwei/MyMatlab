load mag_curve_1.dat
mmf_data = mag_curve_1(:, 1);
flux_data = mag_curve_1(:, 2);

VM = 325;
NP = 850;

freq = 60;        % freq (Hz)
w = 2* pi* freq; 
% Calulate flux versus time
time = 0:1/3000:1/30;         % 0 to 1/30 sec
flux = -VM/(w*NP)* cos(w.* time);

% Calulate the mmf corresponding to a given flux
% using the flux's interpolation function
mmf = interp1(flux_data, mmf_data, flux);

im = mmf/NP;

irms = sqrt(sum(im.^2)/length(im));
disp(['The rms current at 60 Hz is',num2str(irms)]);

figure
subplot(2, 1, 1);
plot(time, im);
title ('\bfMagnetization Current at 60 Hz ');
xlabel ('\bfTime(8)') ;
ylabel ('\bf\itI_(m)\rm(A)') ;
axis([0 0.04 -2 2]) ;
grid on;

freq1 = 50;
w1 = 2* pi* freq1;

time1 = 0:1/2500:1/25;
flux1 = -VM/(w1*NP) * cos(w1.*time1);

mmf1 = interp1(flux_data, mmf_data, flux1);

im1 = mmf1/NP;


irms1 = sqrt(sum(im1.^2)/length(im1));
disp(['The rms current at 50 Hz is', num2str(irms1)]);

subplot(2, 1, 2) ;
plot(time1, im1);
title('\bfMagnetization Current at 50 Hz');
xlabel('\bfTime(s)');
ylabel('\bf\itI_ (m)\rm(A)');
axis([0 0.04 -2 2]);
grid on;