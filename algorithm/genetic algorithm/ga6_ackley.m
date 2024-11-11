close all;

% Ackley function definition
ackley = @(x) -20 * exp(-0.2 * sqrt(0.5 * (x(1)^2 + x(2)^2))) - exp(0.5 * (cos(2 * pi * x(1)) + cos(2 * pi * x(2)))) + 20 + exp(1);

% Nonlineaar constraint: Circular boundary x^2 + y^2 <= 1.5^2
nonlcon = @(x) deal([], x(1)^2 + x(2)^2 - 1.5^2); % Inequality: x^2 + y^2 - 1.5^2 <= 0

% Lower and upper bounds
lb = [-5, -5];  % lower bounds for [x, y]
ub = [5, 5];    % upper bounds for [x, y]

% Initial point (optional for GA, not required)
x0 = [0, 0];    % initial guess [x, y]

% Genetic algorithm options (optional)
options = optimoptions('ga', 'Display', 'iter', 'PlotFcn', {@gaplotbestf, @gaplotstopping});

% Solve the problem using Genetic Algorithm
[x_opt, fval] = ga(ackley, 2, [], [], [], [], lb, ub, nonlcon, options);

% Display results
fprintf('Optimal solution: x = %.4f, y = %.4f\n', x_opt(1), x_opt(2));
fprintf('Objective functionvalue at optimum: f(x, y) = %.4f\n', fval);

% --------------------------------------------------------------------

% Plot the Ackley function surface with the optimal solution
[X, Y] = meshgrid(linspace(-5, 5, 100), linspace(-5, 5, 100));
Z = -20 * exp(-0.2 * sqrt(0.5 * (X.^2 + Y.^2))) - exp(0.5 * (cos(2 * pi * X)+cos(2 * pi * Y))) + 20 + exp(1);

% Plot the Ackley function surface
figure;
surf(X, Y, Z);
hold on;

% Plot the optimal solution found by GA
plot3(x_opt(1), x_opt(2), fval, 'rp', 'MarkerSize', 12, 'MarkerEdgeColor','r');

% Annotate the optimal solution
text(x_opt(1), x_opt(2), fval + 1, sprintf('Optimal: (%.2f, %.2f)', x_opt(1), x_opt(2)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 10, 'Color', 'k');

% Add labels and title
title('Ackley Function with Optimal Solution')
xlabel('x');
ylabel('y');
zlabel('f(x, y)');
legend('Ackley Function' , 'Optimal Point');

% Set view angle for better visualization
view(135, 45);

% Adjust the plot for better visibility
shading interp;     % smooth color transition
colorbar;           % show color scale
hold off;