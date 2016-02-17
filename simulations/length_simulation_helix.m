% length_simulation_helix.m
% Copyright 2015 Andrew P. Sabelhaus, Kyle Zampaglione
% This function calculates the length of a helix, as per the equations
% in the ASME IDETC 2016 paper submission
% Inputs:
% rail_length: the length of the rail of the helix (aka, arc length in 3D).
%   This value also corresponds to the rest length of the actuator.
% radius: the radius of the helix
% rotation: the angle which the helix has been twisted. In this work, we
%   refer to one rotation as 180 degrees. Also, this must be a scalar.
% Output: length, the final length (aka, height) of the helix.

function length = length_simulation_helix(rail_length, radius, num_rotations)

% Convert to radians
theta = num_rotations * pi;
length = theta * sqrt((rail_length/theta)^2 - radius^2);

% A correction for the case where there is no rotation:
if num_rotations == 0
    length = rail_length;
end

end