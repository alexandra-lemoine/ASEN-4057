function [max_alt] = max_alt_balloon(r, w_pay, w_empt, MW)
%{
max_alt_balloon will calculate the maximum attainable altitude
of a balloon given its radius, payload weight, and empty weight 
as well as the molecular weight of the gas in the balloon.

Inputs:
    r: radius of the balloon (m)
    w_pay: weight of the payload (kg)
    w_empt: empty weight of the balloon (kg)
    MW: molecular weight of the gas in the balloon 
Outputs:
    w_tot: total weight of the balloon

Author: Connor O'Reilly
Collabrators: none
Last Edited: 01/15/2020
%}

w_tot = balloon_total(r, w_pay, w_empt, MW); %weight of the empty ballon;
alt = 0; %initialize alt to zero m
w_air = air_displacement(r, alt); %initial weight of air 
while ( w_air >= w_tot )
    alt = alt + 10;
    w_air = air_displacement(r, alt); %weight of air in balloon at curr alt
end

max_alt = alt; % return last altitude
end

