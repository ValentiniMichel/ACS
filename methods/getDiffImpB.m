function db = getDiffImpB(xd,dxd,ddxd,xe,dxe, Td,q)
%Rotation Matrix
Rdt = Td(1:3, 1:3)';
%Desired pos
od = xd(1:3);

%Desired vel
dod = dxd(1:3);
wd = dxd(4:6);

%Desired acc
ddod = ddxd(1:3);
dwd = ddxd(4:6);

%Pos end effector
oe = xe(1:3);

%Vel end effector
doe = dxe(1:3);

%Trasformation matrix end eff
Tde = getTde(q, Td);

angles = tform2eul(Tde, 'ZYZ');
phi =   angles(1);
theta = angles(2);

dphi = wd(1);
dtheta = wd(2);

T = [
    0, -sin(phi), cos(phi)*sin(theta)
    0,  cos(phi), sin(phi)*sin(theta)
    1,         0,          cos(theta)
];

%derivative T
dT = [
0, -cos(phi)*dphi, -sin(phi)*sin(theta)*dphi+cos(phi)*cos(theta)*dtheta
0, -sin(phi)*dphi, cos(phi)*sin(theta)*dtheta+sin(phi)*cos(theta)*dtheta
0, 0, -sin(theta)*dtheta
];

invT = pinv(T);
invDT = -invT*dT*invT;


swd=[0 -wd(3) wd(2)
    wd(3) 0 -wd(1)
    -wd(2) wd(1) 0 ];


sdwd=[0 -dwd(3) dwd(2)
    dwd(3) 0 -dwd(1)
    -dwd(2) dwd(1) 0 ];

db = [
    Rdt*swd*dod+Rdt*ddod+Rdt*sdwd*(od-oe)+Rdt*swd*(dod-doe)
    invDT*Rdt*wd+invT*Rdt*dwd
];
end

