x = linspace(-2, 2, 21);		% 在 x 軸 [-2,2] 之間取 21 點  
y = linspace(-2, 2, 21);		% 在 y 軸 [-1,1] 之間取 21 點  
[xx, yy] = meshgrid(x, y);		% xx 和 yy 都是 21&#215;21 的矩陣  
zz = xx.*exp(-xx.^2-yy.^2);		% 計算函數值，zz 也是 21&#215;21 的矩陣
subplot(1,3,1)
surf(xx, yy, zz); % axis tight  預設的顏色對應表（Colormap）來畫出此曲面
subplot(1,3,2)
surf(xx, yy, zz, gradient(zz)); % axis tight 以曲面的斜率來設定曲面的顏色
subplot(1,3,3)
surf(xx, yy, zz, del2(zz)); % axis tight 以曲面的曲率來設定曲面的顏色