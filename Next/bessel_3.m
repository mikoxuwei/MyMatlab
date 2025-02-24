clc, clear; close all;

% 參數設定 *
max_iters = 300; % 迭代次數
T_init = 100; % 初始溫度
T_min = 1e-3; % 最小溫度
alpha = 0.98; % 降溫率

% x 和 y 的初始猜測值
x = rand() * 10; % 隨機初始 x 值(範圍0-10)
y = rand() * 10; % 隨機初始 y 值(範圍0-10)

% 儲存結果
iter_vals = zeros(max_iters, 1);
x_vals = zeros(max_iters, 1);
y_vals = zeros(max_iters, 1);
T_vals = zeros(max_iters, 1);

% 目標函數(ODE 殘差)
residual = @(x, y) abs(81 * x^2 * (y - 1) + 27 * x * y + ((9 * x^(2/3)) + 8) * y);

% 模擬退火迴圈
T = T_init;
for iter = 1:max_iters
    % 儲存當前值
    iter_vals(iter) = iter;
    x_vals(iter) = x;
    y_vals(iter) = y;
    T_vals(iter) = T;

    % 生成新候選解
    x_new = x + (rand() - 0.5) * 2; % x 的小擾動
    y_new = y + (rand() - 0.5) * 2; % y 的小擾動

    % 計算殘差
    cost_old = residual(x, y);
    cost_new = residual(x_new, y_new);

    % 接受新解的機率
    if cost_new < cost_old || exp((cost_old - cost_new) / T) > rand()
        x = x_new;
        y = y_new;
    end

    % 降溫
    T = T * alpha;
    if T < T_min
        break;
    end
end

% 顯示計算結果
fprintf('最終計算結果: x = %.6f, y = %.6f\n', x, y);

% 繪製結果
figure;
subplot(3,1,1);
plot(iter_vals, x_vals,'b-', 'Linewidth', 1.5);
xlabel('选代次數');
ylabel('x'); 
title('迭代次數 vs. x');
grid on;

subplot(3,1,2);
plot(iter_vals, y_vals,'r-','LineWidth', 1.5);
xlabel('迭代次數');
ylabel('y');
title('选代次數 vs. y');
grid on;

subplot(3,1,3);
plot(iter_vals, T_vals, 'k-', 'LineWidth', 1.5);
xlabel('选代次數');
ylabel('溫度'); 
title('迭代次數 vs. 溫度');
grid on;

% 調整圓形屬性
set(gcf, 'Color', 'w');