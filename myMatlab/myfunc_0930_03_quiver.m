%% gradient 產生梯度向量，contour 進行等高線作圖，而 quiver 則將每一點的梯度向量以小箭號表示
[x, y, z] = peaks(20);
[u, v] = gradient(z);
contour(x, y, z, 10);
hold on, quiver(x,y,u,v); hold off
axis image;

figure;
[x, y] = meshgrid(-2:0.2:2, -1:0.1:1);
z = x.*exp(-x.^2-y.^2);
[u, v, w] = surfnorm(x, y, z);
quiver3(x, y, z, u, v, w);
hold on, surf(x, y, z); hold off
axis equal
%colormap('default')			% 顏色改回預設值 

