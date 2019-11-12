function L = helix_length(theta, r, L0)
%helix_length Actuator length, helical rails. (AKA, L0 - displacement.)
%
%   Copyright Andrew P. Sabelhaus 2019
%   
%   Calculate the length of the actuator that obeys the geometry of a
%   helix. Real simple!
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
%       L, length units: actuator length after an input rotation.
%

L = sqrt(L0^2 - r^2 * theta^2);
%... consistent with many things, including in particular Gaponov'14.

% To-do: error checking, or NaN?

end







