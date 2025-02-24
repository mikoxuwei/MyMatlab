% 清空工作空间并设置随机数种子，确保结果一致
clear;
clc;
rng(42);

% 参数统计特性（基于表格）
param_stats = struct( ...
    'Range',      [250, 0.2, 120, 350, 120, 5.4, 0.02; ... % 最小值
                   450, 0.3, 270, 525, 300, 193.5, 0.71; ... % 平均值
                   700, 0.5, 390, 700, 480, 382, 1.4], ... % 最大值
    'StdError',   [11.909, 0.010, 11.773, 10.781, 9.861, 9.702, 0.033], ...
    'StdDev',     [98.206, 0.083, 97.083, 88.901, 81.315, 80.004, 0.269]);

% 样本数量
num_samples = 500; % 样本数量

% 参数数量（7 个参数）
num_params = size(param_stats.Range, 2);

% 初始化数据矩阵
data = zeros(num_samples, num_params);

% 根据范围和标准差生成数据
for i = 1:num_params
    % 提取参数统计特性
    min_val = param_stats.Range(1, i);
    max_val = param_stats.Range(3, i);
    std_dev = param_stats.StdDev(i);
    
    % 正态分布生成数据，并裁剪到范围内
    data(:, i) = normrnd(param_stats.Range(2, i), std_dev, [num_samples, 1]); 
    data(:, i) = max(min(data(:, i), max_val), min_val); % 限制范围
end

% 分配数据到变量
ReactionTemp = data(:, 1);      % 反应温度 (°C)
CatalystWeight = data(:, 2);    % 催化剂重量 (g)
TimeOnStream = data(:, 3);      % 反应时间 (min)
CalcinationTemp = data(:, 4);   % 焙烧温度 (°C)
CalcinationTime = data(:, 5);   % 焙烧时间 (min)
SurfaceArea = data(:, 6);       % 比表面积 (m²/g)
PoreVolume = data(:, 7);        % 孔体积 (cm³/g)

% 假设氢气产率并加入噪声
HydrogenYield = 12 + (84 - 12) * rand(num_samples, 1) + normrnd(0, 13.889, [num_samples, 1]);

% 整合输入和输出
inputs = [ReactionTemp, CatalystWeight, TimeOnStream, CalcinationTemp, ...
          CalcinationTime, SurfaceArea, PoreVolume]';  % 7 个参数输入
targets = HydrogenYield';                              % 氢气产率

%% 神经网络训练 (NN)
% 创建并训练神经网络
net = fitnet(10); % 创建含有 10 个隐藏层神经元的前馈网络
net = train(net, inputs, targets); % 训练网络

% 测试神经网络
outputs = net(inputs);
performance = perform(net, targets, outputs); % 计算性能指标

% 显示结果
fprintf('神经网络训练完成，性能指标（MSE）：%.4f\n', performance);
view(net); % 可视化网络结构

%% 遗传算法优化 (GA)
% 定义适应度函数，负号用于最大化目标
fitnessFunction = @(input) -net(input');

% 定义变量上下界
lb = param_stats.Range(1, :); % 参数下界
ub = param_stats.Range(3, :); % 参数上界

% 设置遗传算法选项
options = optimoptions('ga', ...
    'Display', 'iter', ...
    'PopulationSize', 100, ...
    'MaxGenerations', 100);

% 运行遗传算法
[optimalInput_GA, optimalOutput_GA] = ga(fitnessFunction, 7, [], [], [], [], lb, ub, [], options);

% 转换适应度值
optimalOutput_GA = -optimalOutput_GA;

% 显示优化结果
fprintf('最佳输入（GA）：\n');
disp(array2table(optimalInput_GA, 'VariableNames', ...
    {'ReactionTemp', 'CatalystWeight', 'TimeOnStream', ...
     'CalcinationTemp', 'CalcinationTime', 'SurfaceArea', 'PoreVolume'}));
fprintf('最佳输出（氢气产率, GA）：%.4f%%\n', optimalOutput_GA);

%% 可视化结果
figure('Name', 'GA 优化结果', 'NumberTitle', 'off');

% 子图 1：网络预测和实际数据
subplot(2, 1, 1);
plot(1:num_samples, targets, 'b.', 'DisplayName', '原始数据');
hold on;
plot(1:num_samples, outputs, 'r-', 'LineWidth', 2, 'DisplayName', '神经网络输出');
title('神经网络预测与实际数据比较');
xlabel('样本索引');
ylabel('氢气产率 (%)');
legend;
grid on;

% 子图 2：GA 找到的最佳输入
subplot(2, 1, 2);
bar(optimalInput_GA, 'FaceColor', 'm');
xticklabels({'ReactionTemp', 'CatalystWeight', 'TimeOnStream', ...
             'CalcinationTemp', 'CalcinationTime', 'SurfaceArea', 'PoreVolume'});
title('最佳输入参数（GA 优化）');
xlabel('参数');
ylabel('值');
grid on;
