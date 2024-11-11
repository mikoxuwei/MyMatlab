x = linspace(0, 2 * pi, 30);	 % 在 0 到 2π 間，等分取 30 個點 
y = sin(x);  
e = y * 0.2;  
errorbar(x, y, e)				     % 圖形上加上誤差範圍 e


% fplot('sin(1/x)', [0.02 0.2]);
fplot(@(x)sin(1./x), [0.02 0.2]);      % [0.02 0.2]是繪圖範圍
% 對於變化劇烈的函數，可用 fplot 指令來進行較精確的取點作圖，此指令會對劇烈變化處進行較密集的取樣

theta = linspace(0, 2*pi);
r = cos(4 * theta);
polarplot(theta, r);	% 進行極座標繪圖


x = randn(10, 1);	        % 產生 10000 個正規分佈亂數  
histogram(x, 5);		    % 繪出直方圖，顯示 x 資料的分佈情況和統計特性，
			                        % 數字 25 代表資料依大小分堆的堆數，即是直方圖內長條的個數


x = randn(5000, 1);  
polarhistogram(x);	% x 資料大小為角度，x 資料個數為距離，
			                    % 進行繪製類似玫瑰花瓣的極座標質方圖


theta = linspace(0, 2*pi, 50);
rho = sin(0.5*theta);
[x, y] = pol2cart(theta, rho);	% 由極座標轉換至直角座標
compass(x, y);			% 畫出以原點為向量起始點的羅盤圖