function [a] = acceleration(F_1, F_2, m)
%Author:    Lukas Rohrmueller
%Date:      January 22nd, 2020
%About:     Calculation of the acceleration on a Body caused by two Forces

%Inputs:    F_1:    First Force Acting on Body in N
%           F_2:    SEcond Force Acting on Body in N
%           m:      Mass of the Body in kg

%Outputs:   a:      Acceleration Acting on the Body in m/s²

%% Calculation
a = (F_1+F_2)/m;  % Acceleration Acting on the Body in m/s²
end

