OP = 15; % 初始負載
VT = 208;
Xs = 2.5i; % 同步電抗
pf = 0.8;
Pmech = 1.5; % 機械損
Pcore = 1.0;
k = 1000;

% The corresponding output
Pout = OP * 0.746;
disp(['Pout = ', num2str(Pout), ' kW']); % 初始輸出功率
Pin = Pout + Pmech + Pcore;
disp(['Pin = ', num2str(Pin), ' kW']); % 總功率需求
IL = Pin * k / (sqrt(3) * VT * pf);
disp(['IL = ', num2str(IL), ' A']); % 線電流
IA = IL / sqrt(3);
disp(['IA = ', num2str(IA), '/_', num2str(rad2deg(acos(pf)))]); % 相電流
EA = VT - Xs * IA * exp(1j*acos(pf));
disp(['EA = ', num2str(abs(EA)), '/_', num2str(rad2deg(angle(EA))), ' V']); % 內生電樞電壓

% (c) After the load changes
newOP = 30; % 負載 = 30hp
Pin = newOP * 0.746 + Pmech + Pcore; % 總功率需求
disp(['Pin = ', num2str(Pin), ' kW']);
delta = asin(abs(Xs)*Pin*k/(3 * VT * abs(EA)));
disp(['delta = ', num2str(rad2deg(delta))]);
% EA=255/_-23 % 内生電樞電壓=255/_-23
EA = 255 * exp(1j*deg2rad(-23));
IA = (VT - EA) / Xs;
disp(['IA = ', num2str(IA), '/_', num2str(rad2deg(angle(IA))), ' A']);
IL = sqrt(3) * abs(IA);
disp(['IL = ', num2str(IL), ' A']);
