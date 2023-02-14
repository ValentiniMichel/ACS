function n = getN(q, dq)
%myRobot.setValues(myRobot.C*myRobot.dq+myRobot.G) 
q1 = q(1);
q3 = q(3);
dq1 = dq(1);
dq3 = dq(3);
m2 = 0.2;
m3 = 0.1;
L3 = 0.24;
a1 = 0.4;
a3 = 0.24;
g=-9.81;


%lag
%n = [
%    0
%2.943
%    0
%];


n=[
(m3*sin(2*q1)*L3^2*dq1^2)/8 - (m3*sin(2*q1)*L3^2*dq3^2)/8 + (4967757600021511*a1*m3*sin(q3)*L3*dq1*dq3)/81129638414606681695789005144064 + (4967757600021511*a1*m3*sin(q3)*L3*dq3^2)/162259276829213363391578010288128 - 2*a1*a3*m3*sin(q3)*dq1*dq3 - a1*a3*m3*sin(q3)*dq3^2
                                                                                                                                                                                                                                                                -g*(m2 + m3)
                                                                                                                                                                                                                                               (L3^2*dq1*dq3*m3*sin(2*q1))/8
];       
 



end

