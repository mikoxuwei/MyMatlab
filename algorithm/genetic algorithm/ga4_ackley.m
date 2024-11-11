close all;

% Define the Ackley function
ackley = @(x) -20 * exp(-0.2 * sqrt(0.5 * (x(1)^2 + x(2)^2))) - exp(0.5 * (cos(2 * pi * x(1)) + cos(2 * pi * x(2)))) + 20 + exp(1);

% Constraaint (x^2 + y^2 <= 5)
constraint = @(x) deal([], x(1)^2 + x(2)^2 - 5);

% Lower and upper bounds
lb = [-5, -5];  % lower bounds for [x, y]
ub = [5, 5];    % upper bounds for [x, y]

% Initial point (optional for GA, not required)
x0 = [0, 0];    % initial guess [x, y]

% Genetic algorithm options (optional)
options = optimoptions('ga', 'Display', 'iter', 'PlotFcn', @gaplotbestf);

% Solve the problem using Genetic Algorithm
[x_opt, fval] = ga(ackley, 2, [], [], [], [], lb, ub, constraint, options);

% Display results
fprintf('Optimal solution: x = %.4f, y = %.4f\n', x_opt(1), x_opt(2));
fprintf('Objective functionvalue at optimum: f(x, y) = %.4f\n', fval);

% Plot the Ackley function and the solution
[X, Y] = meshgrid(linspace(-5, 5, 100), linspace(-5, 5, 100));
Z = -20 * exp(-0.2 * sqrt(0.5 * (X.^2 + Y.^2))) - exp(0.5 * (cos(2 * pi * X)+cos(2 * pi * Y))) + 20 + exp(1);

figure;
surf(X, Y, Z);
hold on;
plot3(x_opt(1), x_opt(2), fval, 'r*', 'MarkerSize', 10, 'LineWidth', 2);
xlabel('x');
ylabel('y');
zlabel('F(x, y)');
legend('Ackley Function' , 'Optimal Point');
hold off;