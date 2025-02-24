% Clear workspace
clear;
clc;

% Load FTP-75 speed data from text file 
% (1st column is time, 2nd column is vehicle speed)
% 載入行程 FTP-75
data_file = 'ftp75_speed.txt';
data = readmatrix(data_file);
time = data(:, 1);  % Time in seconds
vehicle_speed = data(:, 2);  % Vehicle speed in km/h

% Constants and parameters 車輛參數(TOYOTA VIOS)
vehicle_mass = 1500;  % Mass of the vehicle in kg 車重
air_density = 1.225;  % Air density in kg/m^3 空氣密度
drag_coefficient = 0.3;  % Drag coefficient 車身牽引力
frontal_area = 2.2;  % Frontal area in m^2
rolling_resistance_coefficient = 0.015;  % Rolling resistance coefficient 輪胎摩擦力
gravity = 9.81;  % Acceleration due to gravity in m/s^2 地心引力
wheel_radius = 0.3; % Wheel radius in meters 輪胎半徑

% Fuel cell car parameters 燃料電池參數(簡易)
fuel_cell_efficiency = 0.6;  % Efficiency of the fuel cell 效率
electrical_losses = 0.1;  % Electrical losses as a fraction 電損係數

% Hydrogen engine car parameters 氫內燃機係數(簡易)
engine_efficiency = 0.4;  % Efficiency of the hydrogen engine 引擎效率
thermal_losses = 0.2;  % Thermal losses as a fraction 熱損
mechanical_losses = 0.1;  % Mechanical losses as a fraction 機械損

% Calculate tractive force 牽引力計算
tractive_force = vehicle_mass * gravity * rolling_resistance_coefficient + ...
    0.5 * air_density * drag_coefficient * frontal_area * (vehicle_speed / 3.6).^2;

% Calculate power required at wheels 輪胎驅動功率
wheel_power = tractive_force .* (vehicle_speed / 3.6);  % Power in watts

% Fuel cell car calculations 燃料電池計算
fc_power_input = wheel_power / fuel_cell_efficiency;  % 輸入功率
fc_electrical_losses = fc_power_input * electrical_losses;  % 電損
fc_required = fc_power_input + fc_electrical_losses; % 總消耗功率
fc_hydrogen_consumption = fc_power_input / (120 * 1e3); % Hydrogen consumption in kg/s (120 MJ/kg) H2 消耗
fc_efficiency = wheel_power / fc_required; % 效率 = 輸出 / 總消耗功率

% Hydrogen engine car calculations 氫引擎計算
he_power_input = wheel_power / engine_efficiency;  % 輸入功率
he_thermal_losses = he_power_input * thermal_losses;  % 熱損
he_mechanical_losses = he_power_input * mechanical_losses; % 機械損
he_required = he_power_input + he_thermal_losses + he_mechanical_losses; % 總消耗功率
he_hydrogen_consumption = he_power_input / (120 * 1e3); % Hydrogen consumption in kg/s (120 MJ/kg) H2 消耗
he_efficiency = wheel_power / he_required; % 效率 = 輸出 / 總消耗功率

% Accumulate data over time 累積耗氫計算
cumulative_fc_hydrogen = cumtrapz(time, fc_hydrogen_consumption); % 燃料電池
cumulative_he_hydrogen = cumtrapz(time, he_hydrogen_consumption); % 氫內燃機

% Plot hydrogen consumption 繪製耗氫曲線圖
figure;
subplot(2, 2, 1);
plot(time, fc_hydrogen_consumption, '-b', 'DisplayName', 'Fuel Cell Car');
hold on;
plot(time, he_hydrogen_consumption, '-r', 'DisplayName', 'Hydrogen Engine Car');
xlabel('Time (s)');
ylabel('Hydrogen Consumption (kg/s)');
title('Hydrogen Consumption vs. Time (FTP-75)');
legend('show');

% Plot losses 繪製損失曲線圖
subplot(2, 2, 2);
plot(time, fc_electrical_losses, '-b', 'DisplayName', 'Fuel Cell Car Losses');
hold on;
plot(time, he_thermal_losses + he_mechanical_losses, '-r', 'DisplayName', 'Hydrogen Engine Car Losses');
xlabel('Time (s)');
ylabel('Losses (W)');
title('Losses vs. Time (FTP-75)');
legend('show');

% Plot Efficiency 繪效率曲線圖
subplot(2, 2, 3);
plot(time, fc_efficiency, '-b', 'DisplayName', 'Fuel Cell Car Efficiency');
hold on;
plot(time, he_efficiency, '-r', 'DisplayName', 'Hydrogen Engine Car Efficiency');
xlabel('Time (s)');
ylabel('Efficiency');
title('Efficiency vs. Time (FTP-75)');
legend(['Fuel Cell Car Efficiency', 'Hydrogen Engine Car Efficiency'], 'show');

% Plot cumulative hydrogen consumption 繪製耗氫累積圖
subplot(2, 2, 4);
plot(time, cumulative_fc_hydrogen, '-b', 'DisplayName', 'Fuel Cell Car');
hold on;
plot(time, cumulative_he_hydrogen, '-r', 'DisplayName', 'Hydrogen Engine Car');
xlabel('Time (s)');
ylabel('Cumulative Hydrogen Consumption (kg)');
title('Cumulative Hydrogen Consumption vs. Time (FTP-75)');
legend('show');

% Adjust figure properties
set(gcf, 'Color', 'w');
