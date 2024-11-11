% https://www.mathworks.com/help/curvefit/polynomial.html?searchHighlight=polynom&s_tid=srchtitle_support_results_2_polynom
% 裡面有範例
close all;

load census
whos cdate pop
plot(cdate, pop, 'o');
% ---------------------------------

%Create and Plot a Quadratic
[population2, gof] = fit(cdate, pop, 'poly2');

% To plot the fit, use the plot function. Add a legend in the top left
% corner.
plot(population2, cdate, pop);
legend('Location', 'NorthWest');

% ----------------------------------

% Create and Plot a Selection of Polynomials 選擇幾次多項式
population3 = fit(cdate, pop, 'poly3', 'Normalize', 'on');
population4 = fit(cdate, pop, 'poly4', 'Normalize', 'on');
population5 = fit(cdate, pop, 'poly5', 'Normalize', 'on');
population6 = fit(cdate, pop, 'poly6', 'Normalize', 'on');

% A simple model for population growth tells us that an exponential equation
... should fit this census data well. To fit a single term exponential model,

populationExp = fit(cdate, pop, 'exp1');

% Plot all the fits at once, and add a meaningful legend in the top left corner of the plot.
hold on
plot(population3, 'b');
plot(population4, 'g');
plot(population5, 'm');
plot(population6, 'b--');
plot(populationExp, 'r--');
hold off
legend('cdate v pop', 'poly2', 'poly3', 'poly4', 'poly5', 'poly6', 'exp1', ...
    'Location', 'northwest');

% Plot the  Residuals to Evaluate the Fit
% To plot residuals, specify, 'residuals' as the plot type in the function.

figure('name', 'population2&Exp');
subplot(2, 1, 1);
plot(population2, cdate, pop, 'residuals');
subplot(2, 1, 2);
plot(populationExp, cdate, pop, 'residuals'); % 'residuals' 殘差


% ---------------------------------------------------
% Examine Fits Beyond the Data Range
figure('name', 'population6');
plot(cdate, pop, 'o');
xlim([1900, 2050]);
hold on
plot(population6);
hold off

% ----------------------------------------------------
%plot predcition Intervals
% 要繪製預測區間，使用 'predobs' 或 'predfun' 作為繪圖類型
figure('name', 'population5');
plot(cdate, pop, 'o');
xlim([1900, 2050]);
hold on
plot(population5, 'predobs');
hold off

% ----------------------------------------------------
%plot predcition Intervals for the cubic polynomial up to year 2050

figure('name', 'population3');
plot(cdate, pop, 'o');
xlim([1900, 2050]);
hold on
plot(population3, 'predobs'); % 
hold off

% ---------------------------------------------------
% Plot the prediction future population, with confidence

%plot predcition Intervals

figure('name', 'population2');
plot(cdate, pop, 'o');
xlim([1900, 2040]);
hold on
plot(population2);

% cdateFuture %
% 要先外部執行指令 >>gof, >>population2, >>population5, 
... >>ci = confint(population5),
... >>cdateFuture = (2000:10:2020).';popFuture = population2(cdateFuture) %選 population2 為最佳
% >>ci = predint(population2, cdateFuture,0.95, 'observation')
gof; 
population2;
population5; 
ci = confint(population5);
cdateFuture = (2000:10:2020).';
popFuture = population2(cdateFuture); %選 population2 為最佳
ci = predint(population2, cdateFuture, 0.95, 'observation');

h = errorbar(cdateFuture, popFuture, popFuture - ci(:, 1), ci(:, 2) - popFuture, '.');

hold off
legend('cdate v pop', 'poly2', 'prediction', 'Location', 'northwest');