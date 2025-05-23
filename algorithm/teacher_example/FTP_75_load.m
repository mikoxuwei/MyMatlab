% 參數 % Parameters for the FTP-75 cycle
m = 1850.2;     % Vehicle mass (kg)
g = 9.81;       % Gravitationa_ acceleration（m/s^2）
A_f = 2.2;      % Frontal area (m^2) (estimated for a midsize car)
C_d = 0.29;     % Drag coefficient (estimated for a midsize car)
C_r = 0.01;     % Rolling resistance coefficient
rho = 1.225;    % Air density (kg/m^3)

% Load FTP-75 speed data from text file (1st column is time, 2nd clumn is vehicle speed in km/h)
data_file = 'ftp75_speed.txt';   % Make sure the file is in the working directory
data = readmatrix(data_file);    % 預備儲存資料的空矩陣
time = data(:, 1);               % Time in seconds 模擬時間(第1列, 依照數據量決定)
vechicle_speed_kmh = data(:, 2); % Vehicle speed in km/h (第2列, 車速)

% Convert vechicle speed from km/h to m/s (車速單位轉換從 km/h 到 m/s)
vechicle_speed_mps = vechicle_speed_kmh * (1000 / 3600);

% Pre-allocate power vector 儲存車輛負載需求變化的陣列
P_load = zeros(length(time), 1);

% Main loop to calculate load at each time step
for i = 1 : length(time)
    v = vechicle_speed_mps(i); % Vehicle speed at current time (m/s)

    % Forces acting on the vehicle
    F_drag = 0.5 * rho * A_f * C_d * v^2;  % Aerodynamic drag force (N) (空阻)
    F_rolling = C_r * m * g;               % Rolling resistance force (N) (滾動摩擦力)

    if i == 1
        a = 0;   % No acceleration at the stars % 起步加速度 = 0
    else
        a = (vechicle_speed_mps(i) - vechicle_speed_mps(i - 1)) / (time(i) - time(i - 1)); % Acceleration (m/s^2)
    end
    F_inertia = m * a;   % Inertial force (N) (慣性力) 可作為煞車再生數據

    % Total force acting on the vehicle
    F_total = F_drag + F_rolling + F_inertia; % 動力需求 = 加總所有阻力

    % Power required to overcone total force (P = F * v) % 隨車速變化之功率需求
    P_load(i) = F_total * v;
end

% Convert power to kilowatts (kW) % 轉換成千瓦
P_load_kW = P_load / 1000;

% Plot the FTP-75 load profile 畫出功率需求曲線
figure;
plot(time, P_load_kW);
title('FTP-75 Load Profile');
xlabel('Time(s)');
ylabel('Power Required (kW)');

% Save the load profile to a file (optional) 儲存
save('ftp75_load_profile.mat', 'time', 'P_load_kW');


