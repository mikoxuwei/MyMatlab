V = 120;
afa = 0;
z = 20;
theta = -30; 

% calculated current I
I = V / z;
disp (['I = ' ,num2str(I), ' A']);
beta = afa - theta;
disp (['beta = ' ,num2str(beta), ' degree']);
PF = cosd(beta);
disp (['PF = ' ,num2str(PF), ' leading']);


% calculated real power P, reactive power Q and apparent power S
P = V * I * cosd(theta);
disp (['P = ' ,num2str(P), ' W']);

Q = V * I * sind(theta);
disp (['Q = ' ,num2str(Q), ' VAR']);

S = V * I;
disp (['S = ' ,num2str(S), ' VA']);

disp (['S = ' ,num2str(S*exp(1i * theta * pi/180)), ' VA']);

a = angle(S*exp(1i * theta * pi/180)) * 180/pi;  % 徑度還原成角度
disp (['S = ' ,num2str(abs(S)), '/_', num2str(a), ' VA']); % 向量大小