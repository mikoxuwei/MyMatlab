% 加載文本數據(模擬數據)
num_samples = 10000; % 10 萬封郵件
num_features = 1000; % 1 萬個詞彙特徵
X = rand(num_samples, num_features); % 隨機生成文本特徵
Y = randi([0, 1], num_samples, 1); % 0 : 正常郵件, 1: 垃圾郵件

% 設定要選擇的特徵數量
k = 100;

% 使用 Matlab 內建 mRMR 函數進行特徵選擇
[selected_features, scores] = fscmrmr (X, Y);

% 選擇前 k 個最重要的特徵
top_k_features = selected_features (1:k);

% 顯示選擇的特徵索引
disp('選擇的關鍵詞特徵索引：');
disp(top_k_features) ;

% 提取選擇的特徵
X_selected = X(:, top_k_features);

% 分割訓練集和測試集
train_ratio = 0.8;
n_train = round (train_ratio * num_samples);
X_train = X_selected (1:n_train, :);
Y_train = Y(1:n_train);
X_test = X_selected(n_train+1:end, :);
Y_test = Y(n_train+1:end);

% 訓練分類器 (支持向量機 SVM)
model = fitcsvm(X_train, Y_train);

% 進行預測
Y_pred = predict(model, X_test);

% 計算準確率
accuracy = sum(Y_pred == Y_test) / length(Y_test);
disp(['分類準確率: ', num2str(accuracy * 100), '%']);