clc;
clear;
close all;

% Step 1: 輸入風速資料 (m/s) 與 輸出功率資料 (W)
WindSpeeds = [3.5, 4.0, 3.8, 4.2, 4.5, 5.0, 6.0, 7.2, 8.5, 7.8, ...
              6.5, 5.5, 4.3, 4.5, 5.2, 6.0, 7.5, 8.0, 7.2, 6.8, ...
              5.5, 4.2, 3.8, 3.5]';

% 輸出功率資料 (W)
Pout = [20.7, 35.3, 28.8, 42.9, 56.6, 86.2, 178.8, 370.7, ...
            720.0, 510.5, 246.2, 126.2, 47.2, 56.6, 100.8, 178.8, ...
            436.4, 565.0, 370.7, 294.9, 126.2, 42.9, 28.8, 20.7]';

% Step 2: 每筆風速對應每筆負載 (以最大功率為基準計算百分比)
P_max = max(Pout);
load_percent = (Pout / P_max) * 100;

% Step 3: 顯示完整訓練資料表格
training_data = table(WindSpeeds, load_percent);
training_data.Properties.VariableNames = {'WindSpeed', 'LoadPercent'};
disp('完整訓練資料：');
disp(training_data);

% Step 4: 使用 RVM 訓練模型 (替換 SVM 為 RVM)
% 使用 fitrvm 來建立 RVM 回歸模型
RVMModel = fitrvm(WindSpeeds, load_percent, 'KernelFunction', 'gaussian', 'KernelScale', 'auto');

% Step 5: 建立測試風速區間並預測對應負載
test_wind = linspace(min(WindSpeeds), max(WindSpeeds), 100)';
predicted_load = predict(RVMModel, test_wind);

% Step 6: 繪圖 、 標註每個訓練資料點 及 設定圖表格式
figure;
plot(WindSpeeds, load_percent, 'ro', 'MarkerFaceColor', 'r', 'DisplayName', '訓練資料');
hold on;
plot(test_wind, predicted_load, 'b-', 'LineWidth', 1.5, 'DisplayName', 'RVM預測');

% 在圖中標註每個訓練資料點的數值
for i = 1:length(WindSpeeds)
    txt = sprintf('(%.1f, %.1f)', WindSpeeds(i), load_percent(i));
    text(WindSpeeds(i)+0.05, load_percent(i)-1, txt, 'FontSize', 8, 'Color', 'k');
end

% 設定圖表格式
xlabel('風速 (m/s)');
ylabel('最佳負載 (%)');
title('根據風速穩定 RPM 所需負載');
legend('Location', 'northwest');
xlim([min(WindSpeeds)-0.5, max(WindSpeeds)+0.5]);
ylim([min(load_percent)-3, max(load_percent)+1])
grid on;