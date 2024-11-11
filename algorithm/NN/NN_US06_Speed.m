data_file = 'US06_Speed.txt';
data = readmatrix(data_file);
time = data(:, 1);
US06_Speed = data(:, 2);

input_data = time';
target_data = US06_Speed';

% Normalize data
input_data_norm = (input_data - min(input_data)) / (max(input_data) - min(input_data));
target_data_norm = (target_data - min(target_data)) / (max(target_data) - min(target_data));

% Create and train neural network
net = feedforwardnet(87);  % 10 % Create a feedforward neural network with 10 hidden neurons
net.trainParam.epochs = 500; % Set the number of training epochs
net.trainParam.goal = 0.00001; % 0.001
net.trainParam.showWindow = true;
[net, tr] = train(net, input_data_norm, target_data_norm); % Train the network

% Simulate the neural network with input data
predicted_output_norm = net(input_data_norm);

% Denormalize the predicted output (Data 還原)
predicted_output = predicted_output_norm * (max(target_data) - min(target_data)) + min(target_data);

figure;
plot(time, US06_Speed, 'b', 'LineWidth', 1.5, 'DisplayName', 'US06 Cycle'); % Actual US06 cycle
hold on;
plot(time, predicted_output, 'r--', 'LineWidth',1.5, 'DisplayName', 'Neural Network Prediction');
xlabel('Time (s)');
ylabel('Speed (s)');
title('Comparison of US06 Cycle and Neural Network Predcition');
legend('show');
grid on;

% Plot training performace
figure;
plotperform(tr);
title('Neural Network Training Performance');
