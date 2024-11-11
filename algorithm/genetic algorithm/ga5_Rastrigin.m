close all;

% Define the Rastrigin function as an anonymous function
rastrigin = @(x) 20 + x(1)^2 + x(2)^2 - 10 * (cos(2 * pi * x(1)) + cos(2 * pi * x(2)));

% Lower and upper bounds
lb = [-5, -5];  % lower bounds for [x, y]
ub = [5, 5];    % upper bounds for [x, y]

% Genetic algorithm options (optional)
options = optimoptions('ga', 'Display', 'iter', 'PlotFcn', {@gaplotbestf, @gaplotstopping});

% Solve the problem using Genetic Algorithm (GA)
[x_opt, fval] = ga(rastrigin, 2, [], [], [], [], lb, ub, [], options);

% Display the results
fprintf('Optimal solution: x = %.4f, y = %.4f\n', x_opt(1), x_opt(2));
fprintf('Objective functionvalue at optimum: f(x, y) = %.4f\n', fval);

% --------------------------------------------------------------------

% Create a mesh grid for the Rastrigin function over the bounds
[X, Y] = meshgrid(linspace(-5, 5, 100), linspace(-5, 5, 100));

% Compute the Rastrigin function valuesover the grid 
Z = 20 + X.^2 + Y.^2 - 10 * (cos(2 * pi * X) + cos(2 * pi * Y));

% Plot the Rastrigin function surface
figure;
surf(X, Y, Z);
hold on;

% Plot the optimal solution found by GA
plot3(x_opt(1), x_opt(2), fval, 'rp', 'MarkerSize', 12, 'MarkerEdgeColor','r', 'DisplayName', 'Optimal Point');

% Annotate the optimal solution
text(x_opt(1), x_opt(2), fval + 10, sprintf('Optimal: (%.2f, %.2f)', x_opt(1), x_opt(2)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 10, 'Color', 'k');

% Add labels and title
title('Rastrigin Function with Optimal Solution')
xlabel('x');
ylabel('y');
zlabel('f(x, y)');
legend('Rastrigin Function' , 'Optimal Point');

% Set view angle for better visualization
view(135, 45);

% Adjust the plot for better visibility
shading interp;     % smooth color transition
colorbar;           % show color scale
hold off;