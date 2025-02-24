% Input torque and rotational speed data
torque_data = [1.3 0.9 1.1 1.7 2.5 3.6 6.5 8.5 12.3 14.6 10.8 6.5 3.6 2.9 4.3 6.5 9.3 13.4 16.5 12.3 7.6 3.6 2.2 1.3];
rotational_speed_data = [11.3 9.9 10.6 12.3 14.1 15.8 19.4 21.1 23.9 25.3 22.9 19.4 15.8 14.8 16.9 19.4 21.8 24.6 26.4 23.9 20.4 15.8 13.4 11.3];

% Constants for the ENGELEC 1000W 300RPM Maglev PM generator (ENP-1K- 300R)
% 發電機data
rated_power = 1000; % Rated power in watts
max_rotational_speed = 300 * (2 * pi / 60); % Maximum rotational speed in rad/s 最大轉速
max_torque = 31.83; % 最大功率

% Calculate power output based on torque and rotational speed
% 計算發電機輸出標么值pu.(需小於額定值Max)
power_output = min(torque_data, max_torque) .* min(rotational_speed_data, max_rotational_speed) .* rated_power / (max_torque * max_rotational_speed);

% Calculate the average wind speed
averagePower = mean(power_output);

% Display the average wind speed 顯示在command window
fprintf('The average power output is %.2f m/s. \n', averagePower);

% Create an array for the hours of the day 建立時間陣列
hours= 0:23;

% plot the power output 繪出輸出功率曲線
figure;  
plot(hours, power_output, '-o', 'LineWidth', 1, 'MarkerSize', 6);
title('Power Output', 'FontSize', 10);
xlabel('Hour of the Day', 'FontSize', 10);  % 標示X軸名稱和單位
ylabel('Power Output (W)', 'FontSize', 10);  % 標示Y軸名稱和單位
grid on;
set(gca, 'FontSize', 10);
set(gca, 'XTick', 0:23);
xlim([0 23]); % 設定X軸刻度(0-23)

% Optionally, add annotations or data tips 加上24點數據於曲線上
for k = 1:length(hours)
    text(hours(k), power_output(k), sprintf('%.1f', power_output(k)), ... 
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');
end

% Add a houizontal line to insicate the average wind speed 畫出平均風力線
hold on;
yline(averagePower, '--b', 'LineWidth',1);
text(0, averagePower, sprintf('Avg: %.2f m/s', averagePower), ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'b');

% Adjust fiugre properties
set(gcf, 'Color', 'w');