%% contour
figure;
z = peaks;
[c,handle] = contour(z, 10);
clabel(c, handle);

figure;
[x, y, z] = peaks;
contour3(x, y, z, 30);
axis tight