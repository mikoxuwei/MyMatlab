x = linspace(-2*pi, 2*pi, 21);
y = linspace(-1.5*pi, 1.5*pi, 31);  
[xx, yy] = meshgrid(x, y); 
zz =sin(xx/2) .* cos(yy);		

subplot(1,2,1)
mesh(xx, yy, zz);
subplot(1,2,2)
contour(xx, yy, zz);
%contour(zz);