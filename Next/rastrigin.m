function z = rastrigin(x)
    % Rastrigin 函數 ( 常用的非線性測試函數)
    % 最小值為 0，發生在 x = [0, 0, ..., 0]
    z = 10 * numel(x) + sum(x.^2 - 10 * cos(2 * pi * x));
end
