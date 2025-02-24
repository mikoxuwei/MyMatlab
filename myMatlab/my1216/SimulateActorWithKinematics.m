% Create 3D Environment
world = sim3d.World();

% Build Actors
actor1 = sim3d.Actor(ActorName = 'sphere');
createShape(actor1, 'sphere', [0.5 0.5 0.5]);
add(world, actor1);
actor2 = sim3d.Actor(ActorName = 'box');
createShape(actor2, 'box', [0.5 0.5 0.5]);
add(world, actor2);

actor1.Translation =[1 -2 1];
actor1.Color = [0 1 1];
actor1.Mobility = sim3d.utils.MobilityTypes.Movable;
actor1.LinearVelocity = [0 0.5 0];

actor2.Translation = [1 0 -1];
actor2.Color = [1 0 1];
actor2.Mobility = sim3d.utils.MobilityTypes.Movable;
actor2.AngularVelocity = [0 0 pi/4];

% Set Viewer Window Point of View
viewport = createViewport(world);
viewport.Translation = [-6, 0, 0];

% Run Animation
sampletime = 0.02;
stoptime = 10;
run(world, sampletime,stoptime);