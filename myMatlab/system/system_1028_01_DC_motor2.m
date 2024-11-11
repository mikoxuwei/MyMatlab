load dcmdata y u
z = iddata(y, u, 0.1); %The IDDATA object
z.InputName = 'voltage';
z.OutputName = {'Angle'; 'AngVel'};

% *Figure: Measurement Data: Voltage to Angle*
plot(z(:, 2, :));

%Sepecification of a Normial (Initial) Model
A = [0 1; 0 -1]; % initial guess for A(2, 2) is -1
B = [0; 0.28]; % initial guess for B(2) is 0.28
C = eye(2);
D = zeros(2, 1);

% Create an IDSS model object.
ms = idss(A, B, C, D);

% are free(to be estimated) and upper and lower limits of those:
ms.Structure.a

%
ms.Structure.a.Value
ms.Structure.a.Free

% parameters to be estimated
ms.Structure.a.Free = [0 0; 0 1];
ms.Structure.b.Free = [0; 1];
ms.Structure.c.Free = 0;
ms.Structure.d.Free = 0;
ms.Ts = 0; % This defines the model to be continuous


ms
dcmodel = ssest(z, ms, ssestOptions('Display', 'on'));
dcmodel

% actual input by compare it with the actual output.
compare(z, dcmodel);

% the integrator from angular velocity to position.
clf
showConfidence(iopzplot(dcmodel), 3);

dcmodel2 = dcmodel;
dcmodel2.Structure.a.Free(1, 2) = 1;
dcmodel2 = pem(z, dcmodel2);

% the resulting model is dcmodel2
compare(z, dcmodel, dcmodel2);