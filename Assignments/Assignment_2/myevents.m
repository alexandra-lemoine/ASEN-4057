function [value, isterminal, direction] = myevents(t,y)
%Author:    Connor O'reilly and Lukas Rohrmueller
%Date:      January 22nd, 2020
%About:    

%% Constants
r_M = 1737100;  % Radius of the Moon in m
r_E = 6371000;  % Radius of the Earth in m

%% Event Determination
% Detect Impact into the Moon
d_SM = distance(y(7), y(9), y(8), y(10));   % Distance Between Spacecraft and Moon in m
if d_SM <= r_M
    value(1) = 0;
else
    value(1) = 1;
end
isterminal(1)=1;    % Stop Integration when Event occurs
direction(1) = 0;   % Indifferent of direction

% Detect arrival at Earth
d_SM = distance(y(7), y(11), y(8), y(12));   % Distance Between Spacecraft and Earth in m
if d_SM <= r_E
    value(2) = 0;
else
    value(2) = 1;
end
isterminal(2)=1;    % Stop Integration when Event occurs
direction(2) = 0;   % Indifferent of direction

% Detect lost into outer Space
d_EM = distance(y(9), y(11), y(10), y(12));   % Distance Between Moon and Earth in m
if d_SM >= 2*d_EM
    value(3) = 0;
else
    value(3) = 1;
end
isterminal(3)=1;    % Stop Integration when Event occurs
direction(3) = 0;   % Indifferent of direction
end

