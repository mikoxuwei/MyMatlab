clc; clear;

%% 問題定義
nVar = 5; % 變數數量
VarSize = [1 nVar]; % 決策變數的矩陣尺寸
VarMin = -5.12;     % 每個變數的下限
VarMax = 5.12;      % 每個變數的上限
%% GWO 參數設定
MaxIt = 100;        % 最大迭代次數
nPop = 30;          % 狼群數量（搜尋代理數）

% 初始化狼群結搆
wolf.Position = []; % 狼的位置（解）
wolf.Cost = [];     % 對應的目標函數值（成本）
wolf.Violation = [];
wolf.Fitness = [];

% 初始化三個領導狼
alpha. Cost = inf;  % 最佳弊（α 狼）
beta.Cost = inf;    % 次佳解（β 狼）
delta.Cost = inf;   % 第二佳解（δ 狼）
% 初始化三個領導狼（初始化所有欄位）
alpha.Position = zeros(1, nVar);
beta.Position = zeros(1, nVar);
delta.Position = zeros(1, nVar);
alpha.Fitness = inf;
beta.Fitness = inf;
delta.Fitness = inf;
alpha.Violation = inf;
beta.Violation = inf;
delta.Violation = inf;


% 產生初始狼群
pop = repmat(wolf, nPop, 1);

for i = 1:nPop
    pop(i).Position = unifrnd(VarMin, VarMax, VarSize); % 初始隨機位置
    [pop(i).Cost, pop(i).Violation] = obj_with_constraints(pop(i).Position); % 計算違反值
    pop(i).Cost = rastrigin(pop(i).Position); % 計算罰鍰
    pop(i).Fitness = pop(i).Cost + 1e6 * pop(i).Violation;

    % 更新 α、β、δ 狼
    if pop(i).Fitness < alpha.Fitness
        delta = beta;
        beta = alpha;
        alpha = pop(i);
    elseif pop(i).Fitness < beta.Fitness
        delta = beta;
        beta = pop(i);
    elseif pop(i).Fitness < delta.Fitness
        delta = pop(i);
    end
end

%% ====== GWO 主要迴圈 ======
Convergence_curve = zeros(1, MaxIt); % 用來儲存收斂曲線
for it = 1:MaxIt
    a = 2 - it * (2 / MaxIt); % 控制搜索語利用的參數a(從2線性遞減到0)

    % 對每隻狼更新位置
    for i = 1 : nPop
        for j = 1 : nVar
            % α 狼貢獻
            r1 = rand();
            r2 = rand();
            A1 = 2 * a * r1 - a;
            C1 = 2 * r2;
            D_alpha = abs(C1 * alpha.Position(j) - pop(i).Position(j));
            X1 = alpha.Position(j) - A1 * D_alpha;
            % β 狼貢獻
            r1 = rand();
            r2 = rand();
            A2 = 2 * a * r1 - a;
            C2 = 2 * r2;
            D_beta = abs(C2 * beta.Position(j) - pop(i).Position(j));
            X2 = beta.Position(j) - A2 * D_beta;
            % δ 狼貢獻
            r1 = rand();
            r2 = rand();
            A3 = 2 * a * r1 - a;
            C3 = 2 * r2;
            D_delta = abs(C3* delta.Position(j) - pop(i).Position(j));
            X3 = delta.Position(j) - A3 * D_delta;

            % 最終位置為三隻領導狼貢獻的平均
            pop(i).Position(j) = (X1 + X2 + X3) / 3;
        end            

        % 邊界處理(防止超出變數範圍)
        pop(i).Position = max(pop(i).Position, VarMin);
        pop(i).Position = min(pop(i).Position, VarMax);

        % 重新計算成本與懲罰
        [pop(i).Cost, pop(i).Violation] = rastrigin(pop(i).Position);
        pop(i).Fitness = pop(i).Cost + 1e6 * pop(i).Violation;

        % 更新 α、β、δ 狼
        if pop(i).Cost < alpha.Cost
            delta = beta;
            beta = alpha;
            alpha = pop(i);
        elseif pop(i).Cost < beta.Cost
            delta = beta;
            beta = pop(i);
        elseif pop(i).Cost < delta.Cost
            delta = pop(i);
        end
    end

    % 儲存最佳成本供後續繪圖
    Convergence_curve(it) = alpha.Cost;
    disp(['迭代次數' num2str(it) '最佳成本 = ' num2str(alpha.Cost)]);
end

% 繪製收斂曲線
figure;
plot(Convergence_curve, 'LineWidth', 2);
xlabel('迭代次數');
ylabel('最佳成本');
title('GWO 收斂曲線:');

% Adjust figure properties 
set(gcf, 'Color', 'w');

% 顯示最佳結果
disp('最佳解為: ');
disp(alpha.Position);
disp(['最佳目標值:' num2str(alpha.Cost)]);
disp(['限制違反總量: ' num2str(alpha.Violation)]);