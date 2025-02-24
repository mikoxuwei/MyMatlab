r1 = 0.641;   % 定子阻抗
x1 = 0.075;   % 定子電抗
r2 = 0.300;   % 轉子阻抗
r2i = 0.400;   % 內轉子阻抗
r2o = 3.200;   % 雙鼠籠式轉子阻抗
x2 = 0.500;   % 轉子電抗
x2i = 3.300;   % 內轉子電抗
x2o = 0.500;   
xm = 26.3;   % 鐵芯電抗
v_phase = 460/sqrt(3);   % 相電壓
n_sync = 1800;   %  同步轉速
w_sync = 188.5;   % 同步轉速(徑度/秒)

% 從戴維寧等效電路計算出
v_th = v_phase * (xm/sqrt(r1^2 + (x1 + xm)^2));   % 戴維寧等效電壓
z_th = ((1i * xm) * (r1 + 1i * x1)) / (r1 +1i * (x1 + xm));   % 戴維寧等效電路電抗
r_th = real(z_th);   % 戴維寧等效電阻
x_th = imag(z_th);   % 戴維寧等效感抗

% 轉差從0~1的變化
s = (0:1:50) / 50;   % 繪出50點
s(1) = 0.001;   % 每一點變化
nm = (1 - s) * n_sync;   % 轉子轉速

t_ind1 = zeros(1, 51);
for ii = 1:51
    t_ind1(ii) = (3*v_th^2*r2/s(ii))/ ...
        (w_sync*((r_th+r2/s(ii))^2 + (x_th + x2)^2));
end

% 繪出雙鼠籠式轉子矩陣
for ii = 1:51
    y_r = 1 / (r2i + 1i * s(ii) * x2i) + 1 / (r2o + 1i * s(ii) * x2o);
    z_r = 1/y_r;
    r2eff = real(z_r);
    x2eff = imag(z_r);

    t_ind2(ii) = (3*v_th^2*r2eff/s(ii))/ ...
        (w_sync*((r_th+r2eff/s(ii))^2 + (x_th + x2eff)^2));
end

%   繪出轉舉-矩陣線圖
plot(nm, t_ind1, 'b-', 'LineWidth', 2.0);
hold on;
plot(nm, t_ind2, 'k-', 'LineWidth', 2.0)
xlabel('\bf\itn_(m)');
ylabel('\bf\tau_(ind)');
title('\bfInduction motor torque-speed characteristics');
legend('Single-cage design', 'Double-cage Design');
grid on;
hold off;