function [config1, config2] = ik()

    syms d0 d2 Px Pz a1 a3 c1 s1 c3 s3;
    Py = sym('Py');
    q2 = Pz - (d0 + d2);

    c3 = ((Px^2+Py^2-(a1^2+a3^2))/2*a1*a3);
    s3 = sqrt(1-c3^2);

    s1 = ((a1+a3*c3)*Py - a3*s3*Px)/Px^2+Py^2;
    c1 = ((a1+a3*c3)*Px - a3*s3*Py)/Px^2+Py^2;

    teta3_1 = atan2(+s3, c3);
    teta3_2 = atan2(-s3, c3);
    teta1_1 = atan2(s1, c1);
    config1 = [teta1_1;q2;teta3_1];
    config2 = [teta1_1;q2;teta3_2];
end

