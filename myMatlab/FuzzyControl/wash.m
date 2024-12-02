a = readfis('wash.fis');
z = evalfis([60, 70], a);
disp(['z = ', num2str(z)]);
figure(1);
plotfis(a);