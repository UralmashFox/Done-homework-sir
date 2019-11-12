[theta0, theta1, px, py, pz, d3, d2, d1,x0, y0, z0, A0,x1, y1, z1, A1, A2] = forward();

ZC = [x0 y0 z0] %zero-link coordinates
OC = [x1 y1 z1] %one-link coorinates
EC = [px py pz] %end-effector coordinates

RomegaX = 0 %rotation of revolute joint around X
RomegaY = 0 %rotation of revolute joint around Y
RomegaZ = 1 %rotation of revolute joint around Z
RO = [RomegaX RomegaY RomegaZ] %Rotational-matrix for revolute joint

TomegaX = 0 %rotation of translational joint around X
TomegaY = 0 %rotation of translational joint around y
TomegaZ = 0 %rotation of translational joint around Z
TO = [TomegaX TomegaY TomegaZ] %Rotational-matrix for prosmatic joint

v0 = cross([0 0 1], EC) %cross-product of the last column of 0-link rotational matrix (from forward kinematics) with EF-coordinates
J0 = [v0(1) v0(2) v0(3) RO(1) RO(2) RO(3)]' %Jacobian of the 0-link link

v1 = (cross((A0*[0 0 1]'), EC-ZC)) %cross-product of the last column of 1-link rotational matrix (from forward kinematics) with (EF-1)-coordinates
J1 = [v1(1) v1(2) v1(3) RO(1) RO(2) RO(3)]' %Jacobian of the 1-link link

v2 = (A0*A1*[0 0 1]') %cross-product of the last column of 1-link rotational matrix (from forward kinematics) with (EF-2)-coordinates
J2 = [v2(1) v2(2) v2(3) TO(1) TO(2) TO(3)]'%Jacobian of the 2-link link

J = [J0(1)  J1(1)   J2(1)
     J0(2)  J1(2)   J2(2)
     J0(3)  J1(3)   J2(3)
     J0(4)  J1(4)   J2(4)
     J0(5)  J1(5)   J2(5)
     J0(6)  J1(6)   J2(6)]


