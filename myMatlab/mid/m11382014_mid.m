% 生成數據
x = 10 * rand(1, 100);               % 在 0 到 10 之間產生 100 個隨機值
y = cos(x) + 2 * rand(1, 100);       % 生成 y 值，加上隨機誤差值
disp('x 值:'); disp(x); 
disp('y 值:'); disp(y);

% 轉置
x = x';
y = y';

% 用線性一次、二次、三次多項式和非線性方程式進行 Data fitting，並把結果和原始資料畫在同一張圖上。
% 一次多項式擬合
p1 = fit(x, y, 'poly1');
% 二次多項式擬合
p2 = fit(x, y, 'poly2');
% 三次多項式擬合
p3 = fit(x, y, 'poly3');
% 非線性擬合 (exp)
pExp = fit(x, y, 'exp1');

% 繪圖
figure('Name','Data fitting', 'NumberTitle','off');
% 原始數據
plot(x, y, 'b.');
hold on;

plot(p1, 'r');
plot(p2, 'g');
plot(p3, 'm-');
plot(pExp, 'k--');
hold off;
% 圖例和標題
legend('原始數據', '一次多項式擬合', '二次多項式擬合', '三次多項式擬合', '非線性擬合(exp)');
title('Data Fitting using Linear, Quadratic, Cubic, and Nonlinear Equations');
xlabel('x');
ylabel('y');
grid on;