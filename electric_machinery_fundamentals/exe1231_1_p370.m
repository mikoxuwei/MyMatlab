% p.370 example 6-6
% M-file: torque_speed_2.m
% M-file creates and plot of the torque-speed curve of the torque-speed curve of 
% an induction motor with a double-cage rotor design.
% First, initialize the values needed in this program.
r1 = 0.641;  % Stator resistance 定子阻抗
x1 = 0.750;  % Stator reactance 定子電抗
r2 = 0.300;  % Rotor resistance for single-cage motor 轉子阻抗
r2i = 0.400;  % Rotor resistance for inner cage of double-cage motor 內轉子阻抗
r2o = 3.200;  % Rotor resistance for output cage of double-cage motor 雙鼠籠式轉子阻抗
x2 = 0.500;  % Rotor reactance for single-cage motor 轉子電抗
x2i = 3.300;  % Rotor reactance for inner cage of double-cage motor 內轉子電抗
x2o = 3.300;  % Rotor reactance for output cage of double-cage motor 雙鼠籠式轉子電抗
xm = 26.3;  % Magnetization branch reactance 鐵芯電抗
v_phase = 460 / sqrt(3);  % phase voltage 相電壓
n_sync = 1800;  % Synchronous speed (r/min) 同步轉速(rpm)
w_sync = 188.5;  % Synchronous speed (rad/s) 同步轉速(徑度/秒)

% Calculate the Thevenin voltage and impedance from Equations
% 從戴維寧等效電路計算出
% 6-41a and 6-43.
v_th = v_phase * (xm / sqrt(r1^2 + (x1 + xm)^2));  % 戴維寧等效電壓
z_th = ((1j * xm) * (r1 + 1j * x1)) / (r1 + 1j * (x1 + xm)); % 戴維寧等效電路電抗
r_th = real(z_th);  % Thevenin equivalent resistance (real part) 戴維寧等效電組
x_th = imag(z_th);  % Thevenin equivalent reactance (imaginary part) 戴維寧等效感抗

% NEW Calculate the motor speed for many slips between 0 and 1. 轉差從0-1的變化
% Note that the first slip value is set to 0.001 instead of exactly 0 to avoid divide-by-zero problems.
s = (0:1:50) / 50;  % Slip 繪出50點
s(1) = 0.001;  % Avoid division-by-zero 每一點變化
nm = (1 - s) * n_sync;  % Mechanical speed 轉子轉速

% Calculate torque for original rotor resistance 
% 單鼠籠式轉子計算
for ii = 1:51
    t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
        (w_sync * ((r_th + r2 / s(ii))^2 + (x_th + x2)^2));
end

% Calculate resistance and reatance of the doubled-cage rotor at this slip,
% 計算雙鼠籠式轉子轉矩
% and then use those values to calculate the induced torque.
for ii = 1:51
    y_r = 1  /(r2i + j * s(ii) * x2i) + 1 / (r2o + j * s(ii) * x2o);
    z_r= 1 / y_r;  % Effective rotor impedance
    r2eff = real(z_r);  % Effective rotor resistance
    x2eff = imag(z_r);  % Effective rotor reactance

    % Calculate induced torque for double-cage rotor.
    t_ind2(ii) = (3 * v_th^2 * (2 * r2) / s(ii)) / ...
        (w_sync * ((r_th + (2 * r2) / s(ii))^2 + (x_th + x2)^2));
end

% Plot the torque-speed curve 繪出轉矩-轉速曲線圖
figure;
plot(nm, t_ind1, 'b', 'LineWidth', 2.0);  % Torque for original rotor resistance
hold on;
plot(nm, t_ind2, 'k', 'LineWidth', 2.0, 'LineStyle', '--');  % Torque for doubled rotor resistance
xlabel('\bf\itn_{m}');
ylabel('\bf\tau_{ind}');
title('\bfInduction motor torque-speed characteristic');
legend('Single-cage design', 'Double-cage design');
grid on;
hold off;

