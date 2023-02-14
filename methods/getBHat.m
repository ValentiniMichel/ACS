function B = getBHat(q)
%myRobot.B_RNE
q1=q(1);
q3=q(3);
L1 = 0.4;
L2 = 0.3;
L3 = 0.24;

a1 = 0.4;
a3 = 0.24;

%mass link
m1 = 0.4;
m2 = 0.3;
m3 = 0.2;

%size
ra1 = 0.02;
s2 = 0.3;
ra3 = 0.02;
piM=pi/2;



B = [
[            (m1*(L1^2 + 3*ra1^2))/2 + sin(piM)^2*((m3*ra3^2)/2 + (L3^2*m3*sin(q1)^2)/4) + (L1^2*m1)/4 + (m2*(L2^2 + s2^2))/12 + cos(piM)^2*((m3*(L3^2 + 3*ra3^2))/2 + m3*((L3^2*cos(q1)^2)/4 + (L3^2*sin(q1)^2)/4)) + m2*(a1^2*cos(q1)^2 + a1^2*sin(q1)^2) + m3*((a1*cos(q1) - (L3*cos(piM)*(cos(q1)*cos(q3) - sin(q1)*sin(q3)))/2 + a3*cos(q1)*cos(q3) - a3*sin(q1)*sin(q3))^2 + (a1*sin(q1) - (L3*cos(piM)*(cos(q1)*sin(q3) + cos(q3)*sin(q1)))/2 + a3*cos(q1)*sin(q3) + a3*cos(q3)*sin(q1))^2) + m1*(((L1*cos(q1))/2 - a1*cos(q1))^2 + ((L1*sin(q1))/2 - a1*sin(q1))^2),       0, sin(piM)^2*((m3*ra3^2)/2 + (L3^2*m3*sin(q1)^2)/4) - m3*(((L3*cos(piM)*(cos(q1)*cos(q3) - sin(q1)*sin(q3)))/2 - a3*cos(q1)*cos(q3) + a3*sin(q1)*sin(q3))*(a1*cos(q1) - (L3*cos(piM)*(cos(q1)*cos(q3) - sin(q1)*sin(q3)))/2 + a3*cos(q1)*cos(q3) - a3*sin(q1)*sin(q3)) - (a3*cos(q1)*sin(q3) - (L3*cos(piM)*(cos(q1)*sin(q3) + cos(q3)*sin(q1)))/2 + a3*cos(q3)*sin(q1))*(a1*sin(q1) - (L3*cos(piM)*(cos(q1)*sin(q3) + cos(q3)*sin(q1)))/2 + a3*cos(q1)*sin(q3) + a3*cos(q3)*sin(q1))) + cos(piM)^2*((m3*(L3^2 + 3*ra3^2))/2 + m3*((L3^2*cos(q1)^2)/4 + (L3^2*sin(q1)^2)/4))]
[                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         0, m2 + m3,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          0]
[sin(piM)^2*((m3*ra3^2)/2 + (L3^2*m3*sin(q1)^2)/4) - m3*(((L3*cos(piM)*(cos(q1)*cos(q3) - sin(q1)*sin(q3)))/2 - a3*cos(q1)*cos(q3) + a3*sin(q1)*sin(q3))*(a1*cos(q1) - (L3*cos(piM)*(cos(q1)*cos(q3) - sin(q1)*sin(q3)))/2 + a3*cos(q1)*cos(q3) - a3*sin(q1)*sin(q3)) - (a3*cos(q1)*sin(q3) - (L3*cos(piM)*(cos(q1)*sin(q3) + cos(q3)*sin(q1)))/2 + a3*cos(q3)*sin(q1))*(a1*sin(q1) - (L3*cos(piM)*(cos(q1)*sin(q3) + cos(q3)*sin(q1)))/2 + a3*cos(q1)*sin(q3) + a3*cos(q3)*sin(q1))) + cos(piM)^2*((m3*(L3^2 + 3*ra3^2))/2 + m3*((L3^2*cos(q1)^2)/4 + (L3^2*sin(q1)^2)/4)),       0,                                                                                                                                                                                                                       sin(piM)^2*((m3*ra3^2)/2 + (L3^2*m3*sin(q1)^2)/4) + m3*((a3*cos(q1)*sin(q3) - (L3*cos(piM)*(cos(q1)*sin(q3) + cos(q3)*sin(q1)))/2 + a3*cos(q3)*sin(q1))^2 + ((L3*cos(piM)*(cos(q1)*cos(q3) - sin(q1)*sin(q3)))/2 - a3*cos(q1)*cos(q3) + a3*sin(q1)*sin(q3))^2) + cos(piM)^2*((m3*(L3^2 + 3*ra3^2))/2 + m3*((L3^2*cos(q1)^2)/4 + (L3^2*sin(q1)^2)/4))]
];

end

