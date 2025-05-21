%% 伺服馬達模型參數
K = 1;
tau = 0.5;
Plant = tf(K, [tau 1]);

%% ABC 參數設定
nVar= 3;                    % PID 變數 : Kp, Ki, Kd
VarSize= [1, nVar];         % 變數矩陣大小
VarMin= [0 0 0];            % 增益下限
VarMax= [10 10 2];          % 增益上限(Kd不宜過高)

MaxIt= 50;                  % 最大迭代次數
nBee= 30;                   % 蜜蜂總數
nEmp= floor(nBee / 2);      % 雇傭蜂數量
nOnlooker= nBee - nEmp;     % 圍觀蜂數量
Limit= 10;                  % 忘記解的次數上限 ( scout bee條件 )

%% 目標函數定義
CostFunction= @(x) EvaluatePID(x, Plant);

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

%% 顯示最佳PID
BestPID = BestSol.Position;
fprintf('\n最佳PID參數: Kp = %.4f, Ki = %.4f, Kd = %.4f\n', BestPID(1), BestPID(2), BestPID(3));

%% 繪製收斂圖
figure;
plot(1:MaxIt, BestCost, 'r-', 'LineWidth', 2);
xlabel('迭代次數');
ylabel('成本(IAE)');
title('ABC最佳化PID控制器');
grid on;
set(gcf, 'Color', 'w');

%% 輪盤選擇法函數
function i = RouletteWheelSelection(P)
    r = rand;
    C = cumsum(P);
    i = find(r <= C, 1, 'first');
end

%% 評估成本函數:IAE
function J = EvaluatePID(x, Plant)
    Kp = x(1);
    Ki = x(2);
    Kd = x(3);

    % PID 控制器
    C = pid(Kp, Ki, Kd);

    % 閉迴路系統
    T = feedback(C * Plant, 1);

    % 階躍響應
    t = 0:0.01:5;
    y = step(T, t);

    % 計算IAE(積分絕對誤差)
    e = 1- y;
    J = trapz(t, abs(e));
end