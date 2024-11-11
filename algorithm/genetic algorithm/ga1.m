% Genetic Algorithm options demonstration
% Create fitness function
fitnessFcn = @(x) (x(1) - 1)^2 + (x(2) - 2)^2; % 適應性函數

% number of variables
nvars = 2;

% Set GA options
options = optimoptions('ga', ...
    'PopulationSize', 100, ...
    'MaxGenerations', 12, ... % 50
    'CrossoverFraction', 0.8, ...
    'EliteCount', 2, ...
    'PlotFcn', @gaplotbestf, ...
    'Display', 'iter');

% Run the Genetic Alogorithm solver
[x, fval] = ga(fitnessFcn, nvars, [], [], [], [], [-5, -5], [5, 5], [], options);

% Display results
fprintf('Optimal solution: x1 = %f, x2 = %f\n', x(1), x(2));
fprintf('Function value at optimum: %f\n', fval);