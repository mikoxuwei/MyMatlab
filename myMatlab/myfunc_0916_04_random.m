figure(1);
x = randn(30);
z = eig(x);
plot(z, '.');
grid on

figure(2);
x = linspace(0, 8*pi);
semilogx(x, sin(x)); %x 軸為對數刻度，y 軸為線性刻度

figure(3);
x = linspace(0, 2*pi);  
y1 = sin(x);  
y2 = exp(-x);  
plotyy(x, y1, x, y2);	% plotyy 畫出兩個刻度不同的 y 軸，分別是 y1, y2 