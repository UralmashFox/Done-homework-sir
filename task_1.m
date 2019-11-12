%function [px, py, pz, d2, d1,x0, y0, z0, A0,x1, y1, z1, A1, A2] = forward()
function[theta0, theta1, px, py, pz, d3, d2, d1,x0, y0, z0, A0,x1, y1, z1, A1, A2] = forward();
close all
clear all
clc
%syms theta0 theta1 d1 d2 d3
theta0 = deg2rad(42), theta1 = deg2rad(24), d1 = 8, d2 = 13, d3 = 5

R0  = [cos(theta0) -sin(theta0) 0
       sin(theta0)  cos(theta0) 0
           0               0    1]
    
Rt0 = [1    0   0
       0    0  -1
       0    1   0]
   
 A0 = R0*Rt0
 T01 = [A0(1,1) A0(1,2) A0(1,3)    0
        A0(2,1) A0(2,2) A0(2,3)    0       
        A0(3,1) A0(3,2) A0(3,3)    d1        
         0        0        0       1     ]
     
  x0 = T01(1,4)
  y0 = T01(2,4)
  z0 = T01(3,4)
     
 R1  = [cos(theta1) -sin(theta1) 0
        sin(theta1)  cos(theta1) 0
            0               0    1]
 
 Rt1 = [0   0   1
        1   0   0
        0   1   0]
    
 A1 = R1*Rt1
 
 T12 = [A1(1,1) A1(1,2) A1(1,3)    0
        A1(2,1) A1(2,2) A1(2,3)    0       
        A1(3,1) A1(3,2) A1(3,3)    0        
         0        0        0       1     ]
     
  x1 = T12(1,4)
  y1 = T12(2,4)
  z1 = T12(3,4)
  
        
 Rt2 = [1    0   0
        0    1   0
        0    0   1]
    
 A2 = Rt2
   
 T2ef =[A2(1,1) A2(1,2) A2(1,3)    0
        A2(2,1) A2(2,2) A2(2,3)    0       
        A2(3,1) A2(3,2) A2(3,3)    d2+d3        
         0        0        0       1     ]
   
 T = T01*T12*T2ef
 px = T(1,4)
 py = T(2,4)
 pz = T(3,4)
end