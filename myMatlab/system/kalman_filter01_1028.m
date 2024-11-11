% Time-Varying Kalman Filter Design
% first, generate the noisy plant response.
yt = lsim(sys, [u w]);
y = yt + v;

% Next, implement the recursive filter update equations in a for loop.
P = B*Q*B';      % Initial error covariance
x = zeros (3,1); % Initial condition on the state
ye = zeros (length(t), 1);
ycov = zeros (length(t), 1);
errcov = zeros (length(t),1);
for i = 1:length(t)
    % Measurement update
    Mxn = P*C'/(C*P*C'+R) ;
    x = x + Mxn* (y(i) - C*x); % x[n|n]
    P = (eye(3) - Mxn*C) * P;  % P[n|n]
    ye(i) = C*x;
    errcov(i) = C*P*C';

    % Time update
    x = A*x + B*u(i);          % x[n+1|n]
    P = A*P*A' + B*Q*B';       % P[n+1|n]
end

% Compare the true response with the filtered response.
subplot(211), plot(t,yt,'b',t,ye,'r--')
xlabel('Number of Samples'), ylabel('Output')
title('Response with Time-Varying Kalman Filter')
legend ('True', 'Filtered')
subplot(212), plot(t,yt-y,'g',t,yt-ye,'r--'),
xlabel('Number of Samples'), ylabel('Error')
legend( 'True - measured', 'True - filtered')

% Plot the output covariance to confirm that the filter has reached a steady state. figure
plot(t, errcov)
xlabel('Number of Samples'), ylabel('Error Covariance')


MeasErr = yt - y;
MeasErrCov = sum(MeasErr.*MeasErr)/length(MeasErr);
MeasErrCov

EstErr = yt - ye;
EstErrCov = sum(EstErr.*EstErr)/length(EstErr);
EstErrCov


Mx, Mxn % 和 上個程式 kalman_filter0 比較
