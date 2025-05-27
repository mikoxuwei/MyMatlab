% 主程式
function main
    clc; clear;

    % --------------
    % 問題定義
    % --------------
    CostFunction = @(x) composite_func_vec(x);  % 成本函數( 接受向量輸入 )
    nVar = 2;  % 變數個數
    VarSize = [1 nVar];  % 決策變數矩陣大小
    VarMin = -5;  % 下界
    VarMax = 5;  % 上界

    % --------------
    % 鯨魚最佳化演算法參數
    % --------------
    MaxIt = 100;  % 最大迭代次數
    nPop = 30;  % 鯨魚數量( 搜尋代理數 )

    % 初始化族群
    for i = 1:nPop
        whale(i).Position = unifrnd(VarMin, VarMax, VarSize);  % 隨機初始化位置
        whale(i).Cost = CostFunction(whale(i).Position);  % 評估成本
    end

    % 依照成本排序，找到最佳鯨魚
    [~, idx] = sort([whale.Cost]);
    whale = whale(idx);
    Leader = whale(1);  % 最佳鯨魚( 領導者 )

    % --------------
    % 主迴圈
    % --------------
    for t = 1:MaxIt
        a = 2 - t * (2 / MaxIt);  % 線性遞減參數a ( 控制探索與利用 )

        for i = 1:nPop
            r1 = rand(); r2 = rand();
            A = 2 * a * r1 - a;  % 計算 A 向量
            C = 2 * r2;  % 計算 C 向量

            p = rand();  % 隨機機率，用於選擇策略
            b = 1;  % 螺旋常數
            l = (rand() - 0.5) * 2;  % 隨機數 [-1, 1]

            if p < 0.5
                if abs (A) < 1
                    % 朝向最佳鯨魚移動( 探索 )
                    D = abs(C * Leader.Position - whale(i).Position);
                    newPos = Leader.Position - A * D;
                else
                    % 隨機選擇一隻鯨魚，探索其位置
                    randWhale = whale(randi(nPop)).Position;
                    D = abs(C * randWhale - whale(i).Position);
                    newPos = randWhale - A * D;
                end
            else
                % 螺旋更新位置 ( 模擬氣泡網捕魚 )
                D = abs(Leader.Position - whale(i).Position);
                newPos = D * exp(b * l) .* cos(2 * pi * l) + Leader.Position;
            end

            % 邊界檢查
            newPos = max(newPos, VarMin);
            newPos = min(newPos, VarMax);

            % 計算新位置的成本
            newCost = CostFunction(newPos);
            if newCost < whale(i).Cost
                whale(i).Position = newPos;
                whale(i).Cost = newCost;

                % 更新領導者
                if newCost < Leader.Cost
                    Leader = whale(i);
                end
            end
        end

        % 儲存目前最佳成本
        BestCost(t) = Leader.Cost;
    end

    % 顯示結果
    fprintf('最佳解: [%f, %f]\n', Leader.Position(1), Leader.Position(2));
    fprintf('最佳成本值: %f\n', Leader.Cost);

    % --------------
    % 繪製 2D 成本函數等高線圖
    % --------------
    figure;
    fcontour(@composite_func, [VarMin VarMax VarMin VarMax]);  % 使用向量化版本
    title('複合成本函數 ( 2D 等高線圖 )');
    xlabel('x'); ylabel('y'); colorbar;
    set(gcf, 'Color', 'w');

    % --------------
    % 繪製收斂圖
    % --------------
    figure;
    semilogy(BestCost, 'LineWidth', 2);
    title('WOA 收斂圖'); xlabel('迭代次數'); ylabel('最佳成本');
    grid on;
    set(gcf, 'Color', 'w');

    % --------------
    % 向量輸入版本: 供 WOA 計算成本 (x = [x1 x2] )
    % --------------
    function z = composite_func_vec(x)
    x1 = x(1);
    x2 = x(2);
    z = composite_func(x1, x2);   % 呼叫原始的 x, y 版成本函數
    end

    % --------------
    % 向量化的成本函數: 供 fcontour 畫等高圖使用 ( 支援矩陣輸入 )
    % --------------
    function z = composite_func(x, y)
    % Rastrigin 函數
    rastrigin = 20 + x.^2 - 10.*cos(2 * pi * x) + y.^2 - 10.*cos(2 * pi * y);

    % Ackley 函數
    r = sqrt(0.5 * (x.^2 + y.^2));
    ackley = -20 .*exp(-0.2.*r)...
                 - exp(0.5.*(cos(2*pi*x) + cos(2*pi*y))) + exp(1) + 20;

    % 複合函數 = 平均兩者
    z = 0.5 * (rastrigin + ackley);
    end
end