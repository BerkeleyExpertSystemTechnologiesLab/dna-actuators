function theta_max = sr_max_theta_b(beta, N)
%sr_max_theta Maximum input angle theta for the discretized (straight-line)
%rails actuator model, in terms of aspect ratio beta.
%
%   Copyright Andrew P. Sabelhaus 2020
%   
%   Calculate the maximum input angle for the double helix
%   actuator model with straight-line rails.
%
%   Inputs:
%
%       beta, unitless: cell aspect ratio.
%
%       N, unitless: number of rungs. (There are N-1 straightline
%           segments.)
%
%   Outputs:
%
%       theta_max: maximum input angle theta (radians.)
%

% Formula is 2(N-1) arcsin(beta), where beta is cell aspect ratio
theta_max = 2 * (N-1) * asin(beta);

% To-do: error checking, or NaN?

end







