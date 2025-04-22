% 二次指派問題 (QAP) 使用螞蟻群優化 (ACO)

% 參數設定
numFacilities = 10; % 設施數量
numLocations = 10; % 位置數量
numAnts = 20; % 螞蟻數量
maxIterations = 100; % 最大迭代次數
alpha = 1; % 費洛蒙的影響力
beta = 2; % 啟發式距離的影響力
rho = 0.1; % 費洛蒙蒸發率
Q = 100; % 費洛蒙強度

% 隨機生成流量和距離矩陣
flow = rand(numFacilities, numFacilities);
distance = rand(numLocations, numLocations);

% 初始化費洛蒙矩陣
pheromone = ones(numFacilities, numLocations);

% 螞蟻群優化主要迴圈
for iter = 1:maxIterations
    assignments = zeros(numAnts, numFacilities); % 儲存螞蟻的指派
    costs = zeros(numAnts, 1); % 儲存每條路徑的成本
    
    for ant = 1:numAnts
        assignment = zeros(1, numFacilities);
        
        % 為設施指派位置
        for i = 1:numFacilities
            probabilities = zeros(1, numLocations);
            for j = 1:numLocations
                if sum(assignment == j) == 0 % 如果位置 j 尚未被指派
                    probabilities(j) = pheromone(i, j) ^ alpha * (1 / distance(i, j)) ^ beta;
                else
                    probabilities(j) = 0;
                end
            end
            probabilities = probabilities / sum(probabilities); % 正規化
            
            % 為設施 i 選擇位置
            nextLocation = find(rand <= cumsum(probabilities), 1);
            assignment(i) = nextLocation;
        end
        
        % 計算總成本
        totalCost = 0;
        for i = 1:numFacilities
            for j = 1:numFacilities
                totalCost = totalCost + flow(i, j) * distance(assignment(i), assignment(j));
            end
        end
        costs(ant) = totalCost;
        assignments(ant, :) = assignment;
    end
    
    % 更新費洛蒙水平
    pheromone = (1 - rho) * pheromone;
    for ant = 1:numAnts
        for i = 1:numFacilities
            pheromone(i, assignments(ant, i)) = pheromone(i, assignments(ant, i)) + Q / costs(ant);
        end
    end
    
    % 顯示此迴圈的結果
    [minCost, bestAnt] = min(costs);
    disp(['第 ' num2str(iter) ' 次迭代：最佳成本 = ' num2str(minCost)]);
end
