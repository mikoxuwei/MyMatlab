% M-file: mag_current.m 
% M-file to calculate and plot the magnetization 
% current of a 230/115 transformer operating at 
% 230 volts and 50/60 Hz . This program also 
% calculat es t he rms value of the mag. current. 
% Load the magnetization curve. It is in two 
% columns, with the first column being rumf and 
% the second column being flux.

load mag_curve_1.dat
mmf_data = mag_curve_1(:, 1);
flux_data = mag_curve_1(:, 2);

% Initialize value
VM = 325; % Maximum voltage (V) 
NP = 850; % Primary turns

% Calculate angular velocity for 60 Hz
freq = 60;        % freq (Hz)
w = 2* pi* freq; 
% Calulate flux versus time
time = 0:1/3000:1/30;         % 0 to 1/30 sec
flux = -VM/(w*NP)* cos(w.* time);

% Calulate the mmf corresponding to a given flux
% using the flux's interpolation function
mmf = interp1(flux_data, mmf_data, flux);
% Calculate the magnetization current 
im = mmf/NP;
% Calculate the rms value of the current
irms = sqrt(sum(im.^2)/length(im));
disp(['The rms current at 60 Hz is',num2str(irms)]);

% Plot the magnetization current
figure
subplot(2, 1, 1);
plot(time, im);
title ('\bfMagnetization Current at 60 Hz ');
xlabel ('\bfTime(8)') ;
ylabel ('\bf\itI_(m)\rm(A)') ;
axis([0 0.04 -2 2]) ;
grid on;

%%
% Calculate angular velocity for 50 hz
freq1 = 50; % Freq (Hz)
w1 = 2* pi* freq1;
% Calcu late flux versus time 
time1 = 0:1/2500:1/25;
flux1 = -VM/(w1*NP) * cos(w1.*time1);
% Calculate the mm = corresponding to a given flux
% using the flux's interpolation function .
mmf1 = interp1(flux_data, mmf_data, flux1);
% Calculate the magnetization current 
im1 = mmf1/NP;

% Calculate the rms value of the current
irms1 = sqrt(sum(im1.^2)/length(im1));
disp(['The rms current at 50 Hz is', num2str(irms1)]);

% Plot the magnetization current
subplot(2, 1, 2) ;
plot(time1, im1);
title('\bfMagnetization Current at 50 Hz');
xlabel('\bfTime(s)');
ylabel('\bf\itI_ (m)\rm(A)');
axis([0 0.04 -2 2]);
grid on;