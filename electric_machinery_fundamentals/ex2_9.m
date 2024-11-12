% Example 2-9
% A50-kVA, 13800/208-V, delta-y distribution transformer has a resistance of 1 percent and a reactance of 7 percent per unit. 
% (a) What is the transformer's phase impedance referred to the highvoltage side? 
% (b) Calculate this transformer's voltage regulation at full load and 0,8 PF lagging, using the calculated high-side impedance. 
% (c) Calculate this transformer's voltage regulation under the same conditions, using the per-unit system. 
% ======================================================================
% 參數
Sbase = 50000;
Vp = 13800;
Zeqpu = 0.01 + 0.07i;

%% (a) --------------------------------------------------------------------------------------------------
Zbase = 3 * Vp^2 / Sbase;
disp(['Zbase = ', num2str(Zbase), ' ohm']);

Zeq = Zeqpu * Zbase;
disp(['Zeq = ', num2str(real(Zeq)), ' + j', num2str(imag(Zeq)), ' pu']);

%% (b) --------------------------------------------------------------------------------------------------
Ip = Sbase / 3 / Vp;
disp(['Ip = ', num2str(Ip), ' /_ ', num2str(acos(0.8) * 180/pi), ' A']);
% 實際值
Vhp = Vp + Zeq * Ip * exp(1j * (-acos(0.8)));
disp(['Vhp = ', num2str(real(Vhp)), ' + j', num2str(imag(Vhp)), ' V']);
disp(['Vhp = ', num2str(abs(Vhp)), ' /_ ', num2str(angle(Vhp) * 180/pi), ' V']);

VR = (abs(Vhp) - Vp) / Vp;
disp(['VR = ', num2str(VR * 100), ' %']);

%% (c) --------------------------------------------------------------------------------------------------
% 標么值
Vp = 1 + Zeqpu * exp(1j * (-acos(0.8)));
disp(['Vp = ', num2str(real(Vp)), ' + j', num2str(imag(Vp)), ' V']);
disp(['Vp = ', num2str(abs(Vp)), ' /_ ', num2str(angle(Vp) * 180/pi), ' V']);

VR = (abs(Vp)-1)/1;
disp(['VR = ', num2str(VR * 100), ' %']);