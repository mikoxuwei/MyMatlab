% 設定垂直式風機參數
rho = 1.225; % 空氣密度
A = 1.06 * 1.24; %風機葉片掃過面積
eta = 0.3; % 效率
R = 1.24/2; % 風機半徑
lambda = 4; % 尖速比

% 
torque = zeros(size(windSpeeds));
rotationalSpeed = zeros(size(windSpeeds));
power = zeros(size(windSpeeds));

% 計算每小時之轉矩，轉速和輸出功率
for k = 1:length(windSpeeds)
    v = windSpeeds(k)*300/550;

    torque(k) = 0.5 * rho * A * v^3 * eta;
    rotationalSpeed(k) = lambda * v / R;
    power(k) = torque(k) * rotationalSpeed(k);
end

% 
hours = 0:23;

%Plot the
figure(1);
plot(hours, torque, '-o', 'LineWidth', 1, 'MarkerSize', 6);
title('Output Tourque', 'FontSize', 10);
xlabel('Hour of the Day', 'FontSize', 10);
ylabel('Torque (Nm)', 'FontSize',10);
grid on;
set(gca, 'Fontsize', 10);
set(gca, 'Xtick', 0:23);
xlim([0 23]);

%Plot the
figure(2);
plot(hours, rotationalSpeed, '-o', 'LineWidth', 1, 'MarkerSize', 6);
title('Rotational Speed', 'FontSize', 10);
xlabel('Hour of the Day', 'FontSize', 10);
ylabel('Rotational Speed(rad/s)', 'FontSize',10);
grid on;
set(gca, 'Fontsize', 10);
set(gca, 'Xtick', 0:23);
xlim([0 23]);

%Plot the
figure(3);
plot(hours, power, '-o', 'LineWidth', 1, 'MarkerSize', 6);
title('Output power', 'FontSize', 10);
xlabel('Hour of the Day', 'FontSize', 10);
ylabel('power (W)', 'FontSize',10);
grid on;
set(gca, 'Fontsize', 10);
set(gca, 'Xtick', 0:23);
xlim([0 23]);

