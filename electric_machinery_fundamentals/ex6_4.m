P = 2; % 極數
f = 50; % 頻率
Pconv = 15000; % 轉子內生功率
nm = 2950;

% a) motor's slip 轉差率計算
nsync = 120*f/P; % 同步轉速
disp(['nsync=', num2str(nsync), ' rpm' ]);

% motor's slip 轉差
s=(nsync-nm)/nsync;
disp(['s=', num2str(s*100), ' %']);

% b) induced torque 感應轉矩
Tind=Pconv/ (nm*2*pi/60); % 感應轉矩 = 內生功率 / 轉速(徑度)
disp(['Tind=', num2str(Tind), ' Nt-m']) ;

% c) the operating speed of the motor be if its torque is doubled
% 計算當2倍轉矩生成時之轉速?
nm= (1-s*2) *nsync; % 假設轉矩和轉差成正比 -> 轉速 = (1-2倍轉差 * 同步轉速)
disp(['nm=', num2str(nm), ' rpm' ]);

% d) power supplied by the motor when the torque is doubled
% 當2倍轉矩生成時之內生功率?
Pconv=2*Tind*nm*2*pi/60; % 內生功率 = 轉矩 / 轉速(徑度)
disp(['Pcony=', num2str(Pconv/1000), ' kW']);