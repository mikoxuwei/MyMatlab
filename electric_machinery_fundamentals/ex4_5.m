fn1 = 61.5; % G1 無載頻率
fn2 = 61;   % G2 無載頻率
sp1 = 1.0;
sp2 = 1.0;
Pt = 2.5; % 負載

% (a) the total load is 2.5 MW.
fsys = ((sp1 * fn1 + sp2 * fn2) - Pt)/(sp1 + sp2); % 系統頻率
disp(['fsys = ', num2str(fsys), ' Hz']);

P1 = sp1 * (fn1 - fsys);
disp(['P1 = ', num2str(P1), 'MW']); % G1 輸出功率
P2 = sp2 * (fn2 - fsys);
disp(['P2 = ', num2str(P2), 'MW']); % G2 輸出功率

% (b) the total load is 3.5 MW. (負載增加 1 MW)
fsys = ((sp1 * fn1 + sp2 * fn2) - Pt - 1)/(sp1 + sp2); % 系統頻率
disp(['fsys = ', num2str(fsys), ' Hz']);

P1 = sp1 * (fn1 - fsys);
disp(['P1 = ', num2str(P1), 'MW']); % G1 輸出功率
P2 = sp2 * (fn2 - fsys);
disp(['P2 = ', num2str(P2), 'MW']); % G2 輸出功率

% (c)  G2 are increased by 0.5 Hz 調速機調升 G2 的無載頻率增加 0.5 Hz
fsys = ((sp1 * fn1 + sp2 * (fn2 + 0.5)) - Pt - 1)/(sp1 + sp2); % 系統頻率
disp(['fsys = ', num2str(fsys), ' Hz']);

P1 = sp1 * (fn1 - fsys);
disp(['P1 = ', num2str(P1), 'MW']); % G1 輸出功率
P2 = sp2 * ((fn2 + 0.5) - fsys);
disp(['P2 = ', num2str(P2), 'MW']); % G2 輸出功率