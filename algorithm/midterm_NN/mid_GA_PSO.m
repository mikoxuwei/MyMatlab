% Generate example SISO data
x = linspace(0, 2, 100)'; % Input data x = [0 2]
y = x.^2 + 2 * sqrt(x) - 1; % 老師給的 x^2 + 2 * sqrt(x) - 1
y = y + 0.1 * randn(size(x)); % Output data with some noise

%% NN
% Create and train a neural network //創建並訓練神經網路
net = fitnet(10); % Create a feedforward network with 10 hidden neurons //10個隱藏神經元
net = train(net, x', y'); % Train the network

%% GA
% 使用遺傳算法 GA 來尋找最佳解
% Define the fitness function //定義適應度函數
fitnessFunction = @(input) net(input);

% Set options for the genetic algorithm
options = optimoptions('ga', 'Display', 'iter');

% Run the genetic algorithm to find the optimal input //找最佳輸入
[optimalInput, optimalOutput] = ga(@(input) -fitnessFunction(input), 1, [], [], [], [], 0, 2, [], options);

% The negative sign in the fitness function is used to maximize the output,
% because GA minimizes the fitness function by default.
% //負號用於最大化輸出, 因為默認是最小化適應度函數
optimalOutput = -optimalOutput;

% Display the results //結果
fprintf('最佳輸入（GA）: %.4f\n', optimalInput);
fprintf('最佳輸出（GA）: %.4f\n', optimalOutput);

% Plot the original data //原始數據
figure('Name','GA','NumberTitle','off');
plot(x, y, 'b.');
hold on;

% Plot the neural network output
y_pred = net(x');
plot(x, y_pred, 'r-', 'LineWidth', 2);

% Plot the optimal point found by the genetic algorithm 繪製最佳點
plot(optimalInput, optimalOutput, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');

legend('原始數據', '神經網路輸出', '最佳點（GA）');
title('使用遺傳算法的神經網路優化結果');
xlabel('輸入');
ylabel('輸出');
grid on;
hold off;

%% PSO
% 使用遺傳算法 PSO 來尋找最佳解
% 定義適應度函數，對神經網路進行輸入優化
fitnessFunction = @(input) -net(input); % 使用負號來進行最大化

% 變數數量
nvars = 1; % 單變數問題（輸入）

% 定義上下界 x = [0 2]
lb = 0; % 下界 
ub = 2; % 上界

% 使用粒子群算法進行優化
[optimalInput_PSO, optimalOutput_PSO, exitflag, output] = particleswarm(fitnessFunction, nvars, lb, ub);

% 反轉符號以獲得實際的最大化結果
optimalOutput_PSO = -optimalOutput_PSO;

% 最佳解
fprintf('最佳輸入（PSO）：%.4f\n', optimalInput_PSO);
fprintf('最佳輸出（PSO）：%.4f\n', optimalOutput_PSO);

% 繪製神經網路和PSO結果
figure('Name','PSO','NumberTitle','off');
plot(x, y, 'b.');
hold on;

% 繪製神經網路輸出
y_pred = net(x');
plot(x, y_pred, 'r-', 'LineWidth', 2);

% 繪製最佳點
plot(optimalInput_PSO, optimalOutput_PSO, 'mo', 'MarkerSize', 10, 'MarkerFaceColor', 'm');

title('使用粒子群算法的神經網路優化結果');
xlabel('輸入');
ylabel('輸出');
grid on;
legend('原始數據', '神經網路輸出', '最佳點 (PSO)');
hold off;