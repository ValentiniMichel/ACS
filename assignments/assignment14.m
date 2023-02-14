% Assingment 14
% Implement the Force Control with Inner Position Loop


KD = [80;80;80;10;10;10];
KP = [5;5;5;50;50;50];
Md = diag([0.1;0.1;0.1;1;1;1]);
KI = 0;
KF = 5;

invMd = inv(Md);
Value;
g_q = [0;-g*m2-g*m3;0];

K = diag([100 100 0 0 0 0]);

fd = [-0.5 -0.5 0 0 0 0]';

qi = [0 0 0]';
dqi = [0;0;0];
qf = [0 0 pi/2]';
qr = [0 0 pi/3]';

Ts = 0.001;

xi = getK(qi);
xf = getK(qf);
xr = getK(qr);

open('simulink_models\force_control.slx');
sim('simulink_models\force_control.slx');

%%
KI = 4;
KF = 5;
sim('simulink_models\force_control.slx');
%%
KI = 1;
KF = 1;
sim('simulink_models\force_control.slx');