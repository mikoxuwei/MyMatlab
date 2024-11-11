%% A linear machine shown in Figure PI- 15 has a magnetic flux density of 0.5 T directed into the page, 
% a resistance of 0.25 n, a bar length I = 1.0 ro, and a battery voltage of 100 V. 

% 已知參數
V_B = 100;        % 電池電壓 (V)
R = 0.25;         % 電阻 (ohms)
B = 0.5;          % 磁場強度 (T) 向紙內
l = 1;            % 導杆長度 (m)
F_load = 25;      % 負載力 (N)

%% (a) What is the initial force on the bar at starting? What is the initial current flow? 
% (a) 啟動時的初始電流和力
I_initial = V_B / R;                    % 初始電流 (A)
F_initial = B * I_initial * l;          % 初始力 (N)

% 顯示初始結果
fprintf('(a) 啟動時的初始電流為 %.2f A\n', I_initial);
fprintf('     啟動時的初始力為 %.2f N 向右\n', F_initial);
%% (b) What is the no-load steady-state speed of the bar? 
% (b) 無負載時的穩態速度
% E = B * l * v;
% V_B = E + I_steady * R; % 無負載時 I_steady ≈ 0 => V_B ≈ E
v_steady_noload = V_B / (B * l);        % 無負載時的穩態速度 (m/s)

% 顯示無負載結果
fprintf('(b) 無負載時的穩態速度為 %.2f m/s\n', v_steady_noload);

%% (c) If the bar is loaded with a force of 25 N opposite to the direction of motion, 
% what is the new steady-state speed? What is the efficiency of the machine under these circumstances?
% (c) 有 25N 負載時的穩態速度和效率
% 電磁力 F_ele = F_load = 25 N /// F_ele = B * I * l
I_steady_load = F_load / (B * l);       % 有負載時的穩態電流 (A)
% fprintf('%.2f A\n', I_steady_load);

% V_B = E + I_steady * R; E = B * l * v; => V_B = B * l * v + I_steady * R
v_steady_load = (V_B - I_steady_load * R) / (B * l);  % 有負載時的穩態速度 (m/s)
% fprintf('%.2f m/s\n', v_steady_load);

% 計算功率和效率
P_out = F_load * v_steady_load;         % 輸出功率 (W)
% fprintf('%.2f W\n', P_out);
P_in = V_B * I_steady_load;             % 輸入功率 (W)
% fprintf('%.2f W\n', P_in);
efficiency = (P_out / P_in) * 100;      % 效率百分比

% 顯示負載情況結果
fprintf('(c) 有 25N 負載時的穩態速度為 %.2f m/s\n', v_steady_load);
fprintf('     有 25N 負載時的機器效率為 %.2f%%\n', efficiency);