z = [0 2 1; 3 2 4; 4 4 4; 7 6 8];
mesh(z);
xlabel('X 軸 = column index');	% X 軸的說明文字
ylabel('Y 軸 = row index');	    % Y 軸的說明文字
% colormap(zeros(1,3));		    % 以黑色呈現

z = [0 2 1; 3 2 4; 4 4 4; 7 6 8];
mesh(z);
xlabel('X 軸 = column index');	% X 軸的說明文字
ylabel('Y 軸 = row index');	% Y 軸的說明文字

for i = 1:size(z, 1)
	for j = 1:size(z, 2)
		h=text(j, i, z(i, j), num2str(z(i, j)));		% 標示曲面高度
		set(h, 'hori', 'center', 'vertical', 'bottom', 'color', 'r');	% 改變位置及顏色
	end
end

%colormap(zeros(1, 3));		% 以黑色呈現


x = 3 : 6;
y = 5 : 9;
[xx, yy] = meshgrid(x, y);		% xx 和 yy 都是矩陣  
zz = xx .* yy;				% 計算函數值 zz，也是矩陣
subplot(2, 2, 1); mesh(xx);
title('xx'); axis tight
subplot(2, 2, 2); mesh(yy);
title('yy'); axis tight
subplot(2, 2, 3); mesh(xx, yy, zz);
title('zz 對 xx 及 yy 作圖'); axis tight

figure;
x = linspace(-2, 2, 25);	% 在 x 軸 [-2, 2] 之間取 25 點  
y = linspace(-2, 2, 25);	% 在 y 軸 [-2, 2] 之間取 25 點  
[xx, yy] = meshgrid(x, y);	% xx 和 yy 都是 25×25 的矩陣  
zz = xx .* exp(-xx .^ 2 - yy .^ 2);	% 計算函數值，zz 也是 25×25 的矩陣
mesh(xx, yy, zz);		% 畫出立體網狀圖 
%colormap(zeros(1, 3));		% 以黑色呈現

x = linspace(-2, 2, 25);		% 在 x 軸 [-2,2] 之間取 25 點  
y = linspace(-2, 2, 25);		% 在 y 軸 [-2,2] 之間取 25 點  
[xx, yy] = meshgrid(x, y);		% xx 和 yy 都是 25×25 的矩陣  
zz = xx .* exp(-xx .^ 2 - yy .^ 2);		% zz 也是 25×2 的矩陣  
surf(xx, yy, zz);				% 畫出立體曲面圖  
colormap('default')				% 顏色改回預設值


subplot(2, 2, 1);
peaks
% z =  3*(1-x).^2.*exp(-(x.^2) - (y+1).^2) 
% - 10*(x/5 - x.^3 - y.^5).*exp(-x.^2-y.^2) 
% - 1/3*exp(-(x+1).^2 - y.^2)
% MATLAB 提供了一個 peaks 函數，可產生一個凹凸有致的曲面，
% 包含了三個局部極大點（Local Maxima）及三個局部極小點（Local Minima)

subplot(2, 2, 2);
x = linspace(-3, 3, 50);		% 在 x 軸 [-2,2] 之間取 25 點  
y = linspace(-3, 3, 50);		% 在 y 軸 [-2,2] 之間取 25 點  
[xx, yy] = meshgrid(x, y);		% xx 和 yy 都是 25×25 的矩陣  
zz =  3*(1-xx).^2.*exp(-(xx.^2) - (yy+1).^2) ... 
- 10*(xx/5 - xx.^3 - yy.^5).*exp(-xx.^2-yy.^2) ... 
- 1/3*exp(-(xx+1).^2 - yy.^2);

surf(xx, yy, zz);	
colormap('default')
xlabel('x')
ylabel('y')
axis tight
title('Function Plots of Peaks')

subplot(2, 2, 3);
[x, y, z] = peaks;  
meshz(x, y, z);  
axis tight;

subplot(2, 2, 4);
x = linspace(-3, 3, 50);		% 在 x 軸 [-2,2] 之間取 25 點  
y = linspace(-3, 3, 50);		% 在 y 軸 [-2,2] 之間取 25 點  
[xx, yy] = meshgrid(x, y);		% xx 和 yy 都是 25×25 的矩陣  
zz =  3*(1-xx).^2.*exp(-(xx.^2) - (yy+1).^2) ... 
- 10*(xx/5 - xx.^3 - yy.^5).*exp(-xx.^2-yy.^2) ... 
- 1/3*exp(-(xx+1).^2 - yy.^2);

meshz(xx, yy, zz);	
colormap('default')
xlabel('x')
ylabel('y')
axis tight
title('Function Plots of Peaks')

figure
[x, y, z] = peaks;
waterfall(x,y,z); % waterfall 指令可在 x 方向或 y 方向產生水流效果
% meshc(x, y, z); % 等高線
axis tight;