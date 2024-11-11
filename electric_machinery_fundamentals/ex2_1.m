V = 480 +0i;
zline = 0.18 + 0.24i;
zload = 4 + 3i;
rline = 0.18;
a = 10;

% calculate line current Iline 輸電線的電流
Iline = V / (zline + zload);
disp(['Iline= ', num2str(abs(Iline)), '/_' num2str(angle(Iline) * 180/pi), 'A']);

% calculate load voltage
Vload = Iline * zload;
disp(['Vload= ', num2str(abs(Vload)), '/_' num2str(angle(Vload) * 180/pi), 'V']);

Ploss = (Iline)^2 * rline;
disp(['Ploss= ', num2str(abs(Ploss)), 'W']);

% calculate the total impedance at the transmission line level
zload = a^2 * zload;
zeq = zline + zload;
disp(['zeq= ', num2str(abs(zeq)), '/_' num2str(angle(zeq) * 180/pi), 'Ohm']);

% calculate the generator current IG
zeqp = (1/a)^2 * zeq;
IG = V / zeqp;
disp(['IG= ', num2str(abs(IG)), '/_' num2str(angle(IG) * 180/pi), 'A']);

Il = (1/a) * IG;
[theta, z] = cart2pol(real(Il), imag(Il)); % 直角坐標遍極座標
disp(['Il= ', num2str(z),  '/_' num2str(theta * 180/pi), 'A']);

% Working back through T2 gives
Iload = a * Il;
disp(['Iload= ', num2str(abs(Iload)), '/_' num2str(theta * 180/pi), 'A']);

Vload = Iload * zload;
disp(['Vload= ', num2str(abs(Vload)), '/_' num2str(angle(Vload) * 180/pi), 'V']);

Ploss = abs(Il)^2 * rline;
disp(['Ploss= ', num2str(abs(Ploss)), 'W']);