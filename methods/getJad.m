function Jad = getJad(q, xTilde, Td)
%get transform from desired frame to end effector frame 

q1 = q(1);
q3 = q(3);
a1 = 0.4;
a3 = 0.24;

Tde = getTde(q, Td);
%slide 29, robotics Kinematics
angles = tform2eul(Tde, 'ZYZ');
phi =   angles(1);
theta = angles(2);

% Rd = Td(1:3, 1:3);
Rd = eul2rotm(xTilde(4:6)');
%correct
Ta = [
[1, 0, 0, 0,         0,                   0]
[0, 1, 0, 0,         0,                   0]
[0, 0, 1, 0,         0,                   0]
[0, 0, 0, 0, -sin(phi), cos(phi)*sin(theta)]
[0, 0, 0, 0,  cos(phi), sin(phi)*sin(theta)]
[0, 0, 0, 1,         0,          cos(theta)]    
];

%correct
J = [
[- a3*sin(q1 + q3) - a1*sin(q1), 0, -a3*sin(q1 + q3)]
[  a3*cos(q1 + q3) + a1*cos(q1), 0,  a3*cos(q1 + q3)]
[                             0, 1,                0]
[                             0, 0,                0]
[                             0, 0,                0]
[                             1, 0,                1]
];

% R matrix slide 14 
R = [Rd' zeros(3,3)
    zeros(3,3) Rd'];

Jad = pinv(Ta)*R*J;