load('ftp75_load_profile.mat')

P_fc_max=5;               %燃料電池最大輸出功率
P_fc_min=1.92;            %燃料電池最小輸出功率
V_fc=48;                  %燃料電池輸出電壓
I_fc_max=P_fc_max/V_fc;   %燃料電池最大輸出電流
I_fc_min=P_fc_min/V_fc;   %燃料電池最小輸出電流

% battery parameters
p_batt_max_charge=3;      %電池最大充電功率
p_batt_max_discharge=4;   %電池最大放電功率


R_ohm=0.003;%燃料電池參數
Vn_0=1.229;%電阻
T=343;%工作溫度
alpha=0.5;%充電效率
I_ref=100;%參考電流
R=8.314;%通用氣體常數
F=96845;%法拉第常數

% activation loss parameters
i_0=0.02;%交換電流密度
A=100;%活化面積

dt=1;%配合FTP_75
P_fc_trace=zeros(length(time),1);%儲存燃料電池的功率
P_batt_charge_trace=zeros(length(time),1);%儲存電池
P_batt_discharge_trace=zeros(length(time),1);%儲存燃料電池的功率

%損失和電壓
Vn_trace=zeros(length(time),1);%儲存
Vact_trace=zeros(length(time),1);
Vohm_trace=zeros(length(time),1);%儲存歐姆
Vcon_trace=zeros(length(time),1);%儲存集中損失壓降
Vout_trace=zeros(length(time),1);%儲存輸出電壓

for t=1:length(time)
    P_req=P_load_KW(t);

    if P_req<0 %需求小於0表示煞車回收充電
        P_batt_charge=min(p_batt_max_discharge,-P_req);
        P_batt_discharge_trace=0;%放電=0
        P_fc=0;%燃料電池輸出=0
    elseif P_req<=P_fc_max %負載需求小於燃料電池最大輸出時
        P_fc=min(P_fc_max,P_req);


        P_excess=P_fc-P_req;
        if P_excess>0
            P_batt_charge=min(p_batt_max_charge,P_excess);
            P_batt_discharge=0;%不放電
        else
            P_batt_charge=0;%不放電
            P_batt_discharge=0;%不放電
        end
    else
        P_fc=P_fc_max;%燃料電池最大容量放電
        P_deficit=P_req-P_fc;
        P_batt_discharge=min(p_batt_max_discharge,P_deficit);%電池放電
        P_batt_charge=0;%電池不充電
    end

    Vn=Vn_0+((R*T)/(2*F))*log(P_fc/P_fc_min);%計算能斯特內生電壓

    %計算活化損失壓降(有考慮合橫壓力之算法)
    I_fc=P_fc/V_fc;% current(A)
    Vact=(R*T/(alpha*F))*log(I_fc/I_ref);
    
    % 確認活化損失不為0  
    Vact=abs(Vact);
    Vohm=I_fc*R_ohm; %計算歐姆損失壓降

    Vcon=-0.016*log(1-I_fc/I_fc_max);

    Vout=Vn-Vact-Vohm-Vcon;

    P_fc_trace(t)=P_fc;
    P_batt_charge_trace(t)=P_batt_charge;
    P_batt_discharge_trace(t)=P_batt_discharge;

    Vn_trace(t)=Vn;
    Vact_trace(t)=Vact;
    Vohm_trace(t)=Vohm;
    Vcon_trace(t)=Vcon;
    Vout_trace(t)=Vout;

end
figure;

figure(1);
plot(time,P_fc_trace,'r','LineWidth',1.5);
title('Fuel cell power output');%燃料電池輸出的功率曲線
xlabel('time(s)');
ylabel('power(kw)');
% adjust figure properties
set(gcf,'color','w')

figure(2);
plot(time,P_batt_charge_trace,'b','LineWidth',1.5); hold on;
plot(time,P_batt_discharge_trace,'r','LineWidth',1.5); %電池充放電輸出功率曲線圖
title('battery charge and discharge power');
xlabel('time(s)');
ylabel('power(kw)');
legend({'charging power','discharging power'},'Location','west');
hold off;

% adjust figure properties
set(gcf,'color','w')

figure(3);
plot(time,P_load_KW,'r','LineWidth',1.5);
title('load power requirement(FTP-75 cycle)');%負載需求曲線圖
xlabel('time(s)');
ylabel('power(kw)');

set(gcf,'color','w');

figure(4);
plot(time,Vn_trace,'r','LineWidth',1.5);
title('Nernst voltage (Vn)');%燃斯特電壓變化曲線圖
xlabel('time(s)');
ylabel('voltage(V)');

set(gcf,'color','w');

figure(5);
plot(time,Vact_trace,'r','LineWidth',1.5);
title('activation loss(Vact)');%燃斯特電壓變化曲線圖
xlabel('time(s)');
ylabel('voltage(V)');

set(gcf,'color','w');


figure(6);
plot(time,Vohm_trace,'r','LineWidth',1.5);
title('ohmic loss(Vohm)');%燃斯特電壓變化曲線圖
xlabel('time(s)');
ylabel('voltage(V)');
set(gcf,'color','w');

figure(7);
plot(time,Vcon_trace,'r','LineWidth',1.5);
title('concentration loss (Vcon)');%集中損失壓降變化曲線圖
xlabel('time(s)');
ylabel('voltage(V)');
set(gcf,'color','w');


figure(8);
plot(time,Vout_trace,'r','LineWidth',1.5);
title('output voltage (Vout)');%燃料電池輸出電壓曲線圖
xlabel('time(s)');
ylabel('voltage(V)');
set(gcf,'color','w');




