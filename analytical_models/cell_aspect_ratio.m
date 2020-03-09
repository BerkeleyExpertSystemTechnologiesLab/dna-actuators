function beta = cell_aspect_ratio(r, N, L0)
%cell_aspect_ration The aspect ration beta for one cell of the
%discrete-rails double helix actuator
%
%   Copyright Andrew P. Sabelhaus 2020
%   
%   Calculate the cell aspect ratio for the D-rails actuator.
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
%       beta: aspect ratio, defined below.
%

% Formula is \ell_i/2r, equivalently
beta = L0 / (2*r*(N-1));

% To-do: error checking, or NaN?

end







