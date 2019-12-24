function dL_dtheta = sr_trans_ratio(theta, r, N, L0)
%sr_trans_ratio Transmission ratio for the straightline-rails actuator
%model
%
%   Copyright Andrew P. Sabelhaus 2019
%   
%   Calculate the transmission ratio (dL/dtheta) for the double helix
%   actuator model with straight-line rails.
%
%   Inputs:
%
%       theta, rad: total angle input at the fixed end.
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
%       dL_dtheta: transmission ratio. Units of (length/rad.)
%

% Drew calculated this derivative in terms of ell_i, the segment length
% when unactuated, so define
ell_i = L0/(N-1);

% calculate a numerator and denominator for clarity.
top = -r^2 * sin(theta/(N-1));
bottom = sqrt(ell_i^2 - 4 * r^2 * (sin(theta/(2*(N-1))))^2);

% result.
dL_dtheta = top/bottom;

% To-do: error checking, or NaN?

end







