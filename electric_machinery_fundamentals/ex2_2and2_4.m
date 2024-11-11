Voc = 240;
Ioc = 7.133;
Poc = 400;
Vsc = 489;
Isc = 2.5;
Psc = 240;

% Open-circuit test
PF = Poc / (Voc * Ioc);
disp(['PF= ', num2str(PF)]);

YE = Ioc / Voc;
theta = acos(PF);
[Gc, Bm] = pol2cart(theta, YE);
disp(['Rc= ', num2str(1/Gc), '  Xm= ', num2str(1/Bm)]);

% Short-cricuit test
PF = Psc / (Vsc * Isc);
disp(['PF= ', num2str(PF)]);
Zse = Vsc / Isc;
theta = acos(PF);
disp(['Zse= ', num2str(Zse), '/_', num2str(acos(PF) * 180/pi)]);
[Req, Xeq] = pol2cart(theta, Zse);
disp(['Req= ', num2str(Req), '   Xeq= ', num2str(Xeq)]);

% Example 2-4
Vbase1 = 8000;
Sbase1 = 20000;
a = 8000/240; % The turns ratio of this transfonner

% Req = 38.4;
% Xeq = 192i;
% Rc = 159000;
% Xm = 38400;

Zbase1 = Vbase1^2 / Sbase1;
disp(['Zbase1= ', num2str(Zbase1), ' Ohm']);
disp(['Zsepu= ', num2str(Req/Zbase1), ' + j', num2str(Xeq/Zbase1), ' pu.']);

Rc = a^2 * 1/Gc;
Xm = a^2 * 1/Bm;
disp(['Rcpu= ', num2str(Rc/Zbase1), ' pu.']);
disp(['Xmpu= ', num2str(Xm/Zbase1), ' pu.']);


% Example 2-4
Vbase1 = 8000;
Sbase1 = 20000;
a = 8000/240; % The turns ratio of this transfonner

% Req = 38.4;
% Xeq = 192i;
% Rc = 159000;
% Xm = 38400;

% Zbase1 = Vbase1^2 / Sbase1;
% disp(['Zbase1= ', num2str(Zbase1), ' Ohm']);
% Zsepu = (Req + Xeq)/Zbase1;
% disp(['Zsepu= ', num2str(real(Zsepu)), ' + j', num2str(imag(Zsepu), ' pu.']);

% Rcpu = Rc/Zbase1;
% Xmpu = Xm/Zbase1;
% disp(['Rcpu= ', num2str(Rcpu), ' pu.']);
% disp(['Xmpu= ', num2str(imag(Xm)), ' pu.']);