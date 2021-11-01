%% Header
%Author:    Connor O'reilly and Lukas Rohrmueller
%Date:      January 22nd, 2020
%About:     Assignment 2 Part 1

%% Initialising
clear all
clc
close all
%% Constants
m_M = 7.34767309e+22;   % Mass of the Moon in kg
m_E = 5.97219e+24;      % Mass of the Earth in kg
m_S = 28.833;           % Mass of the Spacecraft in kg
r_M = 1737100;          % Radius of the Moon in m
r_E = 6371000;          % Radius of the Earth in m
G = 6.674e-11;          % Gravitational Consant in N(m/kg)²


%% Grid Search
stepsize = 20;                   % Step Size of the Grid Search
delta_v_max = 100;              % Maximal Allowable Magnitude of Manneuver in m/s
delta_V_S_0 = [100,100];        % Initial Assumption of delta V in m/s

% Grid Search for upper two Quadrants
for delta_v_x=-100:stepsize:100
    for delta_v_y=0:stepsize:100
        if sqrt(delta_v_x^2 + delta_v_y^2)<delta_v_max
            v = OptFunction([delta_v_x, delta_v_y], m_S);
            if v < 100
                delta_v_max = v;
            end
            if v<norm(delta_V_S_0)
                delta_V_S_0=[delta_v_x, delta_v_y];
            end
        end
    end
end
% Grid Search for lower two Quadrants
for delta_v_x=-100:stepsize:100
    for delta_v_y= 0:-1*stepsize:-100
        if sqrt(delta_v_x^2 + delta_v_y^2)<delta_v_max
            v = OptFunction([delta_v_x, delta_v_y], m_S);
            if v < 100
                delta_v_max = v;
            end
            if v<norm(delta_V_S_0)
                delta_V_S_0=[delta_v_x, delta_v_y];
            end
        end
    end
end

%% Optimization
options = optimset('TolFun', 1e-4, 'TolX', 1e-4, 'Display','iter','MaxFunEvals',1e5);

delta_V_S = fminsearch(@(delta_V_S)OptFunction(delta_V_S, m_S),delta_V_S_0, options);

% Calculate Errors in Percent
error_x =(delta_V_S(1)-0.3717)/0.3717*100;
error_y =(delta_V_S(2)-49.1063)/49.1063*100;
error = (norm(delta_V_S) - 49.1077) / 49.1077*100;

% Display Errors
display(error_x)
display(error_y)
display(error)

%% Initial Conditions for Final Solution
d_ES = 340000000;                       % Initial Distance Between Earth and Spacecraft in m
theta_S = 50 * (pi/180);                % Inital Positionangle of the Spacecrat in rad
v_S = 1000;                             % Inital Velocity of the Spacecraft in m/s
d_EM = 384403000;                       % Initial Distance Between Earth and Moon in m
theta_M = 42.5 * (pi/180);              % Inital Positionangle of the Moon in rad
v_M = sqrt((G*m_E^2)/((m_E+m_M)*d_EM)); % Initial Velocity of the Moon in m/s

% y_0: (v_S_x, v_S_y, v_M_x, v_M_y, v_E_x, v_E_Y, x_S, y_S, x_M, y_M, x_E, y_E)

y_0(1) = v_S * cos(theta_S) + delta_V_S(1); % v_S_x: Initial Velocity of the Spacecraft in x-Direction in m/s
y_0(2) = v_S * sin(theta_S) + delta_V_S(2); % v_S_y: Initial Velocity of the Spacecraft in y-Direction in m/s
y_0(3) = -v_M * sin(theta_M);               % v_M_x: Initial Velocity of the Moon in x-Direction in m/s
y_0(4) = v_M * cos(theta_M);                % v_M_y: Initial Velocity of the Moon in y-Direction in m/s
y_0(5) = 0;                                 % v_E_x: Initial Velocity of the Earth in x-Direction in m/s
y_0(6) = 0;                                 % v_M_y: Initial Velocity of the Earth in y-Direction in m/s
y_0(7) = d_ES * cos(theta_S);   % x_S: Initial X-Position of the Spacecraft in m
y_0(8) = d_ES * sin(theta_S);   % y_S: Initial Y-Position of the Spacecraft in m
y_0(9) = d_EM * cos(theta_M);   % x_M: Initial X-Position of the Moon in m
y_0(10) = d_EM * sin(theta_M);  % y_M: Initial Y-Position of the Moon in m
y_0(11) = 0;                    % x_E: Initial X-Position of the Earth in m
y_0(12) = 0;                    % y_E: Initial Y-Position of the Earth in m

%% ODE45
options = odeset('Events', @myevents, 'RelTol', 1e-8, 'MaxStep', 1e5);  % Option Set for ODE45
tspan = [0, 1e10];                      % Timespan for Integration in s
[t, y, te, ye, ie] = ode45(@(t,y)RHS(t, y, m_S),tspan, y_0, options);   % Numerical Integration with ODE45
%% Plotting
figure(1)
hold on
grid on
axis equal

% Plot Earth
ang = 0:0.01:2*pi; 
x_E_p = r_E*cos(ang);
y_E_p = r_E*sin(ang);
plot(y_0(11) + x_E_p, y_0(12) + y_E_p);

%set size for moon
x_M_p = r_M*cos(ang);
y_M_p = r_M*sin(ang);

%set size for spacecraft using capsule diameter
r_S = 3.9; %m
x_S_p = r_S*cos(ang);
y_S_p = r_S*sin(ang);

title('Apollo Trajectory (1e-20 s)')
xlabel('x (meters)')
ylabel('y (meters)')

for i = 1:length(y(:,8))
    axis([-0.5*10^8 3*10^8 -0.1*10^8 4*10^8]) 
    %plot path of spacecraft
    p_s = plot(y(1:i,7),y(1:i,8),'m');
    %plot path of moon
    p_m = plot(y(1:i,9),y(1:i,10),'k');
    % Plot Trajectory of Spacecraft
    s_p = plot(y(i,7) + x_S_p, y(i,8) + y_S_p,'b');
    %Plot Trajectory of the Moon
    m_p = plot(y(i,9) + x_M_p ,y(i,10) + y_M_p,'k');
    pause(0.00000000000000000001)
    if i < length(y(:,8))
        delete(s_p)
        delete(m_p)
        delete(p_s)
        delete(p_m)
    end
end
legend([p_s p_m],{'trajectory of spacecraft','moon''s orbit'},'Location','southeast')
if(ie == 1)
    fprintf('Spacecraft impacted into the Moon.')
elseif(ie == 2)
     fprintf('Spacecraft returned to the Earth.')
elseif(ie == 3)
    fprintf('Spacecraft lost to Outer Space.')
end