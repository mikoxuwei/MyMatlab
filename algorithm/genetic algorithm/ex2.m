x= 0:0.001:1;
y= sin(2*pi*x)+0.3*sin(2*pi*3*x)+0.05*cos(2*pi*5*x);
plot(x, y);
title('difficult function for finding minimum point');