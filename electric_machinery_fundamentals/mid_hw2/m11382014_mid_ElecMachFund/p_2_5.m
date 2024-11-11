%% (a)
% 假設這個變壓器連接到一個 120 V、60 Hz 的電源，
% 沒有負載連接到 240 V 側。繪製變壓器中流動的磁化電流。
% （如果可用，請使用 MATLAB 準確繪製電流。)
% 磁化電流的 rms 幅度是多少？
% 磁化電流占滿載電流的百分比是多少？
load p22_mag.dat; 
mmf_data = p22_mag(:,1);  % 讀取 mmf (磁動勢) 數據
flux_data = p22_mag(:,2);  % 讀取 flux (磁通) 數據
disp('(a)'); 
% 參數
S = 1000;                   % 顯性功率 (VA)
Vrms = 120;                 % 有效電壓 (V)
VM = Vrms * sqrt(2);        % 最大電壓 (V)
NP = 500;                   % 初級繞組匝數

% 計算 60 Hz 的角速度
freq = 60; % 頻率 (Hz)
w = 2 * pi * freq;

% 計算隨時間變化的磁通
time = 0 : 1/3000 : 1/30;       % 時間從 0 到 1/30 秒
flux = -VM/(w*NP) * cos(w .* time); 

% 計算對應於給定磁通的 mmf
% 使用 MATLAB 的插值函數。
mmf = interp1(flux_data, mmf_data, flux); 

% 計算磁化電流
im = mmf / NP; 

% 計算電流的 rms 值
irms = sqrt(sum(im.^2)/length(im)); 
disp(['在 120 V 和 60 Hz 下的 rms 電流為 ', num2str(irms)]); 

% 計算滿載電流
i_full = S / Vrms; 
% 計算滿載電流的百分比
percnt = irms / i_full * 100; 
disp(['磁化電流佔滿載電流的 ', num2str(percnt), '%。']); 

% 繪製磁化電流
figure('Name', '在 120 V 和 60 Hz 下的磁化電流','NumberTitle','off') 
plot(time, im); 
title ('\bf在 120 V 和 60 Hz 下的磁化電流'); 
xlabel ('\bf時間 (s)'); 
ylabel ('\bf\itI_(m) \rm(A)'); 
axis([0 0.04 -0.5 0.5]); 
grid on;

%% (b) 
% 現在假設這個變壓器連接到 240 V，50 Hz 的電源，
% 沒有負載連接到 120 V 側繪製在變壓器中流動的磁化電流
% 如果可用，請使用 MATLAB 準確計算電流。）
% 磁化電流的 rms 幅度是多少？
% 磁化電流占滿載電流的百分比是多少？
disp('(b)'); 
% 參數 
S = 1000;                   % 顯性功率 (VA) 
Vrms = 240;                 % 有效電壓 (V) 
VM = Vrms * sqrt(2);        % 最大電壓 (V) 
NP = 1000;                  % 初級繞組匝數 

% 計算 50 Hz 的角速度
freq = 50; % 頻率 (Hz) 
w = 2 * pi * freq;

% 計算隨時間變化的磁通                
time = 0 : 1/2500 : 1/25;       % 時間從 0 到 1/25 秒 
flux = -VM/(w * NP) * cos(w .* time); 

% 計算對應於給定磁通的 mmf
% 使用 MATLAB 的插值函數。
mmf = interp1(flux_data, mmf_data, flux); 

% 計算磁化電流 
im = mmf / NP; 

% 計算電流的 rms 值 
irms = sqrt(sum(im .^ 2) / length(im)); 
disp(['在 50 Hz 下的 rms 電流為 ', num2str(irms)]); 

% 計算滿載電流 
i_full = S / Vrms; 

% 計算滿載電流的百分比 
percnt = irms / i_full * 100; 
disp(['磁化電流佔滿載電流的 ', num2str(percnt), '%。']); 

% 繪製磁化電流 
figure('Name', '在 240 V 和 50 Hz 下的磁化電流','NumberTitle','off'); 
plot(time, im); 
title ('\bf在 240 V 和 50 Hz 下的磁化電流'); 
xlabel ('\bf時間 (s)'); 
ylabel ('\bf\itI_(m) \rm(A)'); 
axis([0 0.04 -0.5 0.5]); 
grid on;
%% (c)
% In which case is the magnetization current a higher percentage of full-load current? Why?
% 
disp('(c)'); 
disp('在240V、50Hz的情況下，磁化電流占滿載電流的百分比較高。'); 
disp('因為頻率降低後，為了維持相同的磁通量需要更大的磁化電流，磁化電流增加後，相對於滿載電流的百分比也就提高了，所以在 240V、50Hz 下，磁化電流占滿載電流的比例較高。'); 