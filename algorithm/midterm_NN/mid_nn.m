% Generate example SISO data
x = linspace(-10, 10, 100)'; % Input data
y = sin(x) + 0.1 * randn(size(x)); % Output data with some noise

% Create and train a neural network
net = fitnet(10); % Create a feedforward network with 10 hidden neurons
net = train(net, x', y'); % Train the network

% Define the fitness function
fitnessFunction = @(input) net(input);

% Set options for the genetic algorithm
options = optimoptions('ga', 'Display', 'iter');

% Run the genetic algorithm to find the optimal input
[optimalInput, optimalOutput] = ga(@(input) -fitnessFunction(input), 1, [], [], [], [], -10, 10, [], options);

% The negative sign in the fitness function is used to maximize the output,
% because GA minimizes the fitness function by default.
optimalOutput = -optimalOutput;

% Display the results
fprintf('Optimal Input: %.4f\n', optimalInput);
fprintf('Optimal Output: %.4f\n', optimalOutput);

% Plot the original data
figure;
plot(x, y, 'b.');
hold on;

% Plot the neural network output
y_pred = net(x');
plot(x, y_pred, 'r-', 'LineWidth', 2);

% Plot the optimal point found by the genetic algorithm
plot(optimalInput, optimalOutput, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');

legend('Original Data', 'Neural Network Output', 'Optimal Point');
title('Neural Network with Genetic Algorithm Optimization');
xlabel('Input');
ylabel('Output');
grid on;
hold off;