% Assignement 15
% Implement the Parallel Force/Position Control.

KD = [10;10;50;10;10;10];
KP = [20;20;10;20;20;20];
Md = diag([0.3;0.2;1;1;1;1]);
KI = 0;
KF = 5;

invMd = inv(Md);
Value;
g_q = [0;-g*m2-g*m3;0];

K = diag([1 1 100 1 1 1]);
fd = [0 0 -0.5 0 0 0]';

qi = [0 0 0]';
dqi = [0;0;0];
qf = [0 -0.2 0]';
qr = [0 -0.1 0];

Ts = 0.001;

xi = getK(qi);
xd = getK(qf);
xr = getK(qr);

%open('simulink_models\parallel_force_pos_control.slx');
sim('simulink_models\parallel_force_pos_control.slx');
%%
KI = 5;
KF = 5;
%open('simulink_models\parallel_force_pos_control.slx');
sim('simulink_models\parallel_force_pos_control.slx');