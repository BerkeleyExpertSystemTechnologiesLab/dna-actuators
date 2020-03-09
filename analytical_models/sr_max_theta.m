function theta_max = sr_max_theta(r, N, L0)
%sr_max_theta Maximum input angle theta for the discretized (straight-line)
%rails actuator model
%
%   Copyright Andrew P. Sabelhaus 2020
%   
%   Calculate the maximum input angle for the double helix
%   actuator model with straight-line rails.
%
%   Inputs:
%
%       r, length units: radius of the helix (half the rung width.)
%
%       N, unitless: number of rungs. (There are N-1 straightline
%           segments.)
%
%       L0, length units: length of the actuator in its reference 
%           configuration, i.e., at theta = 0.
%
%   Outputs:
%
%       theta_max: maximum input angle theta (radians.)
%

% Formula is 2(N-1) arcsin(beta), where beta is cell aspect ratio
theta_max = 2 * (N-1) * asin(L0/(2*r*(N-1)));

% To-do: error checking, or NaN?

end







