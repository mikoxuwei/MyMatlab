% 使用傳遞模型在 MATLAB 模擬出 PID
kp = 1;
ki = 1;
kd = 1;

s = tf('s');
C = kp + ki/s + kd * s;
C
% 使用 PID 物件產生等效的連續時間控制器
C = pid(kp, ki, kd);
C
tf(C)