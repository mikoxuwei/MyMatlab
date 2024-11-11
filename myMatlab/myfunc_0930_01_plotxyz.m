% t = linspace(0,20*pi, 501);	% 在 0 及 20*pi 中間取 501 點  20圈
% plot3(t.*sin(t), t.*cos(t), t);	% 畫出 tsin(t),tcos(t),t 的曲線
% 
% t = linspace(0, 20*pi, 501);
% plot3(t.*sin(t), t.*cos(t), t, t.*sin(t), t.*cos(t), -t);	% 同時畫兩條曲線
% 
% [x, y] = meshgrid(-2:0.1:2);  
% z = y.*exp(-x.^2-y.^2);  
% plot3(x, y, z); 
% 
% %% 如果所給的資料點不在格子點上，我們必需先用 griddata 指令來進行內插法以產生格子點
% figure;
% x = 6*rand(100,1)-3;		% x 為介於 [-3, 3] 的 100 點亂數  
% y = 6*rand(100,1)-3;		% y 為介於 [-3, 3] 的 100 點亂數  
% z = peaks(x, y);			% z 為 peaks 指令產生的 100 點輸出  
% [X, Y] = meshgrid(-3:0.1:3);  
% Z = griddata(x, y, z, X, Y, 'cubic');	% 用 cubic 內差法進行內差  
% meshc(X, Y, Z);
% hold on
% plot3(x, y, z, '.', 'MarkerSize', 16);	% 晝出 100 個取樣
% hold off
% axis tight
% 

% figure;
% subplot(2,2,1);
% fmesh(@(x, y) sin(x) / x * sin(y) / y); % ezmesh('sin(x)/x*sin(y)/y');
% subplot(2,2,2);
% fsurf(@(x, y) sin(x * y) / (x * y)); % ezsurf('sin(x*y)/(x*y)');
% subplot(2,2,3);
% fmesh(@(x, y) sin(x) / x * sin(y) / y, 'ShowContours', 'on'); % ezmeshc('sin(x)/x*sin(y)/y'); 
% subplot(2,2,4);
% fsurf(@(x, y) sin(x * y) / (x * y), 'ShowContours', 'on'); % ezsurfc('sin(x*y)/(x*y)');

% figure;
% subplot(2,2,1);
% ezmesh('sin(x)/x*sin(y)/y');
% subplot(2,2,2);
% ezsurf('sin(x*y)/(x*y)');
% subplot(2,2,3);
% ezmeshc('sin(x)/x*sin(y)/y');
% subplot(2,2,4);
% ezsurfc('sin(x*y)/(x*y)');

figure;
subplot(1,2,1);
fmesh(@(x, y) x.*exp(-x.^2 - y.^2));
subplot(1,2,2);
fsurf(@(x, y) besselj(1, hypot(x, y)));

figure;
fsurf(@(x, y) besselj(1, hypot(x, y)), [-20, 20]);

figure;
subplot(1,3,1);
fsurf(@(x, y) sqrt(1 - x.^2 - y.^2), [-1.1, 1.1]);
subplot(1,3,2);
fsurf(@(x, y) x./y + y./x);
subplot(1,3,3);
fsurf(@peaks);