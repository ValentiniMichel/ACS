function dJa = getdJa(q, dq)
q=q';
dq=dq';
q1 = q(1);
q3 = q(3);
a3 = 0.24;
a1 = 0.4;
dq1 = dq(1);
dq2 = dq(2);
dq3 = dq(3);

%dJa = [
%[-a3*(cos(q1+q3)*(diff(q1)+diff(q3))) - a1*(cos(q1)),   0, -a3*(cos(q1+q3)*(diff(q1)+diff(q3)))]
%[ a3*(-sin(q1+q3)*(diff(q1)+diff(q3))) + a1*(-sin(q1)), 0, a3*(-sin(q1+q3)*(diff(q1)+diff(q3)))]
%[                                                   0,  1,                                    0]
%[                                                   1,  0,                                    1]
%[                                                   0,  0,                                    0]
%[                                                   0,  0,                                    0]
%];


dJa = [
[-a3*(cos(q1+q3)*(dq1+dq3)) - a1*(cos(q1)),    0,  -a3*(cos(q1+q3)*(dq1+dq3))]
[a3*(-sin(q1+q3)*(dq1+dq3)) + a1*(-sin(q1)),   0,  a3*(-sin(q1+q3)*(dq1+dq3))]
[                                           0,  0,                          0]
[                                           0,  0,                          0]
[                                           0,  0,                          0]
[                                           0,  0,                          0]
];




end