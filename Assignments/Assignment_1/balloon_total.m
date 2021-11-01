function [w_tot] = balloon_total(r, w_pay, w_empt, MW)
%{
balloon_total will calculate the total weight of a balloon with user inputs

Inputs:
    r: radius of the balloon (m)
    w_pay: weight of the payload 
    w_empt: empty weight of the balloon
    MW: molecular weight of the gas in the balloon
Outputs:
    w_tot: total weight of the balloon

Author: Connor O'Reilly
Collabrators: none
Last Edited: 01/15/2020
%}
rho = 1.225; %kg/m^3
w_gas =  (4*pi*rho*r^3)/3  * (MW / 28.966); 
w_tot = w_pay + w_empt + w_gas;
end

