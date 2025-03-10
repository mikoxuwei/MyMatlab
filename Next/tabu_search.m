% tabu_case_1
function [best_x, best_f] = tabu_search()
    % 初始化參數
    max_iter = 100; % 最大迭代次數
    tabu_list_size  = 5;% 茶忌表大小
    step_size = 0.5; % 左右鄰居搜索步長
    x_min = 0;
    x_max = 10; % 定義搜索範圍
    
    % 初始化解
    x = rand() * (x_max - x_min) + x_min;
    best_x = x;
    best_f = objective_function(x);
    tabu_list = []; % 禁忌表 建立 tabu 列表區間
    for iter = 1:max_iter
        % 產生隔近解
        neighbors = [x - step_size, x + step_size]; % 左右鄰居範園
        neighbors = neighbors(neighbors >= x_min & neighbors <= x_max); % 修正上述鄰居範為錯誤[0, 10]
        
        % 選擇最好的鄰近解（不在禁忌表中）
        best_neighbor = x;
        best_neighbor_f = inf;
        for i = 1:length(neighbors)
            if ~ismember(neighbors(i), tabu_list)
                f_val(i) = objective_function(neighbors(i));
                if f_val < best_neighbor_f % 比較鄰居是否比較好?
                    best_neighbor = neighbors(i);
                    best_neighbor_f = f_val;
                end
            end
        end
    
        % 更新當前解
        x = best_neighbor;
        tabu_list = [tabu_list, x];
        if length(tabu_list) > tabu_list_size
            tabu_list(1) = [];
        end
    
        % 更新最佳解
        if best_neighbor_f < best_f
            best_x = best_neighbor;
            best_f = best_neighbor_f;
        end
    end

    % 螢幕顯示求解過程
    fprintf('Iteration %d: Best x = %.6f, f(x) = %.6f\n', iter, best_x, best_f);
end

function f = objective_function(x)
    f = (x - 3)^2;
end
