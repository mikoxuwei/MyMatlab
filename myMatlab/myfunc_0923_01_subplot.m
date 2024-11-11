figure
subplot(1,2,1); % 一列兩行第一張
x = 0:0.1:2*pi; 
y1 = sin(x);
y2 = exp(-x);
plot(x, y1, '--*', x, y2, ':o');
xlabel('t = 0 to 2\pi');
ylabel('values of sin(t) and e^{-x}');
title('Function Plots of sin(t) and e^{-x}');
legend('sin(t)','e^{-x}');

subplot(1,2,2); % 一列兩行第二張
x = 0:0.1:2*pi;  
plot(x, sin(x), x, cos(x));   
text(pi/4, sin(pi/4),'\leftarrow sin(\pi/4) = 0.707');  
text(5*pi/4, cos(5*pi/4),'cos(5\pi/4) = -0.707\rightarrow', 'HorizontalAlignment', 'right');
% 「HorizontalAlignment」及「right」指示 text 指令將文字向右水平靠齊。