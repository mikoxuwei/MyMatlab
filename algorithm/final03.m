% 清空工作空間
clear;
clc;

% 設置隨機數種子，確保結果一致
rng(42);

% 生成數據樣本數量
num_samples = 500; % 樣本數量

% 隨機生成各參數數據
ReactionTemp = 250 + (700 - 250) * rand(num_samples, 1);    % 反應溫度 (°C)
CatalystWeight = 0.2 + (0.5 - 0.2) * rand(num_samples, 1);  % 催化劑重量 (g)
TimeOnStream = 120 + (390 - 120) * rand(num_samples, 1);    % 反應時間 (min)
CalcinationTemp = 350 + (700 - 350) * rand(num_samples, 1); % 焙燒溫度 (°C)
CalcinationTime = 120 + (480 - 120) * rand(num_samples, 1); % 焙燒時間 (min)
SurfaceArea = 5.4 + (382 - 5.4) * rand(num_samples, 1);     % 比表面積 (m²/g)
PoreVolume = 0.02 + (1.4 - 0.02) * rand(num_samples, 1);    % 孔體積 (cm³/g)

% 假設的氫氣產率
HydrogenYield = 12 + (84 - 12) * rand(num_samples, 1);      % 氫氣產率 (%)

% 整合輸入和輸出
inputs = [ReactionTemp, CatalystWeight, TimeOnStream, CalcinationTemp, ...
          CalcinationTime, SurfaceArea, PoreVolume]';  % 7 個參數輸入
targets = HydrogenYield';                              % 產率作為目標

% 保存數據
save('nn_data.mat', 'inputs', 'targets');

% 使用 GA 優化神經網路
disp('開始優化神經網路結構...');

% 定義 GA 的參數
popSize = 20; % 群體大小
maxGen = 50;  % 最大代數

% 定義 GA 目標函數
fitnessFunction = @(x) optimizeMLP(x, inputs, targets);

% 設定變數範圍：隱藏層數量（1到50個神經元）
lb = 5; % 最少神經元
ub = 50; % 最多神經元

% 使用 GA 優化
options = optimoptions('ga', ...
    'PopulationSize', popSize, ...
    'MaxGenerations', maxGen, ...
    'Display', 'iter');

[bestSolution, bestScore] = ga(fitnessFunction, 1, [], [], [], [], lb, ub, [], options);

disp(['最佳隱藏層神經元數量：', num2str(round(bestSolution))]);
disp(['最佳性能指標（MSE）：', num2str(bestScore)]);

% 使用最佳解訓練 MLP
hiddenLayerSize = round(bestSolution);
net = fitnet(hiddenLayerSize);
[net, tr] = train(net, inputs, targets);

% 顯示結果
outputs = net(inputs);
performance = perform(net, targets, outputs);
disp(['最終訓練性能指標（MSE）：', num2str(performance)]);
view(net); % 可視化網路結構


% 定義目標函數
function mse = optimizeMLP(x, inputs, targets)
    % x: 隱藏層神經元數量
    hiddenLayerSize = round(x); % 四捨五入取整數
    net = fitnet(hiddenLayerSize);
    % 設定訓練參數
    net.trainParam.showWindow = false; % 關閉視窗顯示
    net.trainParam.showCommandLine = false;
    % 訓練網絡
    [net, ~] = train(net, inputs, targets);
    % 預測結果
    outputs = net(inputs);
    mse = perform(net, targets, outputs); % 計算 MSE
end
