clc;
clear;
close all;

%% 問題定義
nVar = 4;
VarSize = [1 nVar];
VarMin = [1.125 0.625 10 10];
VarMax = [12.5 12.5 200 240];

%% GWO 參數設定
MaxIt = 100;
nPop = 30;

wolf.Position = [];
wolf.Cost = [];
wolf.Violation = [];
wolf.Fitness = [];

alpha.Fitness = inf; 
beta.Fitness = inf; 
delta.Fitness = inf;

% 初始化族群
pop = repmat(wolf, nPop, 1);
for i = 1:nPop
    pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
    [pop(i).Cost, pop(i).Violation] = pressure_vessel(pop(i).Position); % 計算超出量
    pop(i).Fitness = penalized_fitness(pop(i).Cost, pop(i).Violation);% 計算罰鍰

    if pop(i).Fitness < alpha.Fitness
        delta = beta; beta = alpha; alpha = pop(i);
    elseif pop(i).Fitness < beta.Fitness
        delta = beta; beta = pop(i);
    elseif pop(i).Fitness < delta.Fitness
        delta = pop(i);
    end
end

%% GWO 主迴圈
Convergence_curve = zeros(1, MaxIt);
for it = 1:MaxIt
    a = 2 - it * (2 / MaxIt);

    for i = 1:nPop
        for j = 1:nVar
            % α
            r1 = rand(); r2 = rand();
            A1 = 2*a*r1 - a; C1 = 2*r2;
            D_alpha = abs(C1*alpha.Position(j) - pop(i).Position(j));
            X1 = alpha.Position(j) - A1*D_alpha;

            % β
            r1 = rand(); r2 = rand();
            A2 = 2*a*r1 - a; C2 = 2*r2;
            D_beta = abs(C2*beta.Position(j) - pop(i).Position(j));
            X2 = beta.Position(j) - A2*D_beta;

            % δ
            r1 = rand(); r2 = rand();
            A3 = 2*a*r1 - a; C3 = 2*r2;
            D_delta = abs(C3*delta.Position(j) - pop(i).Position(j));
            X3 = delta.Position(j) - A3*D_delta;

            % 更新位置
            pop(i).Position(j) = (X1 + X2 + X3) / 3;
        end

        % 邊界處理
        pop(i).Position = max(pop(i).Position, VarMin);
        pop(i).Position = min(pop(i).Position, VarMax);

        % 評估
        [pop(i).Cost, pop(i).Violation] = pressure_vessel(pop(i).Position);
        pop(i).Fitness = penalized_fitness(pop(i).Cost, pop(i).Violation);

        % 更新領導狼
        if pop(i).Fitness < alpha.Fitness
            delta = beta; beta = alpha; alpha = pop(i);
        elseif pop(i).Fitness < beta.Fitness
            delta = beta; beta = pop(i);
        elseif pop(i).Fitness < delta.Fitness
            delta = pop(i);
        end
    end

    Convergence_curve(it) = alpha.Cost;
    disp(['迭代次數 ' num2str(it) '，最佳成本 = ' num2str(alpha.Cost) '，違反量 = ' num2str(alpha.Violation)]);
end

%% 收斂圖
figure;
plot(Convergence_curve, 'LineWidth', 2);
xlabel('迭代次數');
ylabel('最佳成本');
title('壓力容器設計的 GWO 收斂曲線');
grid on;
set(gcf, 'Color', 'w');

%% 顯示最終結果
disp('------------------------');
disp('最佳設計解:');
disp(alpha.Position);
fprintf('最小成本: %.4f\n', alpha.Cost);
fprintf('違反總量: %.5f\n', alpha.Violation);