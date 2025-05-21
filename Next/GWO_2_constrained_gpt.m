clc; clear;

%% 問題定義
nVar = 5;
VarSize = [1 nVar];
VarMin = -5.12;
VarMax = 5.12;

%% GWO 參數設定
MaxIt = 100;
nPop = 30;

% 初始化狼群
wolf.Position = [];
wolf.Cost = [];
wolf.Violation = [];
wolf.Fitness = [];

% 初始化三個領導狼（初始化所有欄位）
alpha.Fitness = inf;
beta.Fitness = inf;
delta.Fitness = inf;


% 產生初始狼群
pop = repmat(wolf, nPop, 1);

for i = 1:nPop
    pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
    [pop(i).Cost, pop(i).Violation] = obj_with_constraints(pop(i).Position);
    pop(i).Fitness = pop(i).Cost + 1e6 * pop(i).Violation;

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

%% GWO 主要迴圈
Convergence_curve = zeros(1, MaxIt);
for it = 1:MaxIt
    a = 2 - it * (2 / MaxIt);

    for i = 1:nPop
        for j = 1:nVar
            r1 = rand(); r2 = rand();
            A1 = 2 * a * r1 - a; C1 = 2 * r2;
            D_alpha = abs(C1 * alpha.Position(j) - pop(i).Position(j));
            X1 = alpha.Position(j) - A1 * D_alpha;

            r1 = rand(); r2 = rand();
            A2 = 2 * a * r1 - a; C2 = 2 * r2;
            D_beta = abs(C2 * beta.Position(j) - pop(i).Position(j));
            X2 = beta.Position(j) - A2 * D_beta;

            r1 = rand(); r2 = rand();
            A3 = 2 * a * r1 - a; C3 = 2 * r2;
            D_delta = abs(C3 * delta.Position(j) - pop(i).Position(j));
            X3 = delta.Position(j) - A3 * D_delta;

            pop(i).Position(j) = (X1 + X2 + X3) / 3;
        end

        pop(i).Position = max(pop(i).Position, VarMin);
        pop(i).Position = min(pop(i).Position, VarMax);

        [pop(i).Cost, pop(i).Violation] = obj_with_constraints(pop(i).Position);
        pop(i).Fitness = pop(i).Cost + 1e6 * pop(i).Violation;

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

    Convergence_curve(it) = alpha.Fitness;
    disp(['迭代次數 ' num2str(it) '，最佳成本 = ' num2str(alpha.Fitness)]);
end

% 繪圖
figure;
plot(Convergence_curve, 'LineWidth', 2);
xlabel('迭代次數');
ylabel('最佳成本');
title('GWO 收斂曲線');
set(gcf, 'Color', 'w');

% 顯示最終結果
disp('最佳解為:');
disp(alpha.Position);
fprintf('最佳目標值: %.10f\n', alpha.Cost);
fprintf('限制違反總量: %.5f\n', alpha.Violation);