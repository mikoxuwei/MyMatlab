ls = 0.5; %m 
lr = 0.05; %m
la = 0.0005; %m
As = 0.0012; %m ^ 2
Ar = 0.0012; %m ^ 2
Aa = 0.0014; %m ^ 2
ur = 2000;
u0 = 4 * pi * 1E-7;
n = 200; %turns
i = 1; %A

rs = ls / (ur * u0 * As);
disp (['rs = ' ,num2str(rs), ' A·turns/Wb']);

rr = lr / (ur * u0 * Ar);
disp (['rr = ' ,num2str(rr), ' A·turns/Wb']);

ra = la / (u0 * Aa);
disp (['ra = ' ,num2str(ra), ' A·turns/Wb']);

rtot = rs + rr + ra * 2;
disp (['rtot = ' ,num2str(rtot), ' A·turns/Wb']);

mmf = n * i; %A·turns

flux = mmf / rtot; %Wb

disp(['Flux = ' num2str(flux), ' A·turns/Wb']);

b = flux / Aa;
disp(['b = ' num2str(b), ' T']);