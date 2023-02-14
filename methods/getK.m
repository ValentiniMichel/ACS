function k = getK(q)
%myRobot.setValues(myRobot.allT(:,:,end))
q1 = q(1); q2 = q(2); q3 = q(3);
d0 = 0.15;
a1 = 0.4;
d2= 0.3;
a3 = 0.24;
piM = pi/2;

%T = [
%    [(4967757600021511*cos(q1)*cos(q3))/81129638414606681695789005144064 - (4967757600021511*sin(q1)*sin(q3))/81129638414606681695789005144064, - cos(q1)*sin(q3) - cos(q3)*sin(q1),                 cos(q1)*cos(q3) - sin(q1)*sin(q3), a1*cos(q1) + a3*cos(q1)*cos(q3) - a3*sin(q1)*sin(q3)]
%    [(4967757600021511*cos(q1)*sin(q3))/81129638414606681695789005144064 + (4967757600021511*cos(q3)*sin(q1))/81129638414606681695789005144064,   cos(q1)*cos(q3) - sin(q1)*sin(q3),                 cos(q1)*sin(q3) + cos(q3)*sin(q1), a1*sin(q1) + a3*cos(q1)*sin(q3) + a3*cos(q3)*sin(q1)]
%    [                                                                                                                                       -1,                                   0, 4967757600021511/81129638414606681695789005144064,                                         d0 + d2 + q2]
%    [                                                                                                                                        0,                                   0,                                                 0,                                                    1]
%];

T = [
[cos(piM)*(cos(q1)*cos(q3) - sin(q1)*sin(q3)), - cos(q1)*sin(q3) - cos(q3)*sin(q1), sin(piM)*(cos(q1)*cos(q3) - sin(q1)*sin(q3)), a1*cos(q1) + a3*cos(q1)*cos(q3) - a3*sin(q1)*sin(q3)]
[cos(piM)*(cos(q1)*sin(q3) + cos(q3)*sin(q1)),   cos(q1)*cos(q3) - sin(q1)*sin(q3), sin(piM)*(cos(q1)*sin(q3) + cos(q3)*sin(q1)), a1*sin(q1) + a3*cos(q1)*sin(q3) + a3*cos(q3)*sin(q1)]
[                                   -sin(piM),                                   0,                                     cos(piM),                                         d0 + d2 + q2]
[                                           0,                                   0,                                            0,                                                    1]
]; 

p = T(1:3, 4);

phi = [
    atan2(T(2,3), T(1,3));
    atan2(sqrt(T(1,3)^2+T(2,3)^2),T(3,3));
    atan2(T(3,2), -T(3,1));
];

k = [p;phi];
end

