function j = getInvJ(q)
%myRobot.setValues(pinv(myRobot.J))
q1 = q(1);
q3 = q(3);

j=[
[                           -(3125*sin(conj(q1)) - 180*sin(conj(q3))*cos(q1)*cos(q3) + 180*sin(conj(q3))*sin(q1)*sin(q3))/(1250*cos(conj(q1))*cos(q1) + 1250*sin(conj(q1))*sin(q1) + 72*sin(conj(q3))*sin(q3)),                              (3125*cos(conj(q1)) + 180*sin(conj(q3))*cos(q1)*sin(q3) + 180*sin(conj(q3))*cos(q3)*sin(q1))/(1250*cos(conj(q1))*cos(q1) + 1250*sin(conj(q1))*sin(q1) + 72*sin(conj(q3))*sin(q3)), 0, 0, 0,                         -(375*cos(q1 + q3 - conj(q1)))/(625*cos(q1 - conj(q1)) + 36*sin(conj(q3))*sin(q3))]
[                                                                                                                                                                                                            0,                                                                                                                                                                                                              0, 1, 0, 0,                                                                                                          0]
[(3125*sin(conj(q1)) - 300*sin(conj(q3))*cos(q1) - 180*sin(conj(q3))*cos(q1)*cos(q3) + 180*sin(conj(q3))*sin(q1)*sin(q3))/(1250*cos(conj(q1))*cos(q1) + 1250*sin(conj(q1))*sin(q1) + 72*sin(conj(q3))*sin(q3)), -(3125*cos(conj(q1)) + 300*sin(conj(q3))*sin(q1) + 180*sin(conj(q3))*cos(q1)*sin(q3) + 180*sin(conj(q3))*cos(q3)*sin(q1))/(1250*cos(conj(q1))*cos(q1) + 1250*sin(conj(q1))*sin(q1) + 72*sin(conj(q3))*sin(q3)), 0, 0, 0, (625*cos(q1 - conj(q1)) + 375*cos(q1 + q3 - conj(q1)))/(625*cos(q1 - conj(q1)) + 36*sin(conj(q3))*sin(q3))]
];

end