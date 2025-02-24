Vt=460;% 端電壓
P=4; % 極數
f=60; % 頻率
R1=0.641;% 定子電阳
X1=1.106;% 定子電抗
R2=0.332;% 轉子電阻
X2=0.464;% 轉子電抗
XM=26.3;% 鐵芯電抗

% a) what is the maximum torque of this motor and speed and slip
% 求出當拉出轉矩發生時之轉速和滑差
VTH=Vt/sqrt(3)*XM/sqrt(R1^2+(X1+XM)^2); % 戴維寧等效電壓
disp(['VTH=', num2str(VTH),' V']);
RTH=R1* (XM/ (X1+XM)) ^2;                 % 戴維寧等效電阻
disp(['RTH=', num2str(RTH),'Ohm']);
XTH=X1;                                   % 假設戴維寧等效電抗=鐵芯電抗
Smax=R2/sqrt(RTH^2+(XTH+X2) ^2);          % 拉出轉矩發生時之滑差 
disp(['smax=', num2str(Smax)]);
nsync=120*f/P;                            % 同步轉速（rpm）
wsync=120*f/P*2*pi/60;                    % 同步轉速（徑度）
disp(['nsync=', num2str(nsync), ' rpm' ]);
disp(['wsync=', num2str(wsync), ' rad/s']);
nm=(1-Smax) *nsync; % 拉出轉矩發生時之轉速
disp(['nm=', num2str(nm), 'rpm']);
Tmax=3*VTH^2/ (2*wsync*(RTH+sqrt(RTH^2+(XTH+X2)^2))); % 2倍轉子電阻下之拉出轉矩
disp(['Tmax=', num2str(Tmax), ' Nt-m']);

% b) The starting torque of this motor is found by setting s = 1 啟動時滑差=1
Tstart=3*VTH^2*R2/ (wsync*((RTH+R2) ^2+(XTH+X2) ^2)) ; % 啟動轉矩
disp(['Tstart=', num2str(Tstart), ' Nt-m']);

% c) If the rotor resistance is doubled, then the slip at maximum torque doubles, too
% 因為轉子電阻為2倍時，拉出轉矩發生時之滑差也會變成2倍
Smax=2* Smax;
disp(['Smax=', num2str(Smax)]);
nm= (1-Smax) *nsync; % 轉子電阻為2倍時之轉速
disp([ 'nm=', num2str(nm), ' rpm' ]);
Tstart=3*VTH^2*2*R2/(wsync*((RTH+2*R2)^2+(XTH+X2) ^2)) ;% 轉子電阻為2倍時之啟動轉短
disp(['Tstart=', num2str(Tstart), ' Nt-m']);