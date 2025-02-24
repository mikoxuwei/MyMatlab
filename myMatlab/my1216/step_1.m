% Create a world object 建立背景
world = sim3d.World();
% Create an actor object創立一個物件
actor = sim3d.Actor();
% Add the actor to the world 將物件放入背景
add(world,actor);
% Run a simulation set for 10 seconds with a sample time of 0.02 seconds
% 取樣時間設定為0.02秒，模擬10秒
sampletime = 0.02;
stoptime = 10;
run(world, sampletime, stoptime);
% Delete the world object
delete(world);