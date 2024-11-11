% 先清乾淨之前的圖?
clear;
close all;

% 一天的風速變化
windSpeeds = [3.5 4.0 3.8 4.2 4.5 5.0 6.0 7.2 8.5 7.8 6.5 5.5 , ... 
    4.8 4.5 5.2 6.0 7.5 8.0 7.2 6.8 5.5 4.2 3.8 3.5];

% Create an array for the hour of the day
hours = 0 : 23;

figure;

plot(hours, windSpeeds, '-o', 'LineWidth', 2, 'MarkerSize', 6);

% Add title and axis labels
title('Wind Speeds over 24 Hours in a Day of March 2023', 'FontSize', 10);
xlabel('Hour of the Day', 'FontSize', 10);
ylabel('Wind Speed (m/s)', 'FontSize', 10);

% Adjust the axis limits
xlim([0 23]);
ylim([0 max(windSpeeds) + 1]);

% Add grid for better visualization
grid on;

% Optionally, customize the appearance
set(gca, 'FontSize', 12);
set(gca, 'XTick', 0 : 23);
set(gca, 'YTick', 0 : 1 : max(windSpeeds) + 1);

% Optionally, add annotations or data tips
for k = 1 : length(hours)
    text(hours(k), windSpeeds(k), sprintf('%.1f', windSpeeds(k)), ...
        'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');
end

% Adjust figure properties
set(gcf, 'Color', 'w');