l1 = 0.45; 
l2 = 1.3;
a1 = 0.01;
a2 = 0.015;
ur = 2500;
u0 = 4 * pi * 1E-7;
n = 200;
i = 1;

r1 = l1 / (ur * u0 * a1);
disp (['r1 = ' ,num2str(r1)]);

r2 = l2 / (ur * u0 * a2);
disp (['r2 = ' ,num2str(r2)]);

rtot = r1 + r2;

mmf = n * i;

flux = mmf / rtot;

disp(['Flux = ' num2str(flux)]);