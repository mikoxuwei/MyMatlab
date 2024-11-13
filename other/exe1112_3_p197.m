% p.197 example 3-2
% parameters
d = 0.5;
l = 0.3;
B = 0.2;
v = 3600;
Nc = 15;

flux = d*l*B;
disp(['flux= ', num2str(flux), 'Wb']);

% rotor speed
w = v*2*pi/60;
disp(['w= ', num2str(w), 'rad/s']);

% Maximum voltage
Emax = Nc * flux * w;
disp(['Emax= ', num2str(Emax), 'V']);

% (a)
% three phase voltage
disp(['eaa(t)= ', num2str(Emax), ' sin377t V']);
disp(['ebb(t)= ', num2str(Emax), ' sin(377t - 120) V']);
disp(['ecc(t)= ', num2str(Emax), ' sin(377t - 240) V']);

% (b)
%　The rms phase voltage of this generator is 
EA = Emax/ sqrt(2);
disp(['EA= ', num2str(EA), ' V']);

% (c)
% Since the generator is V-connected
VT = sqrt(3)* EA;
disp(['VT= ', num2str(VT), ' V']);