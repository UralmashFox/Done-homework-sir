clc
clear all
close all
[d1, d2, d3] = forward()
n=0
t = 0
while t<15
    n=n+1
    time(n)= t
    px = 2*d2*sin(t)
    py = 2*d2*cos(2*t)
    pz = d1*sin(3*t)

    d3(n) = sqrt((pz-d1)^2+px^2)-d2
    theta1(n) = rad2deg(atan2((pz-d1),sqrt(py^2+px^2)))
    theta0(n) = rad2deg(atan2(py, px))
    t = t+0.1
end
hold on
plot(time, theta0, time, theta1, 'red', time, d3, 'black')
legend('\theta1', '\theta2', 'd3')