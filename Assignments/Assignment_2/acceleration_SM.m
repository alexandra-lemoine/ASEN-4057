function [a_S_x, a_S_y, a_M_x, a_M_y] = acceleration_SM(m_S, x_S, x_M, y_S, y_M)
%Author:    Lukas Rohrmueller
%Date:      January 22nd, 2020
%About:     Calculation of the Acceleration acting on the Spacecraft and the Moon

%Inputs:    m_S:    Mass of the Spacecraft in kg
%           x_S:    X-Position of the Spacecraft in m
%           x_M:    X-Position of the Moon in m
%           y_S:    Y-Position of the Spacecraft in m
%           y_M:    Y-Position of the Moon in m

%Outputs:   a_S_x:  Acceleration in X-Direction Acting on the Spacecraft in m/s²
%           a_S_y:  Acceleration in Y-Direction Acting on the Spacecraft in m/s²
%           a_M_x:  Acceleration in X-Direction Acting on the Moon in m/s²
%           a_M_y:  Acceleration in Y-Direction Acting on the Moon in m/s²
%% Constants
m_M = 7.34767309e22;   % Mass of the Moon in kg
m_E = 5.97219e24;      % Mass of the Earth in kg
x_E=0;                 % X-Position of the Earth in m
y_E=0;                 % Y-Position of the Earth in m

%% Calculation of the Forces
[F_MS(1),F_MS(2)] = gravity_force(m_M, m_S, x_M, x_S, y_M, y_S);    % Force Acting on the Spacecraft due to the Moon in N
[F_ES(1),F_ES(2)] = gravity_force(m_E, m_S, x_E, x_S, y_E, y_S);    % Force Acting on the Spacecraft due to the Earth in N
[F_EM(1),F_EM(2)] = gravity_force(m_E, m_M, x_E, x_M, y_E, y_M);    % Force Acting on the Moon due to the Earth in N
[F_SM(1),F_SM(2)] = gravity_force(m_S, m_M, x_S, x_M, y_S, y_M);    % Force Acting on the Moon due to the Spacecraft in N

%% Calculation of the Accelerations
a_S_x = acceleration(F_MS(1), F_ES(1), m_S);    % Acceleration in X-Direction Acting on the Spacecraft in m/s²
a_S_y = acceleration(F_MS(2), F_ES(2), m_S);    % Acceleration in Y-Direction Acting on the Spacecraft in m/s²
a_M_x = acceleration(F_EM(1), F_SM(1), m_M);    % Acceleration in X-Direction Acting on the Moon in m/s²
a_M_y = acceleration(F_EM(2), F_SM(2), m_M);    % Acceleration in Y-Direction Acting on the Moon in m/s²
end

