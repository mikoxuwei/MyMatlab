P = 4; % 四極感應機
f = 60;
s = 0.05; %
Pout = 10; % (hp)

% a) The synchronous speed of this motor % 馬達的同步轉速
nsys = 120 * f / P;
disp(['nsys=', num2str(nsys), 'r/min']);

% b） The rotor speed of the motor % 馬達轉子轉速
nm = (1 - s) * nsys;
disp(['nm=', num2str(nm), ' r/min']);

% c) The rotor frequency of this motor
fre = s * f;
disp(['fre=', num2str(fre), ' Hz']); %轉子感應頻率

% d) The shaft load torque % 軸輸出轉矩
Tload = Pout * 746 / (nm * 2 * pi * 1 / f);
disp(['Tload=', num2str(Tload), ' nt-m']);

% e) shaft load torque in English units 將軸轉矩由公制轉為英制單位
Tload_E = 5252 * Pout / nm;
disp(['Tload_E=', num2str(Tload_E), ' lb-ft']);