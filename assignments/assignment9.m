% Assignment 9
% Design the Operational Space PD control law with gravity compensation

KD = [80;200;50;10;10;10];
KP = [1000;500;50;50;50;50];

Value;
g_q = [0;-g*m2-g*m3;0];

% simulink trajectory
qi = [0 0 0]';
qf = [0 -0.2 -pi/2]';
dqi = [0 0 0]';
ti = 0;
tf = 10;
Ts = 0.001;

xi = getK(qi);
xd = getK(qf);

open('simulink_models\operational_space_pd_w_g_comp.slx');
sim('simulink_models\operational_space_pd_w_g_comp.slx');
