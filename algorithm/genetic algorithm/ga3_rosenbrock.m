clc; close all;

% Define the Rosenbrock function
a = 100; % Parameter for the Rosenbrock function

% Objective function to minimize
rosenbrock = @(x) log(1 + a*(x(2) - x(1)^2)^2 + (1 - x(1))^2);

% Constraints (x^2 + y^2 <= 1)
constraint = @(x) deal([], x(1)^2 + x(2)^2 - 1);

% Lower and upper bounds
lb = [-3, -2]; % lower bounds for [x, y]
ub = [3, 9]; % upper bounds for [x, y]

% Initial point
x0 = [-2, 2]; %initial guess [x, y]

% Genetic alorithm options (optional)
% options = optimoptions('ga', 'Display', 'iter', 'PlotFcn', @gaplotbestf);

% number of variables
nvars = 2;

% Set GA options
options = optimoptions('ga', ...
    'PopulationSize', 100, ...
    'MaxGenerations', 50, ... 
    'CrossoverFraction', 0.8, ...
    'EliteCount', 2, ...
    'PlotFcn', @gaplotbestf, ...
    'Display', 'iter');



% Solve the problem using Genetic Algorithm
[x_opt, fval] = ga(rosenbrock, nvars, [], [], [], [], lb, ub, constraint, options);

% Display results
fprintf('Optimal solution: x = %.4f, y = %.4f\n', x_opt(1), x_opt(2));
fprintf ('Objective function value at optimum: f(x, y) = %.4f\n', fval);

% Plot the Rosenbrock function and the solution
[X, Y] = meshgrid(linspace(-3, 3, 100), linspace(-2, 9, 100));
Z = log(1 + a*(Y - X.^2).^2 + (1 - X).^2);

figure;
surf(X, Y, Z);
hold on;
% 最佳化的點用紅色 * 畫起來
plot3(x_opt(1), x_opt(2), fval, 'r*', 'MarkerSize', 10, 'LineWidth', 2);
title('Rosenbrock function with Optimal Solution');
xlabel('x');
ylabel('y');
zlabel('f(x, y)');
legend('Rosenbrock function', 'Optimal Point');
hold off;
