% M- file: torque_speed_curve.m
% M- file create a plot of the torque-speed curve of the 
% induction motor of Example 6- 5. 

% First, init i ali ze t he val ues needed in this program. 
r1 = 0.641; % Stator resist ance 
x1 = 1.106; % Stator reactance 
r2 = 0.332; % Rotor resistance 
x2 = 0.464; % Rotor reactance 
xm = 26.3; % Magnetizat i on branch reactance 
v_phase = 460 / sqrt(3); % phase voltage 相電壓
n_sync = 1800; % Synchronous speed (r/min) % 同步轉速
w_sync = 188.5; % Synchronous speed (rad/s) % 同步角速度

% Calculate the Thevenin voltage and impedance f rom Equations 
% 6-41a and 6- 43 . 
v_th = v_phase * (xm / sqrt(r1^2 + (x1 + xm)^2 )) ; % 戴維寧等效電歷
z_th = ((1j*xm) * (r1 + 1j *x1)) / (r1 + 1j * (x1 + xm)); % 戴維寧等效電抗
r_th = real(z_th); % 戴維寧等效電路（實部）
x_th = imag(z_th); % 戴維寧等效電路（虚部）
 
% Now calculate the torque- speed characteristic for many 
% slips between 0 and 1. Note that the first sl i p value 
% is set t o 0. 001 instead of exactly 0 to avoid divide
% by-zero problems. 
% Now calculate the torque-speed characteristic 計算鱄矩-轉速特性
s = (0:1:50) /50; % 滑差範圍
s(1) = 0.001; % 設定第一個滑差值為0.901取代e以避免程式發散
nm = (1 - s) * n_sync; % Mechanical speed 

% Calculate torque for original rotor resistance
t_ind1 = zeros(1, 51);
for ii = 1:51
    t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ... 
        (w_sync * ((r_th + r2 / s(ii))^2 + (x_th + x2)^2 ));
end

% Calculate torque for doubled rotor resistance 
t_ind2 = zeros(1, 51);
for ii = 1:51
    t_ind2(ii) = (3 * v_th^2 * (2 * r2) / s(ii)) / ... 
        (w_sync * ((r_th + (2 * r2) / s(ii))^2 + (x_th + x2)^2));
end 
% Plot the torque-speed curve 
plot(nm, t_ind1, 'Color', 'b', 'LineWidth', 2.0); 
hold on; 
plot(nm, t_ind2, 'Color', 'k', 'LineWidth', 2.0, 'LineStyle', '-.'); 
xlabel('\bf\itn_{m}'); 
ylabel('\bf\tau_{ind}'); 
title('\bfInduction Motor Torque-Speed Characteristic'); 
legend('Original R_{2}', 'Doubled R_{2}'); 
grid on;
hold