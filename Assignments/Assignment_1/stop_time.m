function [t_fin] = stop_time(theta, vel)
%{
stop_time will calculate the time at which the projectile
hits the ground after launch
Inputs: 
    theta: inital angle 
    vel: initial velocity 

Outputs:
    t_fin: time at which projectiles alt. is 0 m

Author: Connor O'Reilly
Collabrators: none
Last Edited: 1/15/2020
%}

%gravity constant
g = -9.81; %(m/s^2) 

%set up for quadratic eq
A = .5 * g;
B = vel * sind(theta);
C = 0;

%solve
r = roots([A, B, C]); %obtains roots of polynomial
t_fin = r(2,1); %first root is 0 so choose second

end

