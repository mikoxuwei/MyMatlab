% clc; close all;
close all;

% Shubert function fo GA and 3D plotting over the range [-2, 2]
% Define Shubert function with elementwise operations
shufun = @(x1, x2) sum((1:5) .* cos((1:5) .* (x1 + (1:5)))) .* sum((1:5) .* cos((1:5) .* (x2 + (1:5))));

% --Shubert Function-----------------------------------

% function [y] = shubert(xx)
% xx = [x1, x2]
% x1 = xx(1); x2 = xx(2); 
% sum1 = 0; sum2 = 0; 
% for ii = 1:5
% 	new1 = ii * cos((ii+1)*x1+ii);
% 	new2 = ii * cos((ii+1)*x2+ii); 
% 	sum1 = sum1 + new1;
% 	sum2 = sum2 + new2;
% end
% y = sum1 * sum2;
% end

% ----------------------------------------------------

% Create grid for 3D plotting in the range [-2, 2]
x1_range = linspace(-2, 2, 100); % (-10, 10, 100)
x2_range = linspace(-2, 2, 100); %
[X1, X2] = meshgrid(x1_range, x2_range);

% Calculate the Shubert function values over the grid
Z = arrayfun(shufun, X1, X2);

% Plot the 3D sunface of the Shubert function
figure;
surf(X1, X2, Z);
title('3-D Plot of the Shubert Function over the range [-2, 2]');
xlabel('x1');
ylabel('x2');
zlabel('f(x1, x2)');
shading interp;
colorbar;
grid on;
%--------------------------------------------

% Now proceed to run the GA optimization
% number of variables
nvars = 2;
lb = [-2, -2]; % Lower bounds
ub = [2, 2];   % Upper bounds

% Set GA options
options = optimoptions('ga', ...
    'PopulationSize', 100, ...
    'MaxGenerations', 50, ... 
    'CrossoverFraction', 0.8, ...
    'EliteCount', 2, ...
    'PlotFcn', @gaplotbestf, ...
    'Display', 'iter');

% Run the Genetic Alogorithm solver (fitness function takes a vector input)
shufun_ga = @(x) sum((1:5) .* cos((1:5) .* (x(1) + (1:5)))) .* sum((1:5) .* cos((1:5) .* (x(2) + (1:5))));
[x, fval] = ga(shufun_ga, nvars, [], [], [], [], lb, ub, [], options);

% Display results
fprintf('Optimal solution: x1 = %f, x2 = %f\n', x(1), x(2));
fprintf('Function value at optimum: %f\n', fval);