% length_simulation_straightline_directcalc
% Straight-line double helix length simulation. This version uses
% the updated equations for chord length.
% Copyright 2015 Andrew P. Sabelhaus, Kyle Zampaglione
% v2.12.15
% Calculates change in z height for twisting of a helix connected with rigid
% straight members
% NOTE: Calculations break down as period of rotation repeats with low
% number of rungs

function [heights, rotations] = length_simulation_straightline_directcalc(rungwidth,...
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
    
    % Calculate the chord length between the x,y positions between two successive rungs
    % equation for chord length: c = 2r sin(theta/2)
    c = 2 * (rungwidth/2) * sind(indivtwist/2);
    
    % Calculate the z-height change for each rung, given this chord length
    z_i = sqrt( rungspacing^2 - c^2);
    
    % Calculate the total z-height of the actuator.
    % There are N-1 spaces between rungs.
    z = z_i * (number_rungs - 1);
    
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




