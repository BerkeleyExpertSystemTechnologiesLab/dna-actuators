% simulation_straightline_experiment.m
% Copyright 2015 Kyle Zampaglione, Andrew P. Sabelhaus
% This file performs the simulation experiments for the straight-line 
% actuator, as recorded in the 2016 ASME IDETC paper.
% It calculates data using the simulation function,
% then plots.

clear all; close all; clc;

% Add the simulations folder to the path so that we can call the
% proper functions
addpath('../simulations/');

% To save these figures, change this path, and uncomment the lines at 
% the end of both sections of this script (displacement, rate.)
save_path_base_disp = '../img/comparison_plots_straightline_displacement';
save_path_base_rate = '../img/comparison_plots_straightline_rate';

% Some parameters.
% Number of rungs:
N = 10;

% First, generate the desired data.
% Here, we use three different widths: 1, 2, and 3 unit lengths.
% Note that we've previous shown that this design will reduce down to
% zero length after (N-1) rotations of 180 degrees.
[heights_1, rotations_1] = length_simulation_straightline(1, 1, N, ...
    180 * (N-1));
[heights_2, rotations_2] = length_simulation_straightline(2, 2, N, ...
    180 * (N-1));
[heights_3, rotations_3] = length_simulation_straightline(3, 3, N, ...
    180 * (N-1));

%% Create the first figure window, for the displacement graph.

PositionFigureHandle = figure;
hold on
% Position the figure for consistency
%set(PositionFigureHandle,'Position',[100,100,500,300]);
set(PositionFigureHandle,'Position',[100,100,300,300]);

% 2016-04-29: changed these to radians.
rotations_1 = rotations_1 .* (1/180);
rotations_2 = rotations_2 .* (1/180);
rotations_3 = rotations_3 .* (1/180);

% Plot the three curves
plot(rotations_1, heights_1,'b')
plot(rotations_2, heights_2,'r')
plot(rotations_3, heights_3,'g')

% Label and title the first figure:
%title('Straight-line Actuator Displacement')
title('Displacement')
xlabel('Rotation (units of\pi  radians)')
ylabel('Total Length (inch)')
legend('Rung Width = 1 in.', 'Rung Width = 2 in.','Rung Width = 3 in.')
%set(gca,'FontSize',12);
%xlim([0 1600])
% 2016-04-29 replaced with radians.
xlim([0 9]);
ylim([0 30])

% Save the first figure.
save_fullpath_disp_fig = strcat(save_path_base_disp, '.fig');
save_fullpath_disp_eps = strcat(save_path_base_disp, '.eps');

% Uncomment the lines below to save.
savefig(save_fullpath_disp_fig);
print(save_fullpath_disp_eps,'-depsc')

% Clear the figure and start the rate-of-change plotting
hold off

%% Create and position the window for the second figure (rate of change)
RateFigureHandle = figure;
hold on
%set(gca,'FontSize',11);
%set(RateFigureHandle,'Position',[100,100,500,300]);
set(RateFigureHandle,'Position',[100,100,300,300]);

% Calculate the derivatives of these positions
tot_height_deriv1 = diff(heights_1);
tot_height_deriv2 = diff(heights_2);
tot_height_deriv3 = diff(heights_3);

% Create appropriate x-axis points
num_turns_deriv1 = linspace(rotations_1(1), rotations_1(end), ...
    length(tot_height_deriv1));
num_turns_deriv2 = linspace(rotations_2(1), rotations_2(end), ...
    length(tot_height_deriv2));
num_turns_deriv3 = linspace(rotations_3(1), rotations_3(end), ...
    length(tot_height_deriv3));

% 2016-04-29: changed these to radians.
%num_turns_deriv1 = num_turns_deriv1 .* (1/180);
%num_turns_deriv2 = num_turns_deriv2 .* (1/180);
%num_turns_deriv3 = num_turns_deriv3 .* (1/180);

% Plot the three curves
plot(num_turns_deriv1, tot_height_deriv1,'b')
plot(num_turns_deriv2, tot_height_deriv2, 'r')
plot(num_turns_deriv3, tot_height_deriv3, 'g')

% Label and title the second figure:
legend('Rung Width = 1', 'Rung Width = 2','Rung Width = 3','location','southwest') 
%legend('Rung Width = 1 in.', 'Rung Width = 2 in.','Rung Width = 3 in.','Location','Southwest') 
%xlim([0 1600])
% 2016-04-29 replaced with radians.
xlim([0 9]);
%title('Straight-line Actuator Rate of Lenth Change')
title('Rate of Length Change')
xlabel('Rotation (units of\pi  radians)')
ylabel('Rate of Length Change (inch/rad)')

% Save the first figure.
save_fullpath_rate_fig = strcat(save_path_base_rate, '.fig');
save_fullpath_rate_eps = strcat(save_path_base_rate, '.eps');

% Uncomment the lines below to save.
savefig(save_fullpath_rate_fig);
print(save_fullpath_rate_eps,'-depsc')

