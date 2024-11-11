VB = 120; % V
R = 0.3; % ohms
l = 10; % m
B = 0.1; % T

% ----------------------------------
% 
eind = 0;
i = (VB - eind) / R;
disp (['i = ' ,num2str(i), ' A']);
vss = VB / (B * l);
disp (['vss = ' ,num2str(vss), ' m/s']);

% ----------------------------------
% if a 30-N force to the right is applied to the bar
F = 30; % N
i = F / (l * B);
disp (['i = ' ,num2str(i), ' A']);
eind = VB + i .* R;
disp (['eind = ' ,num2str(eind), ' V']);
vss = eind / (B * l);
disp (['vss = ' ,num2str(vss), ' m/s']);

% ----------------------------------
% a 30-N force pointing to the left were applied to the Bar

i = F / (l * B);
disp (['i = ' ,num2str(i), ' A']);
eind = VB - i .* R;
disp (['eind = ' ,num2str(eind), ' V']);
vss = eind / (B * l);
disp (['vss = ' ,num2str(vss), ' m/s']);

% ----------------------------------
% magnetic field is weakened to 0.08 T
B = 0.08; % T
vss = VB / (B * l);
disp (['vss = ' ,num2str(vss), ' m/s']);

% ----------------------------------
% 
F = 0:10:50;

i = F ./ (l * B);
eind = VB - i .* R;
v_bar = eind ./ (l * B);

plot(F, v_bar);
title('Plot of Velocity versus Applied Force');
xlabel('Force (N)');
ylabel('Velocity (m/s)');
axis([0 50 0 200]);

