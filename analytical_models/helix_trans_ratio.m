function dL_dtheta = helix_trans_ratio(theta, r, L0)
%helix_trans_ratio Transmission ratio for the helical-rails actuator
%model
%
%   Copyright Andrew P. Sabelhaus 2019
%   
%   Calculate the transmission ratio (dL/dtheta) for the double helix
%   actuator model with curved rails, obeying the equations of a helix.
%
%   Inputs:
%
%       theta, rad: total angle input at the fixed end.
%
%       r, length units: radius of the helix (half the rung width.)
%
%       L0, length units: length of the actuator in its reference 
%           configuration, i.e., at theta = 0.
%
%   Outputs:
%
%       dL_dtheta: transmission ratio. Units of (length/rad.)
%

% This is just the derivative of 
% L = sqrt(L0^2 - r^2 * theta^2), which is

dL_dtheta = (-r^2 * theta)/sqrt(L0^2 - r^2 * theta^2);

% To-do: error checking, or NaN?

end







