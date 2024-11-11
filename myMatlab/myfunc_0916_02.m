x = linspace(0, 2*pi);% 在 0 到 2*pi 間，等分取 100 個點
y = sin(x);
z = sin(x) + cos(x);
% plot(x, y);
% plot(x ,z);
plot(x, sin(x),'o', x, cos(x),'x', x, sin(x) + cos(x), '*'); % *+-xo^.