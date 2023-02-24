% Assignement 15
% Implement the Parallel Force/Position Control.

KD = [80;80;80;10;10;10];
KP = [50;50;50;50;50;50];
Md = diag([0.3;0.2;1;1;1;1]);
KI = 0;
KF = 5;

invMd = inv(Md);
Value;
g_q = [0;-g*m2-g*m3;0];

K = diag([100 100 1 1 1 1]);
fd = [-1 -1 0 0 0 0]';

qi = [0 0 0]';
dqi = [0;0;0];
qf = [0 -0.2 pi/4]';
qr = [0 -0.2 pi/5];

Ts = 0.001;

xi = getK(qi);
xd = getK(qf);
xr = getK(qr);

open('simulink_models\parallel_force_pos_control.slx');
sim('simulink_models\parallel_force_pos_control.slx');
%%
KI = 20;
KF = 5;
open('simulink_models\parallel_force_pos_control.slx');
sim('simulink_models\parallel_force_pos_control.slx');