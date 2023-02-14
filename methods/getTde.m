function Tde = getTde(q, Td)
% get transform from desired frame to end effector frame

q1 = q(1); 
q2 = q(2); 
q3 = q(3);
d0 = 0.15;
a1 = 0.4;
d2= 0.3;
a3 = 0.24;

%correct
Te = [
    [(4967757600021511*cos(q1)*cos(q3))/81129638414606681695789005144064 - (4967757600021511*sin(q1)*sin(q3))/81129638414606681695789005144064, - cos(q1)*sin(q3) - cos(q3)*sin(q1),                 cos(q1)*cos(q3) - sin(q1)*sin(q3), a1*cos(q1) + a3*cos(q1)*cos(q3) - a3*sin(q1)*sin(q3)]
    [(4967757600021511*cos(q1)*sin(q3))/81129638414606681695789005144064 + (4967757600021511*cos(q3)*sin(q1))/81129638414606681695789005144064,   cos(q1)*cos(q3) - sin(q1)*sin(q3),                 cos(q1)*sin(q3) + cos(q3)*sin(q1), a1*sin(q1) + a3*cos(q1)*sin(q3) + a3*cos(q3)*sin(q1)]
    [                                                                                                                                       -1,                                   0, 4967757600021511/81129638414606681695789005144064,                                         d0 + d2 + q2]
    [                                                                                                                                        0,                                   0,                                                 0,                                                    1]
];

%Tde = inv(Td)*Te;
Tde = Td/Te;

end 