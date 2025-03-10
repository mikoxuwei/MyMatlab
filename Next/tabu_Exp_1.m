% Example 1: 利用 Tabu Search 求解 旅行銷售員問題 (TSP)
% 此程式示範如何使用 Tabu 搜索求解城市巡迴問題

clear; clc; close all;

% 定義城市座標（示範用的五個城市）
cities = [11.5, 17.8; 21.3, 33.3; 52.7, 11.4; 47.7, 9.2; 56.6, 10.9];
numCities = size(cities, 1);

% 初始解：隨機排列城市順序
currentSolution = randperm(numCities);   % 擲骰子決定哪個城市
bestSolution = currentSolution;
bestDistance = computeTotalDistance(cities, bestSolution); % 計算周遊各城市後的最佳距離

% Tabu 清單參數設定
tabuList = [];  % 建立 tabu 列表空間
maxTabuSize = 5;   % 城市數量
maxIterations = 25;  % 疊代次數

% 主程式迴圈
for iter = 1:maxIterations
    neighborhood = generateNeighborhood(currentSolution); % 產生候補
    candidateSolution = [];
    candidateDistance = inf;  % 不定義候補者的距離
    
    for i = 1:length(neighborhood)
        sol = neighborhood{i};
        if ~isTabu(sol, tabuList)
            dist = computeTotalDistance(cities, sol);
            if dist < candidateDistance   % 如果候補距離大於當前距離
                candidateDistance = dist;  % 換掉候補
                candidateSolution = sol;
            end
        end
    end
    
    % 更新目前解並加入 Tabu 清單
    if ~isempty(candidateSolution)   % 如果候補清單是空的?
        currentSolution = candidateSolution;  % 加入候補
        tabuList = [tabuList; candidateSolution];   % 將候補加入候補清單中
        if size(tabuList,1) > maxTabuSize
            tabuList(1,:) = [];
        end
        if candidateDistance < bestDistance    % 如果當前最佳距離大於候補?
            bestDistance = candidateDistance;  % 更新最佳距離
            bestSolution = candidateSolution;  % 更新最佳解
        end
   
    end
   % 螢幕顯示搜尋過程
   fprintf('疊代次數 %d: 當次路徑: %d,%d,%d,%d,%d, 總距離: %.6f\n', iter, bestSolution, bestDistance); 
end

disp('最佳路徑:');
disp(bestSolution);
disp('總距離:');
disp(bestDistance);

% 計算巡迴路徑總距離的函數
function totalDist = computeTotalDistance(cities, tour)
    totalDist = 0;
    for j = 1:length(tour)-1
        totalDist = totalDist + norm(cities(tour(j),:)-cities(tour(j+1),:));
    end
    % 返回起始城市的距離
    totalDist = totalDist + norm(cities(tour(end),:)-cities(tour(1),:));
end

% 產生鄰域解：透過兩兩交換城市位置
function neighborhood = generateNeighborhood(solution)
    neighborhood = {};
    n = length(solution);
    for i = 1:n-1
        for j = i+1:n
            newSol = solution;
            newSol([i j]) = newSol([j i]);
            neighborhood{end+1} = newSol;
        end
    end
end

% 判斷解是否在 Tabu 清單中的函數
function flag = isTabu(solution, tabuList)
    flag = false;
    for i = 1:size(tabuList,1)
        if isequal(solution, tabuList(i,:))
            flag = true;
            break;
        end
    end
end
