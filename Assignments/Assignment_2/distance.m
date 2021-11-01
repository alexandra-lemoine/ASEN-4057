function [d_AB] = distance(x_A, x_B, y_A, y_B)
%Author:    Lukas Rohrmueller
%Date:      January 22nd, 2020
%About:     Calculation of the Distance Between Two Points in m

%Inputs:    x_A:    X-Position of Point A in m
%           x_B:    X-Position of Point B in m
%           y_A:    Y-Position of Point A in m
%           y_B:    Y-Position of Point B in m

%Outputs:   d_AB:   Distance Between Point A and B in m

%% Calculation
d_AB = sqrt((x_A-x_B)^2+(y_A-y_B)^2);   % Distance Between Point A and B in m
end

