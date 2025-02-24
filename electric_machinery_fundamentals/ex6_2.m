VT = 480; % 端子外接電壓
P = 50; % 負載
pf = 0.85; % 功率因數
IL = 60; % 輸入電流
PSCL = 2; % 定子銅損
Pcore = 1.8; % 鐵芯損
PRCL = 0.7; % 轉子銅損
PF_W = 0.6; % 摩擦 + 風損 
k = 1000;

% a) the air-gap power 氣隙傳遞功率計算
Pin = sqrt(3)*VT*IL*pf/k; % 輸入功率
disp(['Pin = ', num2str(Pin), ' kW']);
PAG = Pin - PSCL - Pcore; % 氣隙功率 = 定子銅損 - 鐵芯損
disp(['PAG = ', num2str(PAG), ' kW']);

% b) the power converted from electrical to mechancal from 轉子內生轉換功率
Pconv = PAG - PRCL; % 轉子轉換功率 = 氣隙功率 - 轉子銅損
disp(['Pconv = ', num2str(Pconv), ' kW']);

% c) the output power 輸出功率
Pout = Pconv - PF_W; % 輸出功率 = 轉子轉換功率 - (摩擦 + 風損)
disp(['Pout = ', num2str(Pout), ' kW']);
Pouth = Pout / 0.746; % 單位轉換 kW -> hp
disp(['Pouth = ', num2str(Pouth), ' hp']);

% d) the induction motor's efficiency 效率
ita = Pout / Pin * 100;
disp(['ita = ', num2str(ita), ' %']);