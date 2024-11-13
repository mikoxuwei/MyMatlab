% Time settings
dt = 1;  % time step 一秒取樣一次
T= 60;   % total time steps

% State Transition Matrix (A) for constant rate of change of efficiency
A= [1 dt; 
    0  1]; 

% Control Matrix (B): 速度狀態方程式
B= [0.5*dt^2; dt];  % V(t)= V0t + 1/2at^2

% Process Noise Covariance (Q) 斜方雜訊
Q= [0.01 0; 
    0 0.01];

% Measurement Noise Covariance (R) 觀測斜方誤差
% 高不確定性
R= 10;  % High uncertainty in position measurements

% Observation Matrix(H)
H= [1 0];  % We only observe effciency, not its rate of change

% Initial state estimate (efficiency; rate_of_change_of_efficiency)
% 初始值0速度0位移
x= [0.9; 0];  % Starting with an initial guess for efficiency

% Initial error covariance (P) 初始斜方誤差
P= eye(2); 

% Simulating true trajectory and noisy observations
true_position= zeros(1, T);
observed_position= zeros(1, T);
true_velocity= 10;  % Initial velocity

% Introducing highly dynamic motion with nonlinear noise
for t= 1: T
    % Random jerk: sudden, dynamic chenages in motion
    jerk= 5* sin(0.2* t) + 2* randn;
    true_velocity= true_velocity + jerk* dt;  % Changing velocity over time
    true_position(t)= true_position(max(1, t-1)) + true_velocity* dt  % Updata position

    % Noisy observation of position
    observed_position(t)= true_position(t) + sqrt(R)* randn;  % Add noisy to true position

for t= 1: T
    % Prediction step
    x= A* x;  % State prediction (constant rate of change)
    P= A* P* A' + Q;  % Error covariance prediction

    % Kalman Gain calculation 爭議
    K= P* H' / (H* P* H' + R);
     
    % Measurement update step 下一步的位置速度
    z= observed_position(t);  % Current noisy observation (efficiency)
    x= x + K* (z - H* x);  % State update with observation
    P= (eye(2) - K* H) * P;  % Error covariance update

    % Store the estimated efficiency
    estimated_position(t)= x(1);
    estimated_velocity(t)= x(2);
end

% Kalman Filter for estimating efficiency
estimated_position= zeros(1, T);
estimated_velocity= zeros(1, T);

for t= 1: T
    % Prediction step
    x= A* x;  % State prediction (constant rate of change)
    P= A* P* A' + Q;  % Error covariance prediction

    % Kalman Gain calculation 爭議
    K= P* H' / (H* P* H' + R);
     
    % Measurement update step 下一步的位置速度
    z= observed_position(t);  % Current noisy observation (efficiency)
    x= x + K* (z - H* x);  % State update with observation
    P= (eye(2) - K* H) * P;  % Error covariance update

    % Store the estimated efficiency
    estimated_position(t)= x(1);
    estimated_velocity(t)= x(2);
end

 % Plot the results
 figure(1);
 plot(1: T, true_position, '-g', 'LineWidth', 2); hold on;
 plot(1: T, observed_position, 'ro');
 plot(1: T, estimated_position, '-b', 'LineWidth', 2);
 legend('True Postion', 'Noisy Observations', 'Estimated Position');
 title('Kalman Filter: Estimation of Motor Position');
 xlabel('Time step');
 ylabel('Position');

 figure(2);
 plot(1: T, estimated_velocity, '-b', 'LineWidth', 2);
 title('Estimated Velocity');
 xlabel('Time');
 ylabel('Velocity');