% Assignment 7
% Design the Joint Space Inverse Dynamics Control law


KD = [20;100;20];
KP = [80;1000;100];
clear qd dqd ddqd
wrongModel = 1;

% simulink trajectory
qi = [0 0 0]';
dqi = [0 0 0]';
dqf = 0;

ti = 0;
tf = 5;
Ts = 0.01;

%TimeValues = [ti:Ts:tf];
DimValues = 3;

DataPositions = [];
DataVelocities = [];
DataAccelerations = [];

tpts = 0:2;
tvec = ti:Ts:tf;

for i=1:DimValues
    if i==1
      %waypoints for joint 1
      wpts = [0 pi 0; 0 pi 0];  
    end
    if i==2
      %waypoints for joint 2
      wpts = [0 -0.2 -0.1; 0 -0.2 -0.1];  
    end
    if i==3
      %waypoints for joint 3
      wpts = [0 pi pi/2; 0 pi pi/2];  
    end
    
    [q, dq, ddq, pp] = cubicpolytraj(wpts, tpts, tvec);
    DataPositions(i, :) = q(1,:);
    DataVelocities(i, :) = dq(1,:);
    DataAccelerations(i, :) = ddq(1,:);
end

qd.time=tvec;
qd.signals.values=DataPositions';
qd.signals.dimensions=DimValues;

dqd.time=tvec;
dqd.signals.values=DataVelocities';
dqd.signals.dimensions=DimValues;

ddqd.time=tvec;
ddqd.signals.values=DataVelocities';
ddqd.signals.dimensions=DimValues;


%%
open('simulink_models\joint_space_inv_dyn.slx');
sim('simulink_models\joint_space_inv_dyn.slx');

%%
% Check that in the nominal case the dynamic behaviour is equivalent to the one of a
% set of stabilized double integrators
KD = [20;100;20];
KP = [80;1000;100];
wrongModel = 0;
sim('simulink_models\joint_space_inv_dyn.slx');

%%
% Check the behavior of the control law when the ^B; ^C; ^g used within the controller are
% different than the “true ones” B;C; g (e.g. slightly modify the masses, the frictions, ...)
KD = [20;20;20];
KP = [100;100;100];
wrongModel = 1;
sim('simulink_models\joint_space_inv_dyn.slx');

%% What happens to the torque values when the settling time of the equivalent second
% order systems is chosen very small?
KD = [40;40;40];
KP = [500;500;500];
wrongModel = 0;
% set step response
sim('simulink_models\joint_space_inv_dyn.slx',1);