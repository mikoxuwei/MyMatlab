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

% 自動化神經網路訓練
hiddenLayerSize = 16; % 設置隱藏層神經元數量
net = fitnet(hiddenLayerSize);

% 將數據分割為訓練、驗證和測試集
[net, tr] = train(net, inputs, targets);

% 測試神經網路
outputs = net(inputs);
performance = perform(net, targets, outputs);

% 顯示訓練結果
disp(['訓練完成，性能指標（MSE）：', num2str(performance)]);
view(net); % 可視化網路結構

%% 使用 GA 進行優化
% 定義適應度函數，負號是為了最大化氫氣產率
fitnessFunction = @(input) -net(input');

% 定義變數上下界（輸入參數範圍）
lb = [250, 0.2, 120, 350, 120, 5.4, 0.02]; % 各參數下界
ub = [700, 0.5, 390, 700, 480, 382, 1.4];  % 各參數上界

% 設定遺傳算法選項
options = optimoptions('ga', ...
    'Display', 'iter', ...
    'PopulationSize', 100, ...
    'MaxGenerations', 100, ...
    'UseParallel', false);

% 執行遺傳算法
[optimalInput_GA, optimalOutput_GA] = ga(fitnessFunction, 7, [], [], [], [], lb, ub, [], options);

% 反轉符號以獲得實際的最大化結果
optimalOutput_GA = -optimalOutput_GA;

% 顯示最佳解
fprintf('最佳輸入（GA）：\n');
disp(array2table(optimalInput_GA, 'VariableNames', ...
    {'ReactionTemp', 'CatalystWeight', 'TimeOnStream', ...
     'CalcinationTemp', 'CalcinationTime', 'SurfaceArea', 'PoreVolume'}));
fprintf('最佳輸出（氫氣產率, GA）：%.4f%%\n', optimalOutput_GA);

%% 繪製結果
figure;
subplot(2, 1, 1);
plot(1:num_samples, targets, 'b.', 'DisplayName', '原始數據');
hold on;
plot(1:num_samples, outputs, 'r-', 'LineWidth', 2, 'DisplayName', '神經網路輸出');
title('神經網路預測與實際數據比較');
xlabel('樣本索引');
ylabel('氫氣產率 (%)');
legend;
grid on;

subplot(2, 1, 2);
bar(optimalInput_GA, 'FaceColor', 'm');
xticklabels({'ReactionTemp', 'CatalystWeight', 'TimeOnStream', ...
             'CalcinationTemp', 'CalcinationTime', 'SurfaceArea', 'PoreVolume'});
title('最佳輸入參數（GA 優化）');
xlabel('參數');
ylabel('數值');
grid on;
