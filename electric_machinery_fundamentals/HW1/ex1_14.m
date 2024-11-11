%% 1-14. 
% A two-legged magnetic core with an air gap is shown in Figure P1-11. 
% The depth of the core is 5 cm, the length of the air gap in the core is 0.05 cm, and the number of turns on the coil is 1000. 
% The magnetization curve of the core material is shown in Figure P1-9. Assume a 5 percent increase in effective air-gap area to account for fringing. 
% (a) How much current is required to produce an air-gap flux density of 0.5 T?
% (b) What are the flux densities of the four sides of the core at that current? 
% (c) What is the total flux present in the air gap?

% 參數
u0 = 4 * pi * 10^-7;      % 空氣磁導率 (H/m)
N = 1000;                 % 線圈匝數
l_airgap = 5e-4;          % 氣隙長度 (m)
B_airgap = 0.5;           % 氣隙磁通密度 (T)
l_top = 37.5e-2;          % 上磁芯長度 (m)
l_butt = 37.5e-2;         % 下磁芯長度 (m)
l_right = 40e-2;          % 右磁芯長度 (m)
l_left = 40e-2;           % 左磁芯長度 (m)
A_core_r = 5 * 5 * 1e-4;  % 磁芯截面積 (m^2) (5cm x 5cm)
A_core_t = 10 * 5 * 1e-4; % 磁芯截面積 (m^2) (10cm x 5cm) % = l_core_l = l_core_b
% A_core_b = 10 * 5 * 1e-4; % 磁芯截面積 (m^2) (10cm x 5cm)
% A_core_l = 10 * 5 * 1e-4; % 磁芯截面積 (m^2) (10cm x 5cm)

%% (a) How much current is required to produce an air-gap flux density of 0.5 T?

% 計算氣隙中的磁場強度
H_airgap = B_airgap / u0;
fprintf('H = %.4f AT/m\n', H_airgap);

% 計算磁勢 (Magnetomotive Force, MMF)
MMF_airgap = H_airgap * l_airgap;

% 考慮 5% 邊緣效應的氣隙有效面積 (m^2)
A_airgap = A_core_r * 1.05;

flux = B_airgap * A_airgap;

B_core_r = flux / A_core_r;
H_core_r = 410;     % 根據 P1-9 找出 H (A.turns/m)
B_core_t = flux / A_core_t; % = B_core_l = B_core_b
H_core_t = 250;     % 根據 P1-9 找出 H (A.turns/m) 
% H_core_t = H_core_l = H_core_b = 250

MMF_r = H_core_r * l_right;
MMF_t_b_l = H_core_t * (l_top + l_left + l_butt); 

MMF_tatol = MMF_r + MMF_t_b_l + MMF_airgap;

% 計算所需的電流
I = MMF_tatol / N;

% 輸出所需的電流
fprintf('(a) 所需電流 I = %.4f A\n', I);

%% (b) What are the flux densities of the four sides of the core at that current?

% 輸出磁通密度
fprintf('(b) 磁芯右邊的磁通密度 = %.4e T\n', B_core_r);
fprintf('     磁芯另外三邊的磁通密度 = %.4e T\n', B_core_t);

%% (c)  What is the total flux present in the air gap?
% 計算氣隙中的總磁通

% 輸出總磁通
fprintf('(c) 氣隙中的總磁通 = %.4e Wb\n', flux);