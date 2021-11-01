function f = RHS(t, y, m_S)
%Author:    Connor O'reilly and Lukas Rohrmueller
%Date:      January 22nd, 2020
%About:   

%Inputs:    t:      Time in s
%           y:      State Vector
%           m_S:    Mass of the Spacecraft in kg

%Outputs:   f:      ?

%% grab values
x_S = y(7);     % X-Position of the Spacecraft in m
y_S = y(8);     % Y-Position of the Spacecraft in m

x_M = y(9);     % X-Position of the Moon in m
y_M = y(10);    % Y-Position of the Moon in m

v_S_x = y(1);   % Velocity of the Spacecraft in x-Direction in m/s
v_S_y = y(2);   % Velocity of the Spacecraft in y-Direction in m/s

v_M_x = y(3);   % Velocity of the Moon in x-Direction in m/s
v_M_y = y(4);   % Velocity of the Moon in y-Direction in m/s

%% Calculate Accelerations
[a_S_x, a_S_y, a_M_x, a_M_y] = acceleration_SM(m_S, x_S, x_M, y_S, y_M);

%% Return Values
% f: (a_S_x, a_S_y, a_M_x, a_M_y, a_E_x, a_E_Y, v_S_x, v_S_y, v_M_x, v_M_y, v_E_x, v_E_Y)
f(1,1) = a_S_x;     % a_S_x: Acceleration of the Spacecraft in x-Direction in m²/s
f(2,1) = a_S_y;     % a_S_y: Acceleration of the Spacecraft in y-Direction in m²/s
f(3,1) = a_M_x;     % a_M_x: Acceleration of the Moon in x-Direction in m²/s
f(4,1) = a_M_y;     % a_M_y: Acceleration of the Moon in y-Direction in m²/s
f(5,1) = 0;         % a_E_x: Acceleration of the Earth in x-Direction in m²/s
f(6,1) = 0;         % a_E_y: Acceleration of the Earth in y-Direction in m²/s         
f(7,1) = v_S_x ;    % v_S_x: Velocity of the Spacecraft in x-Direction in m/s
f(8,1) = v_S_y;     % v_S_y: Velocity of the Spacecraft in y-Direction in m/s
f(9,1) = v_M_x;     % v_M_x: Velocity of the Moon in x-Direction in m/s
f(10,1) = v_M_y;    % v_M_y: Velocity of the Moon in y-Direction in m/s
f(11,1) = 0;        % v_E_x: Velocity of the Earth in x-Direction in m/s
f(12,1) = 0;        % v_M_y: Velocity of the Earth in y-Direction in m/s

end

