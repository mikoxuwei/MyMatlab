clc;

% exp
whos fittedmodel
goodness
output
x = 2000:10:2050; y = fittedmodel(x);

% poly2
whos fittedmodel1
goodness1
output1
x = 2000:10:2050; y1 = fittedmodel1(x);

% poly3
whos fittedmodel2
goodness2
output2
x = 2000:10:2050; y2 = fittedmodel2(x);

% poly34
whos fittedmodel3
goodness3
output3
x = 2000:10:2050; y3 = fittedmodel3(x);

% poly5
whos fittedmodel4
goodness4
output4
x = 2000:10:2050; y4 = fittedmodel4(x);

% poly6
whos fittedmodel5
goodness5
output5
x = 2000:10:2050; y5 = fittedmodel5(x);

plot(fittedmodel, cdate, pop);
hold on
plot(fittedmodel, x, y, 'k+');
hold off
legend(['data', '', 'extrapolated data', 'fitted curve'], 'Location', 'northeast')

% plot(fittedmodel5, cdate, pop);
% hold on
% plot(fittedmodel5, x, y, 'k+');
% hold off
% legend(['data', '', 'extrapolated data', 'fitted curve'], 'Location', 'northeast')