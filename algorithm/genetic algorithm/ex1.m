% 求f(x, y)的極小值和[x, y]座標值

%Function plots of a 3-dimensional optimization problem
x = 0 : 0.02 : 10; % 0 - 10, 間隔0.02
y = 0 : 0.02 : 10;
[X, Y] = meshgrid(x, y);
Z = X.*sin(4*X) + 1.1*Y.*sin(2*Y); %
figure(1);
mesh(X, Y, Z);
disp('==>ex1 execution complete!')