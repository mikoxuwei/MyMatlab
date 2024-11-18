a = readfis('wash.fis');
figure(1);
plotfis(a)
z = evalfis([60, 70], a);
disp(['z = ' z])