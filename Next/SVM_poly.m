% % 兩個 command 以外的是跟老師一樣，% % 的內容讓這個程式不用先跑SVM_linear
% % % 載入 Iris 資料庫
% % load fisheriris.mat
% % X= meas(1: 100, 1: 2);  % 取前兩個特徵
% % y= species(1: 100);
% % 
% % % 將標籤轉換為數值格式
% % y= strcmp(y, 'setosa');

% 訓練 SVM 模型 (線性核)
SVMModel= fitcsvm(X, y, 'KernelFunction', 'polynomial', 'PolynomialOrder', 3);

% 預測與視覺化分類邊界
% % d= 0.01;
% % [x1Grid, x2Grid]= meshgrid(min(X(:, 1)):d:max(X(:, 1)), min(X(:, 2)):d:max(X(:, 2)));
% % XGrid= [x1Grid(:), x2Grid(:)];
predLabels= predict(SVMModel, XGrid);

figure;
gscatter(X(:, 1), X(:, 2), y);
hold on;
contour(x1Grid, x2Grid, reshape(predLabels, size(x1Grid)), [0.5 0.5], 'k');
title('SVM with Polynomial Kernel');
hold off;