% Load FTP-75 load profile (time in seconds, power required in kW)
load('ftp75_load_profile.mat');  % This file should contain 'time' and 'P_load_kW' 燃料電池輸出功率

% System parameters
P_fc_max= 5;  % Max fuel cell power in kW 燃料電池最大輸出功率
P_fc_min= 1.92;  % Max fuel cell power in kW 燃料電池最大輸出功率
V_fc= 48;  % Max fuel cell power in kW 燃料電池最輸出電壓
I_fc_max= P_fc_max / V_fc;  % Max current (A) 燃料電池最大輸出電流
I_fc_min= P_fc_min / V_fc;  % Max fuel cell power in kW 燃料電池最大輸出功率

% Battery parameters
P_batt_max_charge= 3;  % Max charge power of battery in kW 電池最大充電功率
P_batt_max_discharge= 4;  % Max discharge power of battery in kW 電池最大放電功率

% Fuel cell loss parameters (assumed) 燃料電池參數
R_ohm= 0.003;  % ohmic resistance (Ohms) 電組
Vn_0= 1.229;  % Standard Nernst voltage at standed conditions (V) 標準條件下之能斯特電壓(內生電壓)
T= 343;  % Opearting temperature (K) 工作溫度
T_ref= 298;  % Reference temperature (K) 參考溫度
alpha= 0.5;  % Charge transfer coefficient 充電效率
I_ref= 100;  % Reference current (A) 參考電流
R= 8.314;  % Universal gas constant (J/
F= 96485;  % Faraday constant (C/mol) 法拉第常數(庫倫/莫耳)

% Activation Loss parameters 活化損失參數
i_0= 0.02;  % Exchange current density (A/cm^2) 交換電流密度
A= 100;  % Active area (cm^2) 活化面積




P_batt_charge_trace= zeros(length(time), 1);  % For storing Battery charge power 儲存電池充電功率之空矩陣
P_batt_discharge_trace= zeros(length(time), 1);  % For storing Battery discharge power 儲存電池放電功率之空矩陣

% Losses and voltage 損失和電壓
Vn_trace= zeros(length(time), 1);  % Nernst voltage trace 儲存能斯特電壓空矩陣
Vact_trace= zeros(length(time), 1);  % Activation loss trace 儲存活化損失壓降空矩陣
Vohm_trace= zeros(length(time), 1);  % Ohmic loss trace 儲存歐姆損失壓降空矩陣
Vcon_trace= zeros(length(time), 1);  % Concentration loss trace 儲存集中損失壓降空矩陣
Vout_trace= zeros(length(time), 1);  % Output loss trace 儲存輸出電壓空矩陣

% Main simulation loop
for t= 1:length(time)
    P_req= P_load_kW(t);  % Power required by the load at current time 當前負載功率需求

    if P_req < 0  % 需求小於0表示煞車回收充電
        % If the load required is negative (regenerative braking or surplus energe)
        % Charge the battery directly 電池充電
        P_batt_charge= min(P_batt_max_charge, -P_req);  % Battery charge with this surplus power
        P_batt_discharge= 0;  % No discharge 放電=0
        P_fc= 0;  % Fuel cell provides no  power in this case 此時燃料電池輸出=0
    elseif P_req <= P_fc_max  % 負載需求小於燃料電池最大輸出時
        % Fuel cell







        P_batt_discharge= 0;  % No discharge 不放電





        % Fuel cell cannot meet the load demand, battery discharge 燃料電池無法完全供應付載需求時
        P_fc= P_fc_max;  % Fuel cell operates at max capacity 燃料電池以最大容量放電
        P_deficit= P_req - P_fc;  % Remaining power required from the battery 不構之功率取自電池
        P_batt_discharge= min(P_batt_max_discharge, P_deficit);  % Battery discharge 電池放電
        P_batt_charge= 0;  % No charging 電池不充電
    end

    % Calculate Nernst voltage (Vn) 以公式計算能斯特(內生)電壓
    Vn= Vn_0 + ((R * T) / (2 * F)) * log(P_fc / P_fc_min);

    % Calculate Activation loss (Vact) using Tafel equation 以公式計算活化損失壓降

    %Vact= (R * T / (alpha * F)) * log(I_fc / I_ref);

    % Calculate Activation loss (Vact) using Tafel equation with clamping 
    % 計算活化損失壓降
    I_fc= P_fc / V_fc;
    
    
    
    
    Vact= aos(Vact);

    % Calculate Ohmic loss (Vohm) 計算歐姆損失壓降
    Vohm= I_fc * R_ohm;
    
    
    % Calculate Concentration loss (Vcon) using a simplofied equation 以簡化公式計算集中損失
    Vcon= -0.016 * log(1 - I_fc / I_fc_max);
    
    % Output voltage (Vout) 輸出電壓
    Vout= Vn - Vact - Vohm - Vcon;
    
    % Store the results 儲存計算結果
    P_fc_trace(t)= P_fc;
    P_batt_charge_trace(t)= P_batt_charge;
    P_batt_discharge_tract(t)= P_batt_discharge;


    Vohm_trace(t)= Vohm;
    Vcon_trace(t)= Vcon;
    Vout_trace(t)= Vout;
end

% Plot the results
figure;

figure(1);
plot(time, P_fc_trace, 'LineWidth', 1.5);
title('Fuel Cell Power Output');  % 燃料電池輸出功率取縣圖
xlabel('Time(s)');
ylabel('Power (kW)');
% Adjust figure properties
set(gcf, 'Color', 'w');

figure(2)
plot(time, P_batt_charge_trace, 'b', 'LineWidth', 1.5); hold on;
plot(time, P_batt_discharge_trace, 'r', 'LineWidth', 1.5);
title('Battery Charge and Discharge Power');  % 電池充放電輸出功率取縣圖
xlabel('Time(s)');
ylabel('Power (kW)');
legend({'Charging Power', 'Discharge Power'}, 'Location', 'best');
hold off;

% Adjust figure properties
set(gcf, 'Color', 'w');

figure(3);
plot(time, P_load_kW, 'LineWidth', 1.5);
title('Load Power Requirement (FTP-75 Cycle)');  % 負載需求曲線圖
xlabel('Time(s)');
ylabel('Power (kW)');

% Adjust figure properties
set(gcf, 'Color', 'w');

% New Plots for losses and output voltages
figure(4);
plot(time, Vn_trace, 'LineWidth', 1.5);
title('Nernst Voltage (Vn)');  % 能斯特電壓變化曲線圖
xlabel('Time(s)');
ylabel('Voltage (V)');

% Adjust figure properties
set(gcf, 'Color', 'w');

figure(5);
plot(time, Vact_trace, 'LineWidth', 1.5);
title('Activation Loss (Vact)');  % 活化損失壓降變化曲線圖
xlabel('Time(s)');
ylabel('Voltage (V)');

% Adjust figure properties
set(gcf, 'Color', 'w');

figure(6);
plot(time, Vohm_trace, 'LineWidth', 1.5);
title('Ohmic Loss(Vohm)');  % 歐姆損失壓降變化曲線圖
xlabel('Time(s)');
ylabel('Voltage (V)');

% Adjust figure properties
set(gcf, 'Color', 'w');

figure(7);
plot(time, Vcon_trace, 'LineWidth', 1.5);
title('Concentration Loss (Vcon)');  % 集中損失壓降變化曲線圖
xlabel('Time(s)');
ylabel('Voltage (V)');

% Adjust figure properties
set(gcf, 'Color', 'w');

figure(8);
plot(time, Vout_trace, 'LineWidth', 1.5);
title('Output Voltage (Vout)');  % 燃料電池端子輸出電壓曲線圖
xlabel('Time(s)');
ylabel('Voltage (V)');

% Adjust figure properties
set(gcf, 'Color', 'w');
