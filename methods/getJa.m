function Ja = getJa(q)
%q2 = q(2);
q=q';
q1 = q(1);
q3 = q(3);
a3 = 0.24;
a1 = 0.4;

Ja = [
[- a3*sin(q1 + q3) - a1*sin(q1), 0, -a3*sin(q1 + q3)]
[  a3*cos(q1 + q3) + a1*cos(q1), 0,  a3*cos(q1 + q3)]
[                             0, 1,                0]
[                             1, 0,                1]
[                             0, 0,                0]
[                             0, 0,                0]
];



end

