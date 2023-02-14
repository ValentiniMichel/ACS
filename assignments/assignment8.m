% Assignment 8
% Implement in Simulink the Adaptive Control law for the a 1-DoF link under gravity

KD = 40;%80;
lambda = 300;
Ktheta = inv(diag([1000 100 100]));
I = 0.3; %0.3;
F = 0.1;
G = 2.943; %0.5;
I_est = I-0.01;%*0.05;
F_est = F-0.01;%*0.05;
G_est = G-0.01;%*0.05;%-0.01;
A = 1;
qi = 0;
dqi = 0;
Ts = 0.001;

%%
open('simulink_models\joint_space_adaptive.slx');
sim('simulink_models\joint_space_adaptive.slx');