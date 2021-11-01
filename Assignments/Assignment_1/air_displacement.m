function [w_air] = air_displacement(r, h)
%{
air_displacement will calculate the weight of the air a balloon displaces

Inputs:
    r: radius of the balloon (m)
    h: altitude (m)
Outputs:
    air_dis: weight of the air the balloon displaces (kg)

Author: Connor O'Reilly
Collabrators: none
Last Edited: 01/15/2020
%}

%determine the temperature and pressure for provided altitude 
if ( h >= 0 ) && ( h <= 11000 )
    T = 15.04 - 0.00649 * h;
    P = 101.29 * ((T + 273.1)/ 288.08)^(5.256);
elseif ( h > 11000 ) && ( h <= 25000 ) 
    T = -56.46;
    P = 22.65 * exp(1.73 - 0.000157 * h);
elseif ( h > 25000)
    T = -131.21 + 0.00299 * h;
    P = 2.488 * ((T + 273.1) / 216.6) ^ -11.388;
end

rho = P / (0.2869 * (T + 273.1)); %density of air at curr alt. (kg/m^3)

w_air = (4 * pi * rho * r^3) / 3; %weight of air balloon displaces (kg) 
end

