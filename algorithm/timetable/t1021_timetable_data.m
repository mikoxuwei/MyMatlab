T = seconds(1 : 5)';
u = rand(5, 1);
tt = timetable(T, u);

T = tt.Properties.RowTimes;

% -------------------------
% 將 u1, u2 組合在變數 U 中
T1 = seconds(1 : 5)';
u1 = rand(5, 1);
u2 = rand(5, 1);

tt1 = timetable(T1, [u1, u2], 'VariableNames', {'U'});
head(tt1);

tt2 = timetable(T1, u1, u2, 'VariableNames', {'u1', 'u2'});
head(tt2);

% 利用包含 2 個輸入通道和 2 個輸出通道的資料來估測模型
load steamdata ttsteam;
head(ttsteam, 4);

np = 2; 
nz = 2;
sysdef = tfest(ttsteam, np, nz);

inputs = sysdef.InputName;