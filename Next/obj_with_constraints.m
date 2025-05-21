function [cost, total_violation] = obj_with_constraints(x)
    % === 目標函數(可改)===
    cost = rastrigin(x); % 可換成你的模型，如 fuel_cost_model(x)
    % === 不等式限制 g(x) = 0 ===
    g1 = sum(x) - 2;  % 範例限制：變數總和<=2
    g2 = -x(1) - 1;   % x(1)>= -1
    
    % === 等式限制 h(x) = 0 可轉為 |h(x)|- ε <= 0 ===
    h1 = abs(x(2)- x(3)) - 0.1; % x(2)= x(3)，容許誤差 0.1
    
    % 限制違反度計算
    penalties = [g1, g2, h1];
    total_violation = sum(max(0, penalties)); % 僅計算違反值
end