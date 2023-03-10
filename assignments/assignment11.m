% Assignment 11
% Study the compliance control. Simulate the two “extreme” cases when the
% end-effector is interacting with the environment (considered as a planar surface)

% case K << KP
KD = [30;30;30;10;10;10];
KP = [30;30;30;10;10;10];
Value;
g_q = [0;-g*m2-g*m3;0];

qi = [0;0;0];
dqi = [0;0;0];
qf = [0; -0.2; 0];
qr = [0; -0.1; 0];
Ts = 0.001;
xi = getK(qi);
xd = getK(qf);
xr = getK(qr);

K=diag([1 1 1 1 1 1]);

%%
open('simulink_models\compliance_control.slx');
%sim('simulink_models\compliance_control.slx');

%% case K >> KP
K = diag([1 1 500 1 1 1]);
sim('simulink_models\compliance_control.slx');

%% case K == KP
K = diag([1 1 30 1 1 1]);
sim('simulink_models\compliance_control.slx');

