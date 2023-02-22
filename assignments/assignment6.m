% Assignment 6
% Design the Joint Space PD control law with gravity compensation
% What happens if g(q) is not taken into account?
% What happens if the gravity term is set constant and equal to g(qd ) within the control law?
% What happens if qd is not constant (e.g. qd (t) = hat_qd + delta sin(wt))?

%joint space pd control with gravity compensation
KD = [5;5;5];
KP = [50;50;50];

Value;

g_q = [0;-g*m2-g*m3;0];
addNoise = 0;

qi = [0 0 0]';
qd = [pi -0.2  -pi]';
dqi = [0 0 0]';
Ts = 0.001;
open('simulink_models\joint_space_pd_w_g_comp.slx');
%sim('simulink_models\joint_space_pd_w_g_comp.slx');

%% What happens if g(q) is not taken into account?

addNoise = 0;
% moment vector affected by gravity term is setup to zero
g_q = zeros(3,1);
sim('simulink_models\joint_space_pd_w_g_comp.slx');

%% What happens if the gravity term is set constant and equal to g(qd ) within the control law?
KD = [10;10;10];
KP = [100;100;100];
g_q = [0;(-g*m2-g*m3)*2;0]; 
sim('simulink_models\joint_space_pd_w_g_comp.slx');

%% What happens if qd is not constant (e.g. qd (t) = hat_qd + delta sin(wt))?
addNoise=1;
%0.1
g_q = [0; -g*m2-g*m3;0]; 
KD = [10;50;10];
KP = [50;1000;50];
sim('simulink_models\joint_space_pd_w_g_comp.slx');
