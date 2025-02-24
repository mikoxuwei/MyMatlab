% MATLAB Program to Plot Wind Speeds over 24 Hours in a Day of March 2023 and Calculate Average

% Clear workspace and close all figures
clear;
close all;

% Sample wind speed data for 24 hours (replace with your actual data)監測數據
windSpeeds = [3.5, 4.0, 3.8, 4.2, 4.5, 5.0, 6.0, 7.2, 8.5, 7.8, 6.5, 5.5, ...
              4.8, 4.5, 5.2, 6.0, 7.5, 8.0, 7.2, 6.8, 5.5, 4.2, 3.8, 3.5];

% Calculate the average wind speed 平均風速計算
averageWindSpeed = mean(windSpeeds);

% Display the average wind speed 顯示平均風速在command window
fprintf('The average wind speed for the day is %.2f m/s.\n', averageWindSpeed);

% Create an array for the hours of the day 建立一日數據庫
hours = 0:23;

% Create a figure for the line chart
figure;

% Plot the wind speed data 繪出數據曲線
plot(hours, windSpeeds, '-o', 'LineWidth', 1, 'MarkerSize', 6);

% Add title and axis labels
title('Wind Speeds over 24 Hourrs in a Day of March 2023', 'FontSize', 10);
xlabel('Hour of the Day', 'FontSize', 10);
ylabel('Wins Speed (m/s)', 'FontSize', 10);

% Adjust the axis limit 調整XY軸範圍
xlim([0 23]);
ylim([0 max(windSpeeds) + 1]);

% Add girs for better visualization 加上網格
grid on;

% Optionally, customize the appearance 找出最大值
set(gca, 'FontSize', 10);
set(gca, 'XTick', 0:23);
set(gca, 'YTick', 0:1:max(windSpeeds) + 1);

% Optionally, add annotations or data tips 加上各點數據於曲線上
for k = 1:length(hours)
    text(hours(k), windSpeeds(k), sprintf('%.1f', windSpeeds(k)), ... 
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');
end

% Add a houizontal line to insicate the average wind speed 畫出平均風力線
hold on;
yline(averageWindSpeed, '--b', 'LineWidth',1);
text(0, averageWindSpeed, sprintf('Avg: %.2f m/s', averageWindSpeed), ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'b');

% Adjust fiugre properties
set(gcf, 'Color', 'w');

