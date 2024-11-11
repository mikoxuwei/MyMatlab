l = 0.55; %m
A = 0.015; %m^2
u0 = 4 * pi * 1E-7;
N = 200; %turns


fai = 0.012; % Wb
B = fai / A; % Wb / m^2
disp (['B = ' ,num2str(B), ' T']);

H = 115; % A·turns/m
F = H * l;
disp (['F = ' ,num2str(F), ' A·turns']);
i = F / N;
disp (['i = ' ,num2str(i), ' A']);

u = B / H;
disp (['u = ' ,num2str(u), ' H/m']);
ur = u / u0;
disp (['us = ' ,num2str(ur)]);

R = F / fai;
disp (['R = ' ,num2str(R), ' A·turns/Wb']);