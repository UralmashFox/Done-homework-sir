%[Js, Ax2, Ax3, Ay1, Ay2, Ay3, Az1, Az2, Az3, px1s, px2s, px3s, py1s, py2s, py3s, pz1s, pz2s, pz3s] = Jacobians_partial_derivatives_in_syms()

clear all
close all
clc

[Ax0, Ax1, Ax2, Ax3, Ay1, Ay2, Ay3, Az1, Az2, Az3] = Jacobians_partial_derivatives_in_syms()
d2 = 13
%let's estimate velocities: 
% omega0 = 3.0
% omega1 = 2.0
% velocity3 = 1.0
n=1
t = 0
time = 0
while t<15
    time(n) = t
    theta0n = double(sin(t-1))      %count position
    theta1n = double(cos(2*(t-1)))
    d3n = double(sin(3*(t-1)))
    
    omega0 = cos(t-1)               %count velocities
    omega1 = -2*sin(2*(t-1))
    velocity3 = 3*cos(3*(t-1))


% [ -cos(theta1)*sin(theta0)*(d2 + d3), -cos(theta0)*sin(theta1)*(d2 + d3), cos(theta0)*cos(theta1)]
% [  cos(theta0)*cos(theta1)*(d2 + d3), -sin(theta0)*sin(theta1)*(d2 + d3), cos(theta1)*sin(theta0)]
% [                                  0,              cos(theta1)*(d2 + d3),             sin(theta1)]
% [                                  0,                                  0,                       0]
% [                                  0,                                  0,                       0]
% [                                  1,                                  1,                       0]

    px1s = -cos(theta1n)*sin(theta0n)*(d2 + d3n)    %count Jacobian elements
    px2s = -cos(theta0n)*sin(theta1n)*(d2 + d3n)
    px3s = cos(theta0n)*cos(theta1n)
    py1s = cos(theta0n)*cos(theta1n)*(d2 + d3n)
    py2s = -sin(theta0n)*sin(theta1n)*(d2 + d3n)
    py3s = cos(theta1n)*sin(theta0n)
    pz1s = 0
    pz2s = cos(theta1n)*(d2 + d3n)
    pz3s = sin(theta1n)

    Js = [px1s px2s px3s
          py1s py2s py3s   %Jacobian matrix
          pz1s pz2s pz3s
          Ax1  Ax2  Ax3
          Ay1  Ay2  Ay3
          Az1  Az2  Az3]

       velocity = [omega0 omega1 velocity3]' %velocity vector of joints
       
       response = Js*velocity %total information of velocities for EF

    response1(n) = response(1)
    response2(n) = response(2)
    response3(n) = response(3)
    response4(n) = response(4)
    response5(n) = response(5)
    response6(n) = response(6)
    
    EFvelocity(n) = sqrt(response1(n)^2+response2(n)^2+response3(n)^2) %velocity is a square root of sum of squared projection on x, y, z - axes
    EFomega(n) = sqrt(response4(n)^2+response5(n)^2+response6(n)^2) % the same for angular velocity
    
    n=n+1
    t = t+0.1
end
hold on
plot(time, EFvelocity, time, EFomega, 'red')
legend('linear velocity', 'angular velocity')



