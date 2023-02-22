function j = getInvJa(q)
%simplify(pinv(Ja))
q3 = q(3);
q1 = q(1);

j = [
[                                                       -(90*sin(q1 + 2*q3) - 3215*sin(q1))/(36*cos(2*q3) - 1286),                                                         (90*cos(q1 + 2*q3) - 3215*cos(q1))/(36*cos(2*q3) - 1286), 0,        (375*cos(q3))/(36*cos(q3)^2 - 661), 0, 0]
[                                                                                                               0,                                                                                                                0, 1,                                         0, 0, 0]
[(300*cos(q1)*sin(q3) - 3305*sin(q1) + 180*cos(q3)^2*sin(q1) + 180*cos(q1)*cos(q3)*sin(q3))/(72*cos(q3)^2 - 1322), (3305*cos(q1) + 300*sin(q1)*sin(q3) - 180*cos(q1)*cos(q3)^2 + 180*cos(q3)*sin(q1)*sin(q3))/(72*cos(q3)^2 - 1322), 0, -(375*cos(q3) + 625)/(36*cos(q3)^2 - 661), 0, 0]
];







end

