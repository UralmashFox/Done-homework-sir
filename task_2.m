%syms px py pz d1 a2
clear all
clc
[theta0, theta1, px, py, pz, d3, d2, d1,x0, y0, z0, A0,x1, y1, z1, A1, A2] = forward()
d3 = sqrt((pz-d1)^2+px^2)-d2
theta1 = rad2deg(atan2((pz-d1),sqrt(py^2+px^2)))
theta0 = rad2deg(atan2(py, px))



