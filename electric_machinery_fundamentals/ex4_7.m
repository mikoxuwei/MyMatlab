Xs = 1.0;
Xtr = 0.25;
Xstr = 0.12;
Ttr = 1.10;
Tstr = 0.04;
Sbase = 100000; % 視在功率 = 100MA
EA = 1.0;
VL = 13.8; % 端電壓
f = 60; % 系統頻率

ILbase = Sbase / (sqrt(3) * VL); % 額定電流
disp(['ILbase=', num2str(ILbase), ' A']);
Istr = EA / Xstr * ILbase; % 次暫態電流
disp(['Istr=', num2str(Istr), ' A']);
Itr = EA / Xtr * ILbase; % 暫態電流
disp(['Itr= ', num2str(Itr), ' A']);
Iss = EA / Xs * ILbase; % 穗態電流
disp(['Iss = ', num2str(Iss), ' A']);
Itot = 1.5 * Istr; % 總電流 = AC + DC(DC 成分為故障發生後 AC 的 50 %)
disp(['Itot = ', num2str(Itot), ' A']);

% the total current at 2 cycles % 2 週期 = 1/60 * 2
I2cyc = (Istr - Itr) * exp(-(2 / f)/Tstr) + (Itr - Iss) * exp(-(2 / f)/Ttr) + Iss;
disp(['I2cyc = ', num2str(I2cyc), ' A']);
% the total current at 5s 故障發生後 5s
I5s = (Istr - Itr) * exp(-5/Tstr) + (Itr - Iss) * exp(-5/Ttr) + Iss;
disp(['I5s = ', num2str(I5s), ' A']);