% https://www.mathworks.com/help/curvefit/evaluate-a-curve-fit.html

close all;

load census
curvefit = fit(cdate,pop,'poly3','normalize','on');

plot(curvefit, cdate, pop)

% Plot the residuals fit.
plot(curvefit, cdate, pop, 'Residuals');

% Plot the prediction bounds on the fit.
plot(curvefit, cdate, pop, 'predfunc');

% -------------------------------------------------------
% Plot the fit and prediction intervals across the extrapolated fit range. 
plot(cdate, pop, 'o');
xlim([1900, 2050]);
hold on
plot(curvefit, 'predobs');
hold off

% --------------------------------------------------------

% >>curvefit(1991), >>xi = (2000:10:2050).'; curvefit(xi), >>ci = predint(curvefit,xi)
% >>curvefit, >>formula(curvefit)
% 想知道 p1 和 p2 的點 >> p1 = curvefit.p1, >>p2 = curvefit.p2

%Recreate the fit specifying the gof and output arguments to get goodness-of-fit statistics and fitting algorithm information.
[curvefit,gof,output] = fit(cdate,pop,'poly3','normalize','on');
% Plot a histogram of the residuals to look for a roughly normal distribution.
histogram(output.residuals,10);

% methods(curvefit);
% 列出