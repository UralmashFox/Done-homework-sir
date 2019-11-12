function[Js, Ax0, Ax1, Ax2, Ax3, Ay1, Ay2, Ay3, Az1, Az2, Az3, px1s, px2s, px3s, py1s, py2s, py3s, pz1s, pz2s, pz3s] = Jacobians_partial_derivatives_in_syms
[theta0, theta1, px, py, pz, d3, d2, d1, x0, y0, z0, A0, x1, y1, z1, A1, A2] = forward_syms();
%we have got coordinates: px, py, pz
%our variables are: theta0, theta1, d3
Ax0 = 0
px1s = diff(px, theta0, 1)
px1 = double(subs(px1s,{theta1,theta0,d2,d3},{deg2rad(24),deg2rad(42),13,5}))
px2s = diff(px, theta1, 1)
px2 = double(subs(px2s,{theta0,theta1,d2,d3},{deg2rad(42),deg2rad(24),13,5}))
px3s = diff(px, d3, 1)
px3 = double(subs(px3s,{theta0,theta1},{deg2rad(42),deg2rad(24)}))

py1s = diff(py, theta0, 1)
py1 = double(subs(py1s,{theta0,theta1,d2,d3},{deg2rad(42),deg2rad(24),13,5}))
py2s = diff(py, theta1, 1)
py2 = double(subs(py2s,{theta0,theta1,d2,d3},{deg2rad(42),deg2rad(24),13,5}))
py3s = diff(py, d3, 1)
py3 = double(subs(py3s,{theta1,theta0},{deg2rad(24),deg2rad(42)}))

pz1s = diff(pz, theta0, 1)
pz1 = double(pz1s)
pz2s = diff(pz, theta1, 1)
pz2 = double(subs(pz2s,{theta1,d2,d3},{deg2rad(24),13,5}))
pz3s = diff(pz, d3, 1)
pz3 = double(subs(pz3s,{theta1},{deg2rad(24)}))
%Now, we need to find rotational parts.

Ax1 = double(0) %rotation Angle around X-axis of 1st joint
Ax2 = 0 %rotation Angle around X-axis of 2nd joint
Ax3 = 0 %rotation Angle around X-axis of 3rd joint

Ay1 = 0 %rotation Angle around Y-axis of 1st joint
Ay2 = 0 %rotation Angle around Y-axis of 2nd joint
Ay3 = 0 %rotation Angle around Y-axis of 3rd joint

Az1 = 1 %rotation Angle around X-axis of 1st joint
Az2 = 1 %rotation Angle around X-axis of 2nd joint
Az3 = 0 %rotation Angle around X-axis of 3rd joint

%Finnaly, Jacobians (louder applause!)

Js = [px1s px2s px3s
      py1s py2s py3s
      pz1s pz2s pz3s
      Ax1  Ax2  Ax3
      Ay1  Ay2  Ay3
      Az1  Az2  Az3]
 
J = [px1 px2 px3
     py1 py2 py3
     pz1 pz2 pz3
     Ax1 Ax2 Ax3
     Ay1 Ay2 Ay3
     Az1 Az2 Az3]
% subs (J, theta1, deg2rad(90))
% subs (J, d1, 8)
% subs (J, d2, 13)
% subs (J, d3, 5)
end

