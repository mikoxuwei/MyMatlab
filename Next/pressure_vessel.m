function [cost, total_violation] = pressure_vessel(x)
    % === 設計變數 ===
    x1 = x(1); % Ts: 圓筒厚度（shell thickness）
    x2 = x(2); % Th: 頂蓋厚度（head thickness）
    x3 = x(3); % R: 圓筒內徑（inner radius）
    x4 = x(4); % L: 圓筒長度（不含頭部）
    % 將前兩個變數限制為 0.0625 的整數倍（離散變數處理可額外做）

    % === 目標函數：成本（Cost）===
    cost = 0.6224 * x1 * x3 * x4 + ...
           1.7781 * x2 * x3^2 + ...
           3.1661 * x1^2 * x4 + ...
           19.84 * x1^2 * x3;

    % === 限制式 ===
    g1 = -x1 + 0.0193 * x3;       % Ts >= 0.0193 * R
    g2 = -x2 + 0.00954 * x3;      % Th >= 0.00954 * R
    g3 = -pi * x3^2 * x4 - (4/3) * pi * x3^3 + 1296000;  % 體積 <= 1296000 in^3

    % === 違規計算 ===
    g = [g1, g2, g3];
    total_violation = sum(max(0, g)); % 只加上違規部分
end
