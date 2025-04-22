% 旅行員推銷問題 (TSP) 使用螞蟻群優化 (ACO)

% 參數設定
numCities = 10; % 城市數量
numAnts = 20; % 螞蟻數量
maxIterations = 100; % 最大迭代次數
alpha = 1; % 費洛蒙的影響力
beta = 2; % 啟發式距離的影響力
rho = 0.1; % 費洛蒙蒸發率
Q = 100; % 費洛蒙強度

% 隨機生成城市座標
cities = rand(numCities, 2);
distances = ;

% 初始化費洛蒙矩陣
pheromone = ones(numCities, numCities);

% 螞蟻群優化主要迴圈
for iter = 1:maxIterations % 迭代迴圈
    assignments = zeros(numAnts, numCities); % 儲存螞蟻的指派
    costs = zeros(numAnts, 1); % 儲存每條路徑的成本
    
    for ant = 1:numAnts
        paths = zeros(1, numCities);
        visited = false(1, numCities); % 螞蟻的記憶(拜訪過的)




        % 為設施指派位置
        for i = 1:numCities
            probabilities = zeros(1, numCities); % 儲存選擇機率
            for j = 1:numLocations
                if ~visited(city) % 機率公式
                    probabilities(city) = pheromone(currentCity, city) ^ alpha * (1 / distances(currentCity, city)) ^ beta;
                else
                    probabilities(city) = 0; % 若以拜訪過，機率 = 0
                end
            end

            % 基於概率選擇下一個城市
            probabilities = probabilities / sum(probabilities); % 正規化所有機率
            nextCity = find(rand <= cumsum(probabilities), 1); % 比較機率和隨機值
            path(step) = nextCity;
            visited(nextCity) = true;
            
            % 計算路徑長度
            pathLength = sum(distances(sub2ind(size(distances), path(1:end-1), path(2:end))));
            paths(i) = nextLocation;
        end
        
        % 計算總成本
        totalCost = 0;
        for i = 1:numCities
            for j = 1:numCities
                totalCost = totalCost + cities(i, j) * distance(paths(i), paths(j));
            end
        end
        costs(ant) = totalCost;
        assignments(ant, :) = paths;
    end
    
    % 更新費洛蒙水平
    pheromone = (1 - rho) * pheromone;
    for ant = 1:numAnts
        for i = 1:numCities
            pheromone(i, assignments(ant, i)) = pheromone(i, assignments(ant, i)) + Q / costs(ant);
        end
    end
    
    % 顯示此迴圈的結果
    [minCost, bestAnt] = min(costs);
    disp(['第 ' num2str(iter) ' 次迭代：最佳成本 = ' num2str(minCost)]);
end
