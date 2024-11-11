% MATLAB script for training a neural network to recognize sin(x) for
% 0<x<2*pi
clc; clear; close all;

% Step 1:generate training data
x = linspace(-2, 2, 100);
y = 1 + sin(6 * pi / 4 * x);

% Step 2: create and train a feedforward neural network
net = feedforwardnet(8);
net = train(net, x, y);

% Step 3: Use the trained network to predict values
y_pred = net(x);

% Step 4: Plot the comparison

figure;
plot(x, y, 'b-', 'LineWidth', 2);
hold on;
plot(x, y_pred, 'r--', 'LineWidth',2);
legend('True \sin(x', 'NN Output');
xlabel('x');
ylabel('y');
title('Comparison of True \sin(x) and Neural Network Output');
grid on;
hold off;