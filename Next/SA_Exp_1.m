% Example 1: Simulated Annealing for function optimazer
clear; clc;

% 目標函數
f = @(x) x.^2 + 4 * cos(x);

% 初始化
T = 100; % 初始溫度
T_min = 1e-3; % 最低溫度
alpha = 0.9; % 溫度下降率
x = rand() * 10 - 5; % 隨機選取初始解於 [-5, 5]
best_x = x;
best_f = f(x);

while T > T_min
    % 產生鄰域解（隨機微小變動）
    new_x = x + (rand() - 0.5);
        if new_x < -5 || new_x > 5
            continue;
        end
    % 計算新解的函數值
    new_f = f(new_x);
    delta = new_f - f(x);
    
    % 接受條件：若新解更優，則接受；若更差，則以機率接受
    if delta < 0 || rand() < exp(-delta / T)
        x = new_x;
    end
    
    % 更新最佳解
    if f(x) < best_f
        best_x = x;
        best_f = f(x);
    end
    
    % 降低溫度
    T = T * alpha;

end

disp(['最佳解： ', num2str(best_x)]);
disp(['最小值： ', num2str(best_f)]);