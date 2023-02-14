function J = getJ(q)

q1 = q(1);
q3 = q(3);
a3 = 0.24;
a1 = 0.4;

J=[
[- a1*sin(q1) - a3*cos(q1)*sin(q3) - a3*cos(q3)*sin(q1), 0, - a3*cos(q1)*sin(q3) - a3*cos(q3)*sin(q1)]
[  a1*cos(q1) + a3*cos(q1)*cos(q3) - a3*sin(q1)*sin(q3), 0,   a3*cos(q1)*cos(q3) - a3*sin(q1)*sin(q3)]
[                                                     0, 1,                                         0]
[                                                     0, 0,                                         0]
[                                                     0, 0,                                         0]
[                                                     1, 0,                                         1]
];
end