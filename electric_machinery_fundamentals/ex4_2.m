P = 4;
f = 60;
Vph = 480; % 相電壓 (V)
RA = 0.015;
IL = 1200;
deg_sign = char(0176);

% 求轉速
nm = 120 * f / P;
disp(['nm = ', num2str(nm),' rpm']);

IA = 1200 / sqrt(3); % 相電源
disp(['IA = ', num2str(IA), ' A']);
EA = 480 + RA * IA * exp(1j * deg2rad(-36.87)) + 0.1i * IA * exp(1j * deg2rad(-36.87)); % 電樞電壓 0.8 落後
disp(['EA = ', num2str(abs(EA)), ' V ', '/_', num2str(rad2deg(angle(EA))), deg_sign]);

% 計算輸出功率
Pout = sqrt(3) * Vph * IL * cos(deg2rad(36.87)); % 輸出功率 (W)
disp(['Pout = ', num2str(Pout), ' W']);

% 計算損失功率
Peloss = 3 * IA^2 * RA; % 三項銅損失 損失功率 (W)
disp(['Peloss = ', num2str(Peloss), ' W']);

% 計算輸入功率
Pin = Pout + Peloss + 30000 + 40000; % 輸入功率 (W) = 輸入 + 銅損 + 鐵芯損 + 機械損
disp(['Pin = ', num2str(Pin), ' W']);

% 計算效率
eff = 100 * Pout / Pin; % 效率 (%)
disp(['etha = ', num2str(eff), ' %']);

% 額外輸出電壓計算
EA = 480 + RA * IA * exp(1j * deg2rad(36.87)) + 0.1i * IA * exp(1j * deg2rad(36.87)); % 電樞電壓 0.8 超前
disp(['EA = ', num2str(abs(EA)), ' V ', '/_', num2str(rad2deg(angle(EA))), deg_sign]);

