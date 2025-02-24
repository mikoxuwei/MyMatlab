VT = 480;
Srated = 50000; % 視在功率
Xs = 1i;
Pmaxin = 45; % 元動機最大輸出功率
Pmechloss = 1.5; % 機械損
Pcoreloss = 1.0; % 銅損

Vf = VT / sqrt(3);
disp(['Vf = ', num2str(Vf), ' V']); %相電壓
IAmax = Srated / (3 * Vf);
disp(['IAmax = ', num2str(IAmax), ' A']); % 最大電樞電流


% (a) the center of the EA circles is
Q = 3 * Vf^2 / Xs;
disp(['Q = ', num2str(Q/1000), ' kVAR']); % 發電機虛功率
EA = Vf + Xs * 60 * exp(1j*deg2rad(-36.87)); % 發電機電福内生電壓
disp(['EA = ', num2str(abs(EA)), ' V', '/_', num2str(rad2deg(angle(EA)))]);
DE = 3 * abs(EA) * Vf / Xs; % 實供虛功
disp(['DE = ', num2str(abs(DE)/1000), ' kVAR']);

Pmaxout = Pmaxin - Pmechloss - Pcoreloss;
disp(['Pmaxout = ', num2str(Pmaxout), 'kW']); %最大輸出功率

% (b) A current of 56 A at 0.7 PF lagging produces power

IA = 56;
PF = 0.7;
Pg = 3 * Vf * IA * PF;
disp(['Pg = ', num2str(Pg/1000), ' KW']); % 輸出功率
Qg = 3 * Vf * IA * sin(acos(PF));
disp(['Qg = ', num2str(Qg/1000), 'kVAR']); % 輸出虛功率

% (c) When the real power supplied by the generator is zero, Pg = 0 當實功率 = 0
Qg = DE - Q;
disp(['Qg = ', num2str(abs(Qg)/1000), 'kVAR']); % 輸出虛功率


% (d) If the generator is supplying 30 kW of real power 當實功率=30kW
Pg = 30;
Qg = sqrt((abs(DE) / 1000)^2-Pg^2) - abs(Q) / 1000; %輪出虛功率