function [t,y] = simulate_pendulum(tspan, y0, l1, l2, m1, m2)
%{
    Variable definitions
    t_1 = theta of first bob at t         tspan = time to integrate over
    t_2 = theta of second bob at t        y0 = initial vector of values
    m1 = mass of first bob                    (omeg1,omeg2,t1,t2) at t=0
    m2 = mass of second bob               y = solution vector 
    l1 = length of rope 1                     (omega)
    l2 = length of rope 3
    o1 = angular vel bob 1
    o2 = angular vel bob 2
%}

%constants
g = 9.81; %m/s^2

%define functions to make algebra easier (shown in piazza post)
a = (m1 + m2)*l1;
b = @(t_1,t_2)  m2*l2*cos(t_1 - t_2);
c = @(t_1,t_2)  m2*l1*cos(t_1 - t_2);
d = m2*l2;
e = @(t_1, t_2, o2) (-1*m2*l2*sin(t_1 - t_2)*o2^2) - ...
                                          (g * (m1+m2) *sin(t_1));
f = @(t_1, t_2, o1) (m2 * l1 * o1^2 * sin(t_1-t_2)) - ...
                                          (m2 * g * sin(t_2));

%set up function for ode45 (should be [ang acel 1,ang acel 2, o1, o2])  
F = @(t,y) [ (e(y(3),y(4),y(2)) - b(y(3),y(4)) * ((f(y(3),y(4),y(1)) - ((c(y(3),y(4)) * e(y(3),y(4),y(2)))/a))/(d-((c(y(3),y(4))*b(y(3),y(4)))/a))) )/a; ...
              (f(y(3),y(4),y(1)) - ((c(y(3),y(4))*e(y(3),y(4),y(2)))/a))/(d - ((c(y(3),y(4))*b(y(3),y(4)))/a)); y(1);y(2)];
[t, y] = ode45(F, tspan, y0);
end

