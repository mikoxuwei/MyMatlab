% ss 狀態空間
% dx/dt = Ax + BI;
% theta = Cx + DI;
% 此ODE改寫ss

A = [0 1; -5 -2];
B = [0; 3];
C = [1 0];
D = 0;
H = ss(A, B, C, D);
H

% FRD 頻率響應資料

freq = [10, 30, 50, 100, 500];
resp = [0.0021+0.0009i, 0.0027+0.0029i, 0.0044+0.0052i, 0.0200-0.0040i, 0.0001-0.0021i];
H = frd(resp, freq, 'Units', 'Hz');
H

% 建立MIMO模型
s = tf('s'); % 先宣告是拉普拉斯
H = [1/(s+1), 0; (s+1)/(s^2 + s + 3), -4*s/(s+2)];
H

size(H) % 知道多少輸入、輸出
pole(H) % 計算極點
isstable(H) % 詢問系統是否穩定
step(H) % 繪製步階響應
