function theta_max = helix_max_theta(r, L0)
%helix_max_theta Maximum input angle theta for the continuous (helical)
%rails actuator model
%
%   Copyright Andrew P. Sabelhaus 2020
%   
%   Calculate the maximum input angle for the double helix
%   actuator model with continuous (helical) rails.
%
%   Inputs:
%
%       r, length units: radius of the helix (half the rung width.)
%
%       L0, length units: length of the actuator in its reference 
%           configuration, i.e., at theta = 0.
%
%   Outputs:
%
%       theta_max: maximum input angle theta (radians.)
%

% Formula is L0/r
theta_max = L0/r;

% To-do: error checking, or NaN?

end







