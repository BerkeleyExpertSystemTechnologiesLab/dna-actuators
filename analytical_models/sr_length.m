function L = sr_length(theta, r, N, L0)
%sr_length Actuator length, straight-line rails (AKA, L0 - displacement.)
%
%   Copyright Andrew P. Sabelhaus 2019
%   
%   Calculate the length of the actuator where each segment between rungs
%   is a straight line.
%
%   **NOTE: this is the updated version from
%   length_simulation_straightline, where the length is calculated
%   analytically as opposed to iteratively between segments.
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
%       L, length units: actuator length after an input rotation.
%

% Drew calculated this in terms of ell_i, the segment length
% when unactuated, so define
ell_i = L0/(N-1);

% length of one segment, assuming the input rotation is distributed evenly
% between segments:
Li = sqrt(ell_i^2 - 4*r^2*(sin(theta/(2*(N-1))))^2);

% with N-1 segments:
L = (N-1) * Li;

%...consistent with, among other things, Mennitto'97.

% To-do: error checking, or NaN?

end







