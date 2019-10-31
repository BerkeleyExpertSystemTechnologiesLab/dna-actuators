% helix_length.m
% Copyright 2015-2019 Andrew P. Sabelhaus, Kyle Zampaglione
% This function calculates the length of a helix, as per the equations
% in the various paper submissions
% Inputs:
% rail_length: the length of the rail of the helix (aka, arc length in 3D).
%   This value also corresponds to the rest length of the actuator.
% radius: the radius of the helix
% rotation: the angle which the helix has been twisted. 
%   **UNITS ARE revolutions. 
%   previously, was "one rotation as 180 degrees."
% Output: length, the final length (aka, height) of the helix.

function length = helix_length(rail_length, radius, rotation)

% Convert to radians. 2*pi rad / 1 rev.
theta = rotation * 2 * pi;
length = theta * sqrt((rail_length/theta)^2 - radius^2);

% A correction for the case where there is no rotation:
if rotation == 0
    length = rail_length;
end

end