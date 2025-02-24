Pin = 13.69; % 15hp轉換成kw
pf = 0.85;
k = 1000;
Vt = 208; % 端電壓
Xs = 2.5i; % 同步電抗

%(a) From the previous example, the electric input power Pin = 13.69 kW
IA = Pin * k / (3 * Vt * pf); % 電樞電流
disp(['IA = ', num2str(IA), '/_', num2str(-rad2deg(acos(pf))), ' A']);
EA = Vt - Xs * IA * exp(1j * (-acos(pf))); % 電樞(內生)電壓
disp(['EA = ', num2str(abs(EA)), '/_', num2str(rad2deg(angle(EA))), ' V']);

%(b) If the flux is increased by 25 percent
EA2 = 1.25 * abs(EA);% 因為磁通和電樞電壓大小成比例
disp(['EA2 = ', num2str(EA2), ' V']);
delta2 = asin(abs(EA) / EA2 * sin(angle(EA))); % 新的端電壓和電樞電壓向量的夾角
disp(['delta2 = ', num2str(rad2deg(delta2)), ' degree']);
IA2 = (Vt - EA2 * exp(1j * delta2)) / Xs; % 新的電樞電流
disp(['IA2 = ', num2str(abs(IA2)), '/_', num2str(rad2deg(angle(IA2))), ' A']);
disp(['pf = ', num2str(cos(angle(IA2)))]); % 新的功率因數


i_f = (38:1:58) / 10;  % 激磁電流變化範圍

% Now initialize all ot her values 
i_a = zeros(1,21);          % Pre-all ocate i_a array 儲存電樞電流之空矩陣
x_s = 2.5;                  % Synchronous reactance 同步電抗
v_phase = 208;              % phase voltage at 0 degrees 相電壓
delta1 = -17.5 * pi/180;    % delta 1 in radians 角度轉徑度
e_a1 = 182 * (cos (delta1) + 1j * sin(delta1));  %電樞電壓EA1
% Calculate the armat ure current for each value 計算電樞電流變化
for ii = 1 : 21 
    % Calculate magnitude of e_a2  % 計算電樞電壓EA2
    e_a2 = 45.5 * i_f (ii); 
    % Calculate delta2  % 計算電壓夾角
    delta2 = asin(abs(e_a1) / abs(e_a2) * sin(delta1)); 
    % Calculate the phasor e_a2 % 計算相電壓EA2
    e_a2 = e_a2 * (cos(delta2) + 1j * sin(delta2)); 
    % Calculate i_a  % 計算相電流IA2
    i_a(ii) = (v_phase - e_a2) / (1j * x_s);
end 
% Plot the v-curve 
plot(i_f, abs(i_a), 'Color', 'k', 'Linewidth', 2.0) ; 
xlabel('Field Current (A)', 'Fontweight', 'Bold'); 
ylabel('Armature Current (A)', 'Fontweight', 'Bold');
title('Synchronous Motor V-Curve ', 'Fontweight','Bold'); 
grid on;