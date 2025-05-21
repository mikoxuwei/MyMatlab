clc; clear;

%% 參數設定
nVar= 4;  % 變數個數(x1, x2, x3, x4)
VarSize= [1, nVar];  % 變數矩陣大小
VarMin= -10;  % 最小範圍
VarMax= 10;  % 最大範圍

MaxIt= 100;  % 最大迭代次數
nBee= 60;  % 蜜蜂總數
nEmp= floor(nBee / 2);  % 雇傭蜂數量
nOnlooker= nBee - nEmp;  % 圍觀蜂數量
Limit= 20;  % 忘記解的次數上限 ( scout bee條件 )

%% 目標函數定義
CostFunction = @(x) (x(1)-3).^2 + (x(2)+2).^2 + (x(3)-1).^2 + (x(4)+4).^2;

%% 初始族群
emptyBee.Position = [];
emptyBee.Cost = [];
emptyBee.Trial = 0;

pop = repmat(emptyBee, nBee, 1); % 建立蜜蜂族群陣列

BestSol.Cost = inf; % 初始最佳解為無限大

for i = 1:nBee
    pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
    pop(i).Cost = CostFunction(pop(i).Position);

    if pop(i).Cost < BestSol.Cost
        BestSol = pop(i);
    end
end

BestCost = zeros(MaxIt, 1);   % 儲存每次迭代最加成本

%% 主迴圈
for it = 1:MaxIt
    % === 僱傭蜂階段
    for i = 1:nEmp
        k = 1;
        while k == i
            k = randi([1 nEmp]);
        end

        phi = rand(VarSize) * 2 - 1; % [-1, 1] 隨機向量
        new.Position = pop(i).Position + phi .* (pop(i).Position - pop(k).Position); % 移動距離
        new.Position = max(min(new.Position, VarMax), VarMin); % 邊界限制

        new.Cost = CostFunction(new.Position);

        if new.Cost < pop(i).Cost
            pop(i).Position = new.Position;
            pop(i).Cost = new.Cost;
            pop(i).Trial = 0;
        else
            pop(i).Trial = pop(i).Trial + 1;
        end
    end

    % 計算機率值 (基於成本) 貪婪選擇
    Costs = [pop(1:nEmp).Cost];
    P = exp(-Costs / std(Costs));
    P = P / sum(P);

    % === 圍觀蜂階段 ===
    for i = 1:nOnlooker
        % 輪盤選擇法
        selected = RouletteWheelSelection(P);

        k = selected;
        while k == selected
            k = randi([1 nEmp]);
        end

        phi = rand(VarSize) * 2 -1; % [-1, 1] 隨機向量
        new.Position = pop(selected).Position + phi .* (pop(selected).Position - pop(k).Position); % 移動距離
        new.Position = max(min(new.Position, VarMax), VarMin); % 邊界限制

        new.Cost = CostFunction(new.Position);

        if new.Cost < pop(selected).Cost
            pop(selected).Position = new.Position;
            pop(selected).Cost = new.Cost;
            pop(selected).Trial = 0;
        else
            pop(selected).Trial = pop(selected).Trial + 1;
        end
    end

    % === Scout Bee 階段 ===
    for i = 1:nBee
        if pop(i).Trial >= Limit
            pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
            pop(i).Cost = CostFunction(pop(i).Position);
            pop(i).Trial = 0;
        end
    end
    % 更新最佳解
    for i = 1:nBee
        if pop(i).Cost < BestSol.Cost
            BestSol = pop(i);
        end
    end

    % 儲存每次迭代最佳成本
    BestCost(it) = BestSol.Cost;
    
    % 顯示進度
    fprintf('Iteration %d: Best Cost = %.5f\n', it, BestCost(it));
end

%% 顯示最佳結果
fprintf('\n最佳解 x = \n');
disp(BestSol.Position);
fprintf('最佳成本 = %.5e\n', BestSol.Cost);

%% 繪製收斂圖
figure;
plot(1:MaxIt, BestCost, 'r-', 'LineWidth', 2);
xlabel('迭代次數');
ylabel('最佳成本');
title('人工蜂群演算法收斂圖');
grid on;
set(gcf, 'Color', 'w');

%% 輪盤選擇法函數
function i = RouletteWheelSelection(P)
    r = rand;
    C = cumsum(P);
    i = find(r <= C, 1, 'first');
end