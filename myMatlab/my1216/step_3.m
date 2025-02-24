% Create a world object 建一個背景
world = sim3d.World();

% Build Plane and Movable Ball Actor 創立一平面(地板)和可移動的球體
ball = sim3d.Actor();
ball.createShape('sphere', [0.5, 0.5, 0.5]); % 球體半徑
world.add(ball); % 將球體加入到環境中

ball.Mobility = sim3d.utils.MobilityTypes.Movable; % 球體移動設定
ball.Gravity = true; % 引力
ball.Physics = true; % 外觀
ball.Translation = [0, 0, 5]; % 移動方向(z軸)
ball.Color = [.77 0 .255]; % 顏色(RGB參數)
ball.Shadows = false; % 陰影(無)

plane = sim3d.Actor(); % 平面設定
plane.createShape('plane', [5, 5, 0.1]); % 長寬和厚度
plane.PreciseContacts = true; % 接觸
world.add(plane); % 將平面加入到環境中

% Set Viewer Window Point of View 物件觀測角度
viewport = createViewport(world);

% Run a simulation set for 10 seconds with a sample time of 0.02 seconds 設定模擬和取樣時間
run(world, 0.01, 10);

% Delete the world
delete(world);