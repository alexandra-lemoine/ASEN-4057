function [] = plot_traject(theta, vel, t_fin)
%{
plot_traject will plot the trajectory of the projectile using the user
inputs and given functions.

Inputs:
    theta: initial angle of launch (deg)
    vel: initial velocity of projectile (m/s)
    t_fin: time of impact (sec)
Outputs:
    none

Author: Connor O'Reilly
Collabrators: none
Last Edited: 1/15/2020
%}

%initializations

time_vals = linspace(0,t_fin,1000); %large time step for complete graph
g = -9.81; %(m/s)


%Calculating Position with Given functions

x = vel * cosd(theta) .* time_vals; %horizontal displacement 
y = .5 * g .* time_vals.^2 + vel * sind(theta) .* time_vals; %vertical displacement 


%Plot 
figure(1)
plot(x,y)
hold on 
title('Trajectory of Projectile');
xlabel('x-distance (m)')
ylabel('altitude(m)')
axis([0 (x(end)*1.1) 0 (max(y)*1.5)])
grid on 
hold off

end

