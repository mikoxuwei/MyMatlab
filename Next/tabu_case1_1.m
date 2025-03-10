% 禁忌搜尋法 f(x) = (x - 3)^2 in [0, 10]
% 目的函數(平方誤差)
f = @(x) (x - 3).^2;

% 禁忌搜尋參數
max_iter = 100; % 最大疊代數
tabu_size = 10; % 禁忌表列數
neighbor_size = 10; % 鄰近比較數

x_min = 0; % 下限
x_max = 10; % 上限
tolerance = 1e-6; % 收斂判斷之容許誤差

% initialzation
x_best = x_min + (x_max - x_min) * rand(); % 以亂數*區間來初始化最佳解
f_best = (x_best);
tabu_list = []; % 建立 tabu 列表區間

% 主程式迴圈
for iter = 1:max_iter
    % 產生鄰近解(以亂數干擾)
    neighbors = x_best + (rand(neighbor_size, 1) - 0.5) * (x_max - x_min) * 0.1;
    
    % 鄰近解界線[x_min, x_max]
    neighbors = max(min(neighbors, x_max), x_min);

    % 帶入目的函數評估鄰近解
    f_values = arrayfun(f, neighbors);

    % 移動 tabu 鄰近解
    for i = 1:length(neighbors)
        if ismember(neighbors(i), tabu_list)
            f_values(i) = inf; % Assign a high cost to tabu solutions
        end
    end
    
     

    % 更新 tabu 列表
    tabu_list = [tabu_list; x_neighbor];
    if length(tabu_list) > tabu_size
        tabu_list(1) = []; % Remove the oldest entry
    end

    % 收斂判斷
    if f_best < tolerance
        break;
    end

    % 螢幕顯示最佳解
    fprintf('Iteration %d: Best x = %.6f, f(x) = %.6f\n', iter, x_best, f_best);
end

% 顯示最後結果
disp('-------------------------------------');
disp(['Best solution: x = ', num2str(x_best)]);
disp(['f(x) = ', num2str(f_best)]);