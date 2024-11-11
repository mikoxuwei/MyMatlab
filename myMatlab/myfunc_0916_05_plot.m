figure(1)
x = 0:0.5:4*pi;                      % x 向量的起始與結束元素為 0 及 4π， 0.5 為各元素相差值
y = sin(x);
plot(x, y, 'R:pentagram')	    % 其中「k」代表黑色，「：」代表點線，而「diamond」則指定菱形為曲線的線標

figure(2)                                            
x = 0:0.1:4*pi;                      % x 向量的起始與結束元素為 0 及 4π、0.1 為各元素相差值  
y = sin(x);  
plot(x, y);  
axis([-inf, inf, 0, 1]);	            % 畫出正弦波 y 軸介於 0 和 1 的部份
                                            
figure(3)
x = 0:0.1:4*pi;  
plot(x, sin(x)+sin(3*x))   
set(gca, 'ytick', [-1 -0.3 0.1 1]);	% gca 是「get current axis」的簡稱，可以傳回目前使用中的圖軸。
                                            % 在 y 軸加上格線點
set(gca, 'yticklabel', {'極小','臨界值','崩潰值','極大'}) 
grid on