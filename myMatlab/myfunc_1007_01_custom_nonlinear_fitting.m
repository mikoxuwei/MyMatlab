load census
plot(cdate, pop, 'o');
hold on

% ---------------------------------------------
% Create a fit options object and a fit type for the custom nonlinear model 
... y=a(x−b)^n, where a and b are coefficients and n is a problem-dependent parameter.

s = fitoptions('Method','NonlinearLeastSquares',...
               'Lower',[0,0],...
               'Upper',[Inf,max(cdate)],...
               'StartPoint',[1 1]);
f = fittype('a*(x-b)^n','problem','n','options',s);
%-------------------------------------------------------------

% Fit the data using the fit options and a value of n = 2.
[c2,gof2] = fit(cdate,pop,f,'problem',2);

% Fit the data using the fit options and a value of n = 3.
[c3,gof3] = fit(cdate,pop,f,'problem',3);

% -----------------------------------------------
%Plot the fit results with the data.

plot(c2,'m');
plot(c3,'c');
legend('data','fit with n=2','fit with n=3');