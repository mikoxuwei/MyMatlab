% Define the time range (24 houns)
time_hours = 0:23; % 24 points from e to 23 hours 以24筆電功率做一日模擬

% Define the power input for each hour (in Watts) 自發電機輸出
% Example: arbitrary power input values for each hour
power_input = [450, 460, 470, 480, 490, 500, 510, 520, 530, 540, 550, 560, ...
               570, 580, 590, 600, 610, 620, 630, 640, 650, 660, 670, 680];
% ---------------------------以上為電解槽輸入-----------------------------
% Convert power input to corresponding voltage 將輸入功率轉換成對應電壓
% Assume a linear relationship for simplicity: Voltage (V) = Power (W) / 1000
voltage_input = power_input / 1000;

% Optimal parameters from Taguchi's method 來自田口最佳化道電解槽參數
optimal_electrolyte_concentration = 0.25; % Example value 電解液濃度
optimal_electrode_distance = 10; % Example value ( cm) 電極距離

% Preallocate hydrogen production array 設定電解槽輪出（H2）的暫存器
hydrogen_production = zeros(1, length(time_hours)) ; 
% Calculate hydrogen production for each hour 電解槽產氫公式

for i = 1: length(time_hours)
    voltage = voltage_input(i);
    HPR = -22.41 + 21.88 * optimal_electrolyte_concentration + 16.11 * voltage + ...
        0.77 * optimal_electrode_distance - 7.18 * (optimal_electrolyte_concentration * voltage) + ...
        0.156 * (optimal_electrolyte_concentration * optimal_electrode_distance) + ...
        0.031 * (voltage * optimal_electrode_distance) - 12.58 * (optimal_electrolyte_concentration)^2 - ...
        3.30 * (voltage)^2 - 0.045 * (optimal_electrode_distance)^2;
    hydrogen_production(i) = HPR;
end

% Plot the results 繪圖
figure;
yyaxis left
plot (time_hours, hydrogen_production, '-o', 'LineWidth', 2);
xlabel('time (hours)');
ylabel('Hydrogen Production');
title('Hydrogen Prouction vs. Time for PEM Electrolyzer');
grid on;

% Plot powerr input on a seconarty y-axis
yyaxis right
plot (time_hours, power_input, '--', 'LineWidth', 1);
xlabel('time (hours)');
ylabel('Power Input(W)');
legend('Hydrogen Prouction ', 'Power Input');