% Constants for the DS03-S000-00-2 VAWT 設定垂直式風機參數
rho= 1.225; % Air density in kg/m^3 空氣密度
A= 1.06*1.24; % Swept area in m^2 (example value, replace with actual) 風機葉片掃過面積
eta= 0.3; % Efficiency (example value, replace with actual) 效率
R= 1.24/2; % Radius of the turbine in meters (example value, replace with actual) 風機半徑
lambda= 4;  % Tip-speed ratio (example value, replace with actual) 間速比

% Sample wind speed data for 24 hours (replace with your actual data)監測數據
windSpeeds = [3.5, 4.0, 3.8, 4.2, 4.5, 5.0, 6.0, 7.2, 8.5, 7.8, 6.5, 5.5, ...
              4.8, 4.5, 5.2, 6.0, 7.5, 8.0, 7.2, 6.8, 5.5, 4.2, 3.8, 3.5];

% Initialize arrays for torque, rotational speed, and power 初始化轉矩、轉速和輸出功率的矩陣
torque= zeros(size(windSpeeds));
rotationalSpeed= zeros(size(windSpeeds));
power= zeros(size(windSpeeds));

% Calculate torque, rotational speed, and power for each hour 計算每小時之轉矩、轉速和輸出功率
for k= 1:length(windSpeeds)
    v= windSpeeds(k)*300/500;  % 轉換風速單位(m/s)成(rad/s)
    torque(k)= 0.5 * rho * A * v^3 * eta;  % 轉矩公式
    rotationalSpeed(k) = lambda * v / R;
    power(k)= torque(k) * rotationalSpeed(k);  % 功率公式
end

% Create an array for the hours of the day 建立時間陣列
hours= 0:23;

% Plot the torque data 
% --------以下為轉矩、轉速和輸出功率的繪圖設定--------
figure(1);  % Fig.1 為輸出轉矩
plot(hours, torque, '-o', 'LineWidth', 1, 'MarkerSize', 6);
title('Output Torque', 'FontSize', 10);
xlabel('Hour of Day', 'FontSize', 10);  % 標示X軸名稱和單位
ylabel('Torque (Nm)', 'FontSize', 10);  % 標示Y軸名稱和單位
grid on;
set(gca, 'FontSize', 10);
set(gca, 'XTick', 0:23);
xlim([0 23]);

% Plot the rotational speed data
figure(2);  % Fig.2 為輸出轉速
plot(hours, rotationalSpeed, '-o', 'LineWidth', 1, 'MarkerSize', 6);
title('Rotational Speed', 'FontSize', 10);
xlabel('Hour of Day', 'FontSize', 10);  % 標示X軸名稱和單位
ylabel('Rotational (Rad/s)', 'FontSize', 10);  % 標示Y軸名稱和單位
grid on;
set(gca, 'FontSize', 10);
set(gca, 'XTick', 0:23);
xlim([0 23]);

% plot the power output data
figure(3);  % Fig.3 為輸出功率
plot(hours, power, '-o', 'LineWidth', 1, 'MarkerSize', 6);
title('Power Output', 'FontSize', 10);
xlabel('Hour of Day', 'FontSize', 10);  % 標示X軸名稱和單位
ylabel('Power (W)', 'FontSize', 10);  % 標示Y軸名稱和單位
grid on;
set(gca, 'FontSize', 10);
set(gca, 'XTick', 0:23);
xlim([0 23]);


%%%--------------------------

% Display the average torque, rotationalspeed, and power
averageTorque = mean(torque); % 平均轉速
averageRotationalSpeed = mean(rotationalSpeed); % 平均轉速
averagePower = mean(power); % 平均功率

fprintf('The average toraue for the day is %.2f Nm.\n', averageTorque);
fprintf('The average rotational speed for the day is %.2f rad/s.\n', averageRotationalSpeed);
fprintf('The average power for the day is %.2f W.\n', averagePower);

% Optionally, add annotations or data tips 將上面的24個計算結果（小數點以下1位）顯示在圖形中
for k = 1:length(hours)
    figure(1); % 轉矩
    text(hours(k), torque(k), sprintf('%.1f', torque(k)), ... 
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');
    
    figure(2); % 轉速
    text(hours(k), rotationalSpeed(k), sprintf('%.1f', rotationalSpeed(k)), ... 
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');
    
    figure(3); % 功率
    text(hours(k), power(k), sprintf('%.1f', power(k)), ... 
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');
end


% Add a horizontal line to indicate the average Torque 畫出平均線
hold on;
figure(1);
yline(averageTorque, '--b', 'LineWidth', 1);
text(0, averageTorque, sprintf('Avg: %.2f Nm.\n', averageTorque), ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'b');

% Add a horizontal line to indicate the average Torque 畫出平均線
hold on;
figure(2);
yline(averageRotationalSpeed, '--b', 'LineWidth', 1);
text(0, averageRotationalSpeed, sprintf('Avg: %.2f m/s.\n', averageRotationalSpeed), ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'b');

% Add a horizontal line to indicate the average Torque 畫出平均線
hold on;
figure(3);
yline(averagePower, '--b', 'LineWidth', 1);
text(0, averagePower, sprintf('Avg: %.2f W.\n', averagePower), ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', 'b');
