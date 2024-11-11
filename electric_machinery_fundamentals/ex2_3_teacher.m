Vbase1=480;
Sbase=10000;
Zline=20+60i;
VG=480;
Zload=10;

% generator zoom
Ibase1=Sbase/Vbase1;
Zbase1=Vbase1/Ibase1;
disp (['Ibase1= ' ,num2str(Ibase1), '  Zbase1=' ,num2str(Zbase1)]);
a=1/10;

% transmission line zoom
Vbase2=Vbase1/a;
Ibase2=Sbase/Vbase2;
Zbase2=Vbase2/Ibase2;
disp (['Ibase2= ' ,num2str(Ibase2), '  Zbase2=' ,num2str(Zbase2)]);
a=20;

% Load zoom
Vbase3=Vbase2/a;
Ibase3=Sbase/Vbase3;
Zbase3=Vbase3/Ibase3;
disp (['Ibase3= ' ,num2str(Ibase3), '  Zbase3=' ,num2str(Zbase3)]);

VGpu=VG/Vbase1;
Zlinepu=Zline/Zbase2;
Zlinepu=abs(Zline)/Zbase2;
theta=angle(Zline);
[Rlinepu, Xlinepu]=pol2cart(theta, Zlinepu);

disp (['Zlinepu= ' ,num2str(Rlinepu),' +j',num2str(Xlinepu)]);

Zloadpup=Zload/Zbase3;
disp (['Zloadpu= ' ,num2str(Zloadpup), '/_30']);

[Rpu, Xpu]=pol2cart(deg2rad(30), Zloadpup);
Zloadpu=Zloadpup*exp(1j*deg2rad(30));
Ztotpu=Zlinepu+Zloadpu;
disp (['Ztotpu= ' , num2str(real(Ztotpu)),' +j',num2str(imag(Ztotpu))]);
Ipu=VGpu/[abs(Ztotpu)]; 
disp (['Ipu= ' , num2str(Ipu),'/_-',num2str(rad2deg(angle(Ztotpu)))]);

Ploadpu=Ipu^2*Rpu;
disp (['Ploadpu= ' , num2str(Ploadpu)]);
Pload=Ploadpu*Sbase;
disp (['Pload= ' , num2str(Pload)]);
Plinepu=Ipu^2*Rlinepu;
disp (['Plinepu= ' , num2str(Plinepu)]);
Pline=Plinepu*Sbase;
disp (['Pline= ' , num2str(Pline)]);
