% 生成随机输入特征
rng(1); % 为了结果的可重复性
numInputs = 100; % 样本数量
numFeatures = 10; % 特征数量
X = rand(numInputs, numFeatures);
% 创建标签
% 假设我们有两个类别，通过输入特征的某种规则来分配标签
labels = arrayfun(@(i) mod(sum(X(i,:)), 2), 1:numInputs);
labels = categorical(labels); % 转换为categorical类型，适合分类问题
% 划分训练集和测试集
cv = cvpartition(numInputs, 'HoldOut', 0.2);
idxTrain = training(cv);
idxTest = test(cv);
XTrain = X(idxTrain, :);
YTrain = labels(idxTrain);
XTest = X(idxTest, :);
YTest = labels(idxTest);

% 创建一个简单的神经网络
hiddenLayerSize = 16; % 隐藏层神经元数量
net = patternnet(hiddenLayerSize);
% 查看网络结构
view(net);

% 设置训练选项
options = trainingOptions('sgdm', ...
'MaxEpochs', 100, ...
'ValidationData', {XTest, YTest}, ...
'ValidationFrequency', 30, ...
'Verbose', true, ...
'Plots', 'training-progress');


% 训练网络
[net, tr] = train(net, XTrain, YTrain, options);

% 使用测试集评估网络性能
YPred = classify(net, XTest);
% 计算准确率
accuracy = sum(strcmp(YPred, YTest)) / numel(YTest);
disp(['Accuracy: ', num2str(accuracy)]);
