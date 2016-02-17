% length_simulation_straightline
% Straight-line double helix length simulation
% Copyright 2015 Kyle Zampaglione, Andrew P. Sabelhaus
% v2.12.15
% Calculates change in z height for twisting of a helix connected with rigid
% straight members
% NOTE: Calculations break down as period of rotation repeats with low
% number of rungs

function [heights, rotations] = length_simulation_straightline(rungwidth,...
    rungspacing, number_rungs, max_twist, save_path)
% Inputs:
%   rungwidth: the width of one rung (the spacing between the helices)
%   runspacing: the distance between two rungs in succession
%   number_rungs: the number of rungs in the actuator. 
%       Thus, the total length of the actuator is rungspacing * number_rungs.
%   max_twist: the maximum input twist angle, in DEGREES.
%   save_path: OPTIONAL. path to the desired save location of the data.
% Outputs:
%   heights: the total height of the actuator at different rotation values
%   rotations: the angles of twist that correspond to the heights

% Track the total height of the helix for various rotations.
z_total = [];
angle = [];

% An index, to save data in multiple matrices at each iteration.
count = 1;

for a = 0:10:max_twist

    %set twist angle in degrees
    twistangle =  a;   
    
    %Calculate angle of rotation between each rung
    indivtwist = twistangle/(number_rungs-1);
    
    %First rung location
    x = 0; %initial x
    y = rungwidth/2; %initial y
    z_prev = 0; %initial z
   
    % For the remaining rungs (noting that this index indicates the
    % space between rungs, so calculations stop at N-1):
    for i = 1:(number_rungs-1)
        
        % Calculate the new in-plane location of the rung
        x_new = sind(indivtwist*i)*rungwidth/2;
        y_new = cosd(indivtwist*i)*rungwidth/2;
        
        % Calculate the height of this rung by the pythagorean theorem
        z = sqrt(rungspacing^2 - (x_new-x)^2 - (y_new-y)^2) + z_prev;
        
        % update for the next iteration
        x = x_new;
        y = y_new;
        z_prev = z;
    end
    
    % Save the result for this iteration (this angle of twist)
    angle(count) = twistangle;
    z_total(count) = z;
    count = count+1;

end

% Reassign variables for output, and plot if desired.
heights = z_total;
rotations = angle;

%plot(rotations, heights)

% Save the data, if the path was provided.
if nargin == 5
    % Save the data
    save(save_path, 'rotations', 'heights');
end

end




