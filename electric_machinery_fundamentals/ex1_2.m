lc = 0.4; 
la = 0.0005;
Ac = 0.0012; %???
Aa = 1.05 * 0.0012;
ur = 4000;
u0 = 4 * pi * 1E-7;
n = 400;
Ba = 0.5;

rc = lc / (ur * u0 * Ac);
disp (['rc = ' ,num2str(rc)]);

ra = la / (u0 * Aa);
disp (['ra = ' ,num2str(ra)]);

rtot = rc + ra;
disp (['rtot = ' ,num2str(rtot)]);

i = (Ba * Aa * rtot) / n;

disp(['i = ' num2str(i)]);