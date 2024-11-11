% 系統參數
P_load = 90e3; % 負載功率，W (90kW)
PF = 0.80; % 功率因數 (滯後)
V_load = 2300; % 負載電壓，V

% 變壓器的電壓轉換比為 14 kV / 2.4 kV
V_LV = 2.4e3; % 低壓側電壓，V (2.4kV)
V_HV = 14e3; % 高壓測電壓，V (14kV)

% 計算負載電流
I_load = P_load / (V_load * PF); % 負載電流 (複數)
theta = acos(PF); % PF = cos(theta)
I_load = I_load * (cos(theta) - 1j * sin(theta)); % 複數形式
% disp(['I_load = ', num2str(real(I_load)), ' + j', num2str(imag(I_load))]);
[theta, I_load_deg] = cart2pol(real(I_load), imag(I_load));
% disp(['I_load = ', num2str(I_load_deg), ' /_', num2str(theta * 180/pi)]);

% 一次側 高壓側 供電端
% 二次側 低壓側 負載端

% 變壓器等效阻抗 (低壓側) 低壓側的等效阻抗
Z_tr = 0.10 + 1j * 0.40;
% 饋電線阻抗
Z_line = 38.2 + 1j * 140;

% 將高壓側的阻抗轉換到低壓側 Zline' = Z_line_LV
a = V_LV / V_HV; % Vp / Vs turns_ratio
Z_line_LV = Z_line * a^2;
% disp(['Z_line_LV = ', num2str(real(Z_line_LV)), ' + j', num2str(imag(Z_line_LV))]);

% (a)
V_s = V_load; % 負載端電壓，單位為伏特

% 計算二次側的等效源電壓 V_source' = V_source_LV
V_source_LV = V_s + I_load * Z_line_LV + I_load * Z_tr;
% disp(['V_source_LV = ', num2str(real(V_source_LV)), ' + j', num2str(imag(V_source_LV))]);

% 計算源電壓 V_source
V_source = V_source_LV / a;
[theta_source, V_source_deg] = cart2pol(real(V_source), imag(V_source));
% disp(['V_source = ', num2str(V_source_deg), ' /_', num2str(theta_source * 180/pi)]);

% 顯示結果
fprintf('(a) 電源端電壓 V_source: %.2f V\n', abs(V_source));

% (b)
% 一次側的端電壓 V_primary
V_p = V_s + I_load * Z_tr;
[theta_p, V_p] = cart2pol(real(V_p), imag(V_p));
% disp(['V_p = ', num2str(V_p), ' /_', num2str(theta_p * 180/pi)]);
% 電壓調整率計算
V_regulation = (abs(V_p) - abs(V_s)) / abs(V_s) * 100;
fprintf('(b) 變壓器的電壓調整率: %.2f%%\n', V_regulation);

% (c)
% 計算系統效率
P_out = P_load;
I_p = I_load_deg * a;
% 線路損耗
P_loss_line = I_p^2 * real(Z_line);
% 變壓器損耗
P_loss_transformer = I_load_deg^2 * real(Z_tr);
P_loss = P_loss_line + P_loss_transformer;
P_in = P_out + P_loss;
efficiency = (P_out / P_in) * 100;
fprintf('(c) 系統效率: %.2f%%\n', efficiency);