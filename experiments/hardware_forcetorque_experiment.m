% hardware_forcetorque_experiment.m
% Copyright 20150-2020 Andrew P. Sabelhaus, Kyle Zampaglione, Ellande Tang

% Plots the data from imported_test_data_setup2, comparing
% force/torque/input angle for the actuator prototypes.

%% (1) Prep the workspace and load in the data

clear all; close all; clc;

% Plotting parameters.
fontsize = 14;
fig_pos = [100,100,500,350];
fig_paperpos = [1,1,5.8,3.5];
% line and marker size
lineWidth = 1.5;
markerSize = 12;

% We'll cycle through colors for plotting. Let MATLAB decide those...


% Load in the data.
run '../data/imported_test_data_setup2.m'

% Hard-coded so we can loop: names of the structs and their fields.
designs = {'i_slide', 'i_bearing', 'ii', 'iii'};
% All have a field called theta. There are different fields for each
% applied tip load, though: 1 through 4...
loads{1} = {'g0'};
loads{2} = {'g0', 'g100', 'g200', 'g300', 'g400'};
loads{3} = loads{2};
loads{4} = {'g0', 'g100', 'g500', 'g1000'};

%% (2) Calculate statistics

% We will want, for each rotation and tip load, a mean and stddev of
% torques (across the 5 tests).
% Since naming is weird here, fall back to a cell array for each.
means = {};
stddevs = {};
% pick out the angles by index also.
thetas = {};

% For all the designs...
for j=1:size(designs, 2)
    % Pull out the data for this design
    hardware_data_j = eval(designs{j});
    % Save the angles for later
    thetas{j} = getfield(hardware_data_j, 'theta');
    % For each applied load...
    for k=1:size(loads{j}, 2)
        % First, pull out this particular test. Matrix should be (num_theta
        % x num_tests)
        forcetorque_jk = getfield(hardware_data_j, loads{j}{k});
        % We'll store the means and averages for each test.
        % One test is a row (a specific rotation).
        for h=1:size(forcetorque_jk,1)
            % 2D cell array w/ vector:
            % {design#}{appliedload}(rotation)
            % which corresponds to j,k,h.
            means{j}{k}(h) = mean(forcetorque_jk(h,:));
            stddevs{j}{k}(h) = std(forcetorque_jk(h,:));
        end
    end
end

%% (3) Plot.

% Three plots here:
% Design (i), both the bearings and the slide.
% Design (ii),
% Design (iii).

% Let's start with the later two figures since they'll be easier.
% hard-coded: indices 3 and 4.

for j=3:4
    % Create the figure window and size it appropriately
    FigureHandle = figure;
    hold on
    
    % Set up the window
    set(gca, 'FontSize', fontsize);
    set(FigureHandle, 'Position', fig_pos);
    set(FigureHandle, 'PaperPosition', fig_paperpos);
    
    % Plot one curve per load. Number of means is an easy to use reference
    for k=1:size(means{j}, 2)
        % the mean curve
        plot(thetas{j}, means{j}{k}, 'LineWidth', lineWidth, 'MarkerSize', markerSize);
    end

    % Add the legend, labels, and adjust the axes
    title('Hardware')
    %xlabel('Number of Rotations (1 rotation = 360 degrees)')
    xlabel('Theta (rad)')
    ylabel('Input Torque (N-cm)')
%     legend('Analytical Model','Hardware Experiment','Location', 'SW')
end




