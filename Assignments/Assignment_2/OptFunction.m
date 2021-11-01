function f = OptFunction(delta_V_S, m_S)
%Author:    Connor O'reilly and Lukas Rohrmueller
%Date:      January 22nd, 2020
%About:     

%Input      delta_V_S:  Change in Inital Velocity in x and y-Direction in m/s
%           m_S:        Mass of the Spacecraft in kg

%Output     f:          Magnitude of Initial Velocity in m/s (if S/C returns to Earth)

%% Constants
m_M = 7.34767309e+22;   % Mass of the Moon in kg
m_E = 5.97219e+24;      % Mass of the Earth in kg
G = 6.674e-11;          % Gravitational Consant in N(m/kg)²

%% Initial Conditions
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

if ie==2
    f = sqrt(delta_V_S(1)^2 + delta_V_S(2)^2);  % Magnitude of the Initial Velocity Change in m/s
else
    f=100000000;
end
end

