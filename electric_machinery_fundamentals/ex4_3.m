VT = 480; % 無載電壓 = 電樞電壓
P = 6; % 極數
fse = 50; % 頻率 (Hz)
Xs = 1.0; % 同步反應電抗
IA = 60 * exp(1j * deg2rad(-36.87)); % 負載電流 % 0.8落後時的電樞電流
EA = 277; % 感應電動勢 % 相電壓
Pelec = 0; % 電氣功率
Pcore = 1000; % 鐵損功率
Pmech = 1500; % 機械損功率

nm = 120 * fse / P; % 同步速度 (rpm) 同步轉速
disp(['nm = ', num2str(nm), ' rpm']); % 顯示同步速度
wm = nm / 60 * 2 * pi; % 角速度 (rad/s)
disp(['wm = ', num2str(wm), ' rad/s']); % 顯示角速度

jXsIA = 1i * IA; % 電書電抗壓降
disp(['jXsIA = ', num2str(abs(jXsIA)), ' V ', '∠', num2str(rad2deg(angle(jXsIA))) '°']); % 顯示 jXsIA

Vf1 = sqrt(EA^2 - (Xs * abs(IA) * cos(conj(angle(IA))))^2) + Xs * abs(IA) * sin(conj(angle(IA))); % 端電壓0.8落後
disp(['Vf1 = ', num2str(Vf1), ' V']);
VT1 = sqrt(3) * Vf1; % Y接線電壓
disp(['VT1 = ', num2str(VT1), ' V']);

Vf2 = sqrt(EA^2 - (Xs * abs(IA)^2)); % 端電壓(1.0純電阻負載)
disp(['Vf2 = ', num2str(Vf2), ' V']);
VT2 = sqrt(3) * Vf2; % Y接線電壓
disp(['VT2 = ', num2str(VT2), ' V']);

Vf3 = sqrt(EA^2 - (Xs * abs(IA) * cos(conj(angle(IA))))^2) - Xs * abs(IA) * sin(conj(angle(IA))); % 端電壓0.8超前
disp(['Vf3 = ', num2str(Vf3), ' V']);
VT3 = sqrt(3) * Vf3; % Y接線電壓
disp(['VT3 = ', num2str(VT3), ' V']);


Pout = 3 * Vf1 * abs(IA) * cos(conj(angle(IA))); % 輸出功率 
disp(['Pout = ', num2str(Pout), ' W']); 

Pin = Pout + Pelec + Pcore + Pmech; % 輸入功率(來自原動機的機械功率)
disp(['Pin = ', num2str(Pin), ' W']);  

eff = Pout / Pin * 100; 
disp(['eff = ', num2str(eff), ' %']); % 效率 


%%
fse = 60;
nm = 120 * fse / P; % 同步速度 (rpm) 同步轉速(60Hz)
disp(['nm = ', num2str(nm), ' rpm']); % 顯示同步速度
wm = nm / 60 * 2 * pi; % 角速度 (rad/s)
disp(['wm = ', num2str(wm), ' rad/s']); % 顯示角速度

disp(['Tapp = ', num2str(Pin/wm), 'N.m']); % 視在轉矩(來自原動機)
disp(['Tind = ', num2str(Pout/wm), 'N.m']); % 內生轉矩(感應)轉矩

% 計算電壓調整率 
VR1 = (VT - VT1) / VT1 * 100; 
disp(['VR = ', num2str(VR1), ' %']); % 轉差率(0.8落後)
% 額外電壓調整率計算 
VR2 = (VT - VT2) / VT2 * 100; 
disp(['VR2 = ', num2str(VR2), ' %']);% 轉差率(1.0)
VR3 = (VT - VT3) / VT3 * 100; 
disp(['VR3 = ', num2str(VR3), ' %']);% 轉差率(0.8超前)