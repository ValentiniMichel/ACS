
% help show
% help rigidBodyJoint
% help rigidBodyTree
% help rigidBody

%show(robot,config);
clear all;
close all;
addpath methods assignments classes;
syms d0 d2 dB a1 a3 q1 q2 q3 m1 m2 m3 ra1 s2 ra3 L1 L2 L3 real;

DH = [
    0 0 d0 0
    a1 0 0 q1
    0 0 q2+d2 0
    a3 0 0 q3
    ];

links = [
    Link("cyl", m1, ra1, 0, L1, [-L1/2;0;0]) 
    Link("box", m2, s2, s2, L2, [0;0;-L2/2])
    Link("cyl", m3, ra3, 0, L3, [-L3/2;0;0])
];

myRobot = MyRobot('RPR_zzz.urdf', DH, links);

% for visual simulation in simulink 3d model 
rbt = importrobot('RPR_zzz.urdf');







