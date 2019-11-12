clc
clear all
close all
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
%all the joint possitions are integrals from J^(-1)*[omega0 omega1 v2]'
[d1, d2, d3] = forward()
n=0
t = 0
syms x
while t<2
    n=n+1
    time(n)= t
    
    px = 2*d2*sin(x)
    py = 2*d2*cos(2*x)
    pz = d1*sin(3*x)
    
    Js = [px1s px2s px3s
          py1s py2s py3s
          pz1s pz2s pz3s]
      
     Jis = inv(Js)
     
    omega0 = cos(x-1)
    omega1 = -2*sin(2*(x-1))
    velocity3 = 3*cos(3*(x-1))
    
    v1s = sum([Jis(1,1) Jis(1,2) Jis(1,3)]*[omega0 omega1 velocity3]')
    v2s = sum([Jis(2,1) Jis(2,2) Jis(2,3)]*[omega0 omega1 velocity3]')
    v3s = sum([Jis(3,1) Jis(3,2) Jis(3,3)]*[omega0 omega1 velocity3]')
    %now main part of the task:
    
    d3_sys(n) = int(v3s,'x')
    theta1_sys(n) = int(v2s,'x')
    theta0_sys(n) = int(v1s, 'x') 
    t = t+0.1
end