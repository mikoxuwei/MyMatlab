% p.53 穩態卡爾曼濾波器(控制系統識別與卡爾曼濾波器.pdf) 
% Design the Filter 
A= [1.1269 -0.4940 0.1129
    1.0000       0      0
         0  1.0000      0];
B= [-0.3832
    0.5919
    0.5191];

C= [1 0 0];

D= 0;

% first create the plant model with an input for w.
% Set the sample time to -1 to mark the plant as discrate (without a specific sample time).
Ts =-1;
sys= ss(A, [B B], C, D, Ts, 'InputName', {'u' 'w'}, 'OutputName', 'y');  % Plant dynamics and additive input

% Process noise coveriance Q and the sensor noise coverianse R are values
% greater
Q= 2.3;
R= 1;

[kalmf, L, ~, Mx, Z]= kalman(sys,Q,R);

% Use the kalman, discard the state estimates and keep only the first
% output, ^y.
kalmf= kalmf(1, :);

% Use the Filter 檢視訊號
sys.InputName= {'u', 'w'};
sys.OutputName= {'yt'};
vIn= sumblk('y= yt+v');  % 斜方誤差+觀測誤差

kalmf.InputName= {'u', 'y'};
kalmf.OutputName= {'ye'};

SimModel= connect(sys, vIn, kalmf, {'u', 'w', 'v'}, {'yt', 'ye'});

% To sinulate the filter behavior, generate a known sinusoidal input vector.
t= (0:100)';
u= sin(t/5);

% Generate process noise and sensor noise vectors
rng(10, 'twister');
w= sqrt(Q)*randn(length(t), 1);
v= sqrt(R)*randn(length(t), 1);

% Finally, simulate the response using lsim.
out= lsim(SimModel,[u, w, v]);

% lsim generates the response at the outputs yt and ye
% to the inputs appliend at w, v, and u.
% Extract the yt and ye channels and compute the measured response.
yt= out(:, 1);  % true response
ye= out(:, 2);  % filteres resopnse
y= yt+v;        % measured resopnse

% Compare the true response with the filtered resopnse.
clf
subplot(211), plot(t, yt, 'b', t, ye, 'r--');
xlabel('Number of Samples'), ylabel('Output');
title('Kalman Filter Response')
legend('Ture', 'Filtered')
subplot(212), plot(t, yt-y, 'g', t, yt-ye, 'r--');
xlabel('Number of Samples'), ylabel('Error')
legend('True - measured', 'True - filtered')

MeasErr = yt - y;
MeasErrCov= sum(MeasErr.*MeasErr)/length(MeasErr); 
MeasErrCov
EstErr = yt - ye;
EstErrCov= sum(EstErr.*EstErr)/length(EstErr);
EstErrCov