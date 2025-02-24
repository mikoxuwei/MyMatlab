VL = 480; % 無限匯流排端電壓
P1 = 100; % 感應馬達1 所需實功率
P2 = 200; % 感應馬達2 所需實功率
P3 = 150; % 同步馬達所需實功率
pf1 = 0.78; % 感應馬達1 負載功率因數
pf2 = 0.8; % 感應馬達2 負載功率因數
k = 1000;

% a) If the synchronous motor is adjusted to operate at 0.85 PF lagging
% 當同步馬達的功率因數為 0.85 落後
pf3 = 0.85;
Q1 = P1 * tan(acos(pf1)); % 感應馬達1 所需虛功率
disp(['Q1=', num2str(Q1), 'kVAR']);
Q2 = P2 * tan(acos(pf2)); % 感應馬達2 所需虛功率
disp(['Q2=', num2str(Q2), 'kVAR']);
Q3 = P3 * tan(acos(pf3)); % 同步馬達所需虛功率
disp(['Q3=', num2str(Q3), 'kVAR']);
Ptot = P1 + P2 + P3; % 總實功
disp(['Ptot=', num2str(Ptot), 'kW']);
Qtot = Q1 + Q2 + Q3; % 總虛功
disp(['Qtot=', num2str(Qtot), 'kVAR']);
pf = cos(atan(Qtot/Ptot)); % 總負載功率因數
disp(['pf=', num2str(pf), ' lagging']);
IL1 = Ptot * k / (sqrt(3) * VL * pf); % 輸電線電流
disp(['IL=', num2str(IL1), ' A']);

% b） If the synchronous motor is adjusted to operate at -0.85 PF 1agging
% 當同步馬達的功率因數為0.85超前時

Q3 = P3 * tan(-acos(pf3));
disp(['Q3=', num2str(Q3), ' KVAR']); % 同步馬達所供應虛功率
Ptot = P1 + P2 + P3; % 總實功
disp(['Ptot=', num2str(Ptot), 'kW']);
Qtot = Q1 + Q2 + Q3; %總虛功
disp(['Qtot=', num2str(Qtot), 'kVAR']);
pf = cos(atan(Qtot/Ptot)); % 總負載功率因數
disp(['pf=', num2str(pf), ' lagging']);
IL2 = Ptot * k / (sqrt(3) * VL * pf); % 輸電線電流
disp(['IL=', num2str(IL2), ' A']);

% c) Assume that the transmission line losses are given by PLL = 3IL^2/RL
% compare tranmission loss
com = ((IL1^2) - (IL2^2)) / (IL1^2);
disp(['Loss comparison = ', num2str(com * 100), ' %'])