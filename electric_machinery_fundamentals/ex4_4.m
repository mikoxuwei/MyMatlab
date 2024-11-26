% M-file: term_char_a.m 
% M-fi le to plot the terminal characteristics of the 
% generator of Example 4-4 with an 0.8 PF lagging load. 
% First, i nitialize the current amplitudes (21 values 
% in the range 0-60 A) 
i_a = (0 : 1 : 20) * 3; 
% Now initialize all other values 
v_phase = zeros(1, 21); 
e_a = 277.0; 
x_s = 1.0; 
theta = 36.87 * (pi/180) ; % Converted to radians  功因角(徑度)

% Now, calculate v_phase for each current level 
for ii = 1:21 % 電流增加從 1 - 20*3
    v_phase(ii) = sqrt(e_a^2 - (x_s * i_a(ii) * cos(theta))^2) - (x_s * i_a(ii) * sin(theta));
end 

% Calculate terminal voltage f rom the phase volt age 
v_t = v_phase * sqrt(3); % 線電壓

% Plot the terminal characteristic, remembering the 
% the line current is the same as i_a 
figure(1);
plot (i_a, v_t, 'Color', 'k', 'Linewidth', 2.0); 
xlabel ('Line Current (A)', 'Fontweight', 'Bold'); 
ylabel ('Terminal Voltage (V)', 'Fontweight', 'Bold'); 
title ('Terminal Characteristic for 0.8 PF lagging load(落後)', 'Fontweight', 'Bold'); 
grid on; 
axis([0 60 400 550]);

for ii = 1:21 % 電流增加從 1 - 20*3
    v_phase(ii) = sqrt(e_a^2 - (x_s * i_a(ii) * cos(theta))^2) + (x_s * i_a(ii) * sin(theta));
end 
v_t = v_phase * sqrt(3);

figure(2);
plot (i_a, v_t, 'Color', 'k', 'Linewidth', 2.0); 
xlabel ('Line Current (A)', 'Fontweight', 'Bold'); 
ylabel ('Terminal Voltage (V)', 'Fontweight', 'Bold'); 
title ('Terminal Characteristic for 0.8 PF lagging lead(領先)', 'Fontweight', 'Bold'); 
grid on; 
axis([0 60 400 550]);