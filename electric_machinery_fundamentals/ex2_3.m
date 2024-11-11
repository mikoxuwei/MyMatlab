% Given values
V_base_gen = 480;          % Base voltage at generator (V)
S_base = 10e3;             % Base apparent power (10 kVA)
Z_line = 20 + 1i*60;       % Transmission line impedance (Ohms)
Z_load = 10*exp(-1i*pi/6); % Load impedance (10∠-30° Ohms)

% Transformer turns ratio
N1 = 1/10;   % Step-up transformer ratio
N2 = 20/1;   % Step-down transformer ratio

% (a) Base values at every point in the system
% Base voltage
V_base_1 = V_base_gen;          % Base voltage in region 1
V_base_2 = V_base_1 / N1;       % Base voltage in region 2 (after step-up)
V_base_3 = V_base_2 / N2;       % Base voltage in region 3 (after step-down)

% Base current at every point
I_base_1 = S_base / V_base_1;   % Base current in region 1
I_base_2 = S_base / V_base_2;   % Base current in region 2
I_base_3 = S_base / V_base_3;   % Base current in region 3

% Base impedance at every point
Z_base_1 = V_base_1^2 / S_base; % Base impedance in region 1
Z_base_2 = V_base_2^2 / S_base; % Base impedance in region 2
Z_base_3 = V_base_3^2 / S_base; % Base impedance in region 3

% Display results for part (a)
fprintf('Base voltage (V) in Region 1: %.2f V\n', V_base_1);
fprintf('Base voltage (V) in Region 2: %.2f V\n', V_base_2);
fprintf('Base voltage (V) in Region 3: %.2f V\n\n', V_base_3);

fprintf('Base current (A) in Region 1: %.2f A\n', I_base_1);
fprintf('Base current (A) in Region 2: %.2f A\n', I_base_2);
fprintf('Base current (A) in Region 3: %.2f A\n\n', I_base_3);

fprintf('Base impedance (Ohms) in Region 1: %.2f Ohms\n', Z_base_1);
fprintf('Base impedance (Ohms) in Region 2: %.2f Ohms\n', Z_base_2);
fprintf('Base impedance (Ohms) in Region 3: %.2f Ohms\n\n', Z_base_3);

% (b) Convert system to per-unit equivalent circuit
Z_line_pu = Z_line / Z_base_2;   % Line impedance in per-unit
Z_load_pu = Z_load / Z_base_3;   % Load impedance in per-unit

fprintf('Per-unit line impedance: %.4f + j%.4f pu\n', real(Z_line_pu), imag(Z_line_pu));
fprintf('Per-unit load impedance: %.4f∠%.2f° pu\n\n', abs(Z_load_pu), angle(Z_load_pu) * 180/pi);

% (c) Find power supplied to the load
V_load_pu = 1;  % Assume per-unit voltage across load is 1 pu (100% rated voltage)
I_load_pu = V_load_pu / Z_load_pu;  % Per-unit load current

S_load_pu = V_load_pu * conj(I_load_pu);  % Per-unit apparent power delivered to the load
S_load = S_load_pu * S_base;              % Actual power delivered to the load (in VA)

fprintf('Power supplied to load: %.2f VA\n\n', abs(S_load));

% (d) Power lost in the transmission line
I_line_pu = V_load_pu / (Z_load_pu + Z_line_pu); % Per-unit current in transmission line
P_loss_pu = abs(I_line_pu)^2 * real(Z_line_pu);  % Per-unit real power loss
P_loss = P_loss_pu * S_base;                     % Actual power loss in transmission line (in W)

fprintf('Power lost in transmission line: %.2f W\n', P_loss);