% MATLAB Code for SOFC considering activation, ohmic, and concentration losses
clc;
clear;
close all;

% Constants and parameters
n_cells = 50;           % Number of cells in SOFC stack
Faraday = 96485;        % Faraday's constant (C/mol)
R = 8.314;              % Universal gas constant (J/mol·K)
T = 1000;               % Operating temperature (K)
E0 = 1.1;               % Open-circuit voltage (V)
time = 0:1:60;          % Time vector (1-minute duration with 1-second intervals)
A_cell = 100;           % Active area of each cell (cm^2)
i0_anode = 1e-5;        % Exchange current density (A/cm^2) for anode
i0_cathode = 1e-4;      % Exchange current density (A/cm^2) for cathode
sigma = 1e-2;           % Conductivity of electrolyte (S/cm)
L_electrolyte = 0.01;   % Electrolyte thickness(cm)
C_concentration = 0.5;  % Concentration polarization constant

% Generate random inputs for H2 and air flow rates 以亂數作為負載需求的輸入
H2_flow = 0.01 + 0.02 * rand(size(time)); % Random H2 flow rate in mol/s (0.01 to 0.03)
Air_flow = 0.1 + 0.2 * rand(size(time)); % Random air flow rate in mol/s (0.1 to 0.3)

% Calculate outputs
Fuel_utilization = H2_flow ./ max(H2_flow); % Normalized fuel utilization (0 to 1) 正規化燃料流率
I_cell = H2_flow * 2 * Faraday .* Fuel_utilization; % Total current (A) 輸出電流(公式)
i_cell = I_cell / A_cell; % Current density (A/cm^2) 電流密度
Electrical_power = I_cell * E0 * n_cells / 1000; % Electrical power (kW) 輸出功率(kW)

% Calculate losses
% Activation losses (Butler-Volmer equation simplification) 活化損失(公式)
V_activation = (R * T / (2 * Faraday)) .* log(i_cell./i0_anode+i_cell./i0_cathode);

% Ohmic losses 歐姆損失(公式)
V_ohmic = i_cell .* (L_electrolyte / sigma);

% Concentration losses 濃度損失(公式)
V_concentration = C_concentration * log(1./max(1-Fuel_utilization, 1e-3));

% Total losses 總損失(公式)
V_loss = V_activation + V_ohmic + V_concentration;

% Actual output voltage 實際輸出電壓
V_actual = E0 - V_loss;
Efficiency = Fuel_utilization .* V_actual / E0;

% Voltage variation with temperature 隨溫度變化之電壓
Temperature = linspace(600, 1000, length(time)); %600~1000度C的電壓變化
Voltage_with_temp = E0 - (R * Temperature / (2 * Faraday)) .* log(1./max(Fuel_utilization, 1e-3));

% Plotting results
figure;

% H2 Flow Rate vs. Time(H2流率vs時間)
subplot(2, 2, 1);
plot(time, H2_flow, 'b', 'LineWidth', 1.5);
xlabel('Time(s)');
ylabel('H_2 Flow Rate (mol/s)');
title('H_2 Flow Rate over Time');
grid on;

% Electrical Power Output over Time （輸出電功率vs時間）
subplot(2, 2, 2);
plot(time, Electrical_power, 'g', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Electrical Power (kW)');
title('Electrical Power over Time');
grid on;

% Output Voltage over Time （輸出電壓vs時間）
subplot(2, 2, 3);
plot(time, V_actual, 'r', 'LineWidth', 1.5);
xlabel('Time (s) ');
ylabel('Output Voltage(V)');
title('Output Voltage over Time');
grid on;

% Fuel Utilization vs. Efficiency （燃料消耗vs時間）
subplot(2, 2, 4);
plot(Fuel_utilization, Efficiency, 'K', 'LineWidth', 1.5);
xlabel('Fuel Utilization');
ylabel('Efficiency');
title('Fuel Utilization vs. Efficiency');
grid on;

% Display results
sgtitle('SOFC Performance Considering Losses');