function f = penalized_fitness(cost, violation)
    rho = 1e4; % 懲罰係數(視問題嚴重性可調整)
    f = cost + rho * violation;
end