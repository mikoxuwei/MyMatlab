% MATLAB Program to Plot Wind Speeds over 24 Hours in a Day of March 2023 and Calculate Average

% Clear workspace and close all figures
clear;
close all;

% 監測數據
windSpeeds = [3.5, 4.0, 3.8, 4.2, 4.5, 5.0, 6.0, 7.2, 8.5, 7.8, 6.5, 5.5, ...
              4.8, 4.5, 5.2, 6.0, 7.5, 8.0, 7.2, 6.8, 5.5, 4.2, 3.8, 3.5];

%
averageWindSpeed = mean(windSpeeds);

%
fprintf('The average wind speed for the day is %.2f m/s.\n', averageWindSpeed);

% 
hours = 0:23;

% 
figure;

% Plot
plot(hours, windSpeeds, '-o', 'LineWidth', 1, 'MarkerSize', 6);

% Add 
title('Wind Speeds over 24 Hourrs in a Day of March 2023', 'FontSize', 10);
xlabel('Hour of the Day', 'FontSize', 10);
ylabel('Wins Speed (m/s)', 'FontSize', 10);

% Adjust
xlim([0 23]);
ylim([0 max(windSpeeds) + 1]);

% Add
grid on;

% Optionally,
set(gca, 'FontSize', 10);
set(gca, 'XTick', 0:23);
set(gca, 'YTick', 0:1:max(windSpeeds) + 1);

% add
for k = 1:length(hours)
    text(hours(k), windSpeeds(k), sprintf('%.1f', windSpeeds(k)),...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');
end

% Add
hold on;
yline(averageWindSpeed, '--b', 'LineWidth',1);
text(0, averageWindSpeed, sprintf('Avg: %.2f m/s', averageWindSpeed), ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'b');

% Adjust
set(gcf, 'Color', 'w');

