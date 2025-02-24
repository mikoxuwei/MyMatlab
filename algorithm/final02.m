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

% 保存到工作空間，並啟動 nftool
save('nn_data.mat', 'inputs', 'targets');
disp('數據已準備好，啟動 Neural Network Fitting Tool (nftool)。');
% nftool;

% 自動化神經網路訓練
hiddenLayerSize = 16; % 設置隱藏層神經元數量
net = fitnet(hiddenLayerSize);

% 將數據分割為訓練、驗證和測試集
[net, tr] = train(net, inputs, targets);

% 測試神經網路
outputs = net(inputs);
performance = perform(net, targets, outputs);

% 顯示結果
disp(['訓練完成，性能指標（MSE）：', num2str(performance)]);
view(net); % 可視化網路結構
