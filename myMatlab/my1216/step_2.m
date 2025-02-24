% Create a world object 建一個背景
world = sim3d.World();
% Instantiate an actor object named Cylinder 初始化一個名叫'圓柱型'的物件
ActObj = sim3d.Actor( 'ActorName', 'Cylinder');
% Build a cylinder shape for the actor object and specify its size
% 尖立一個圓柱體的物件包含半徑和高度，顏色(RGB參數'三原色')
createShape(ActObj, 'cylinder', [0.5, 0.5, .75]);
ActObj.Color = [1, 0, 1];
add(world, ActObj);
% Use the actor object translation, rotation, and scale properties to 
% orient the actor relative to the world origin
% 設定物件移動、旋轉方向
ActObj.Translation = [0 0 0];
ActObj.Rotation = [0, 0, 0];
ActObj.Scale = [1, 1, 1];

% Set Viewer Window Point of View 物件觀測角度
viewport = createViewport(world);
viewport. Translation = [-4.5, 0, 1];

% Run a simulation set for 10 seconds with a sample time of 0.02 seconds 設定模擬和取樣時間
sampletime = 0.02;
stoptime = 10;
run(world, sampletime, stoptime);

% Delete the world object MAl
delete(world);