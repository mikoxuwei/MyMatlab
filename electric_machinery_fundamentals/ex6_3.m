Vt= 460;  % 端子輸入電壓
P= 4;  % 極數
f= 60;  % 頻率
R1= 0.641;  % 定子電組
R2= 0.332;  % 等效轉子電阻
X1= 1.106i;  % 定子電抗
X2= 0.464i;  % 等效轉子電抗
XM= 26.3i;  % 鐵芯電抗
Ploss= 1100;  % 總旋轉損失
s= 0.022;  % 轉差率

% (a) Speed 轉子轉速
nr= 120*f/4*(1-s);
disp(['nr= ', num2str(nr), ' rpm']);

% (b) Stator current 定子電流
Zeq= R1+X1+1/(1/XM+1/(R2/s+X2));  % 等效電路總阻抗 *公式p.343(6-24)
disp(['Zeq= ', num2str(Zeq), '/_', num2str(rad2deg(angle(Zeq))), ' ohm']);
I1= Vt/sqrt(3)/Zeq;  % 定子電流=端電壓/等效電路阻抗
disp(['I1= ', num2str(abs(I1)), '/_', num2str(rad2deg(angle(I1))), ' A']);

% (c) The power motor power factor is 
pf= cos(angle(I1));  % 馬達功率因數=cos-1(定子電壓和電流的夾角)
disp(['pf= ', num2str(pf), ' lagging ']);

% (d) The input power to this motor is 
Pin= sqrt(3) * Vt * abs(I1) * pf;  % 三相輸入功率
disp(['Pin= ', num2str(Pin), ' W']);
PSCL= 3*abs(I1)^2*R1;              % 三相定子銅損
disp(['PSCL= ', num2str(PSCL), ' W']);
PAG= Pin - PSCL;                   % 氣隙傳遞功率=輸入功率-定子銅損
disp(['PAG= ', num2str(PAG), ' W']);
Pconv= (1-s)*PAG;                  % 轉子轉換功率=(1-轉差率)X氣隙傳遞功率 *公式p.345(6-33)
disp(['Pconv= ', num2str(Pconv), ' W']);
Pout= Pconv - Ploss;               % 輸出功率=轉子轉換工率-總旋轉損失
disp(['Pout= ', num2str(Pout), ' W']);
disp(['Pout= ', num2str(Pout/746), ' hp']);  % 單位轉換(kW->hp)

% (e) The induced torque is given by 感應轉矩
nsys= 120*f/P;  % 同步轉速
Tind= PAG/(nsys*2*pi*1/f);  % 感應轉矩=氣隙傳遞功率/同步轉速(徑度) *公式p.345(6-36)
disp(['Tind= ', num2str(Tind), ' nt-m']);
Tout= Pout/(nr*2*pi*1/f);  % 
disp(['Tout= ', num2str(Tout), ' nt-m']);

% (f) The motor's efficiency at this operating condition is 效率
ita= Pout / Pin * 100;
disp(['ita= ', num2str(ita), ' %']);