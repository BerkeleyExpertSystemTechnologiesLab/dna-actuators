% hardware_forcetorque_experiment.m
% Copyright 2015-2020 Andrew P. Sabelhaus, Kyle Zampaglione, Ellande Tang

% Plots the data from imported_test_data_setup2, comparing
% force/torque/input angle for the actuator prototypes.

%% (1) Prep the workspace and load in the data

clear all; close all; clc;

% Plotting parameters.
fontsize = 14;
leg_fontsize = 10;
fig_pos = [100,100,500,350];
fig_paperpos = [1,1,5.8,3.5];
% line and marker size
lineWidth = 0.5;
markerSize = 18;

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

% We'll cycle through colors for plotting. We'll want to keep colors
% consistent between applied forces.
c_order = get(gca, 'colororder');
% comes out a bit weird for test 3, try permuting the order
c_order = circshift(c_order, 3, 1);
% close the window we just made
close all;
% Map the colors to a specific load.
key_set = {'g0', 'g100', 'g200', 'g300', 'g400', 'g500', 'g1000', 'g0slide'};
% we need an eigth color for the unloaded slide. Try...
color_p1 = [0 0 0];
% concatenate
c_order_more = [c_order; color_p1];
% reorganize according to row.
c_order_more_cell = num2cell(c_order_more, 2);
% and now create the map.
load_color_map = containers.Map(key_set, c_order_more_cell);

% For plotting, write out the titles and legends here too (nice for
% iterating)
% We'll only have 3 plots.
titles = {'Force/Torque Test: Prototype (i)', ...
    'Force/Torque Test: Prototype (ii)', ...
    'Force/Torque Test: Prototype (iii)'};

% A quick conversion: we'll label applied force in N.
% 0 g = 0 N
% 100 g = 0.98 N
% 200 g = 1.96 N
% 300 g = 2.94 N
% 400 g = 3.92 N
% 500 g = 4.905 N
% 1.0 kg = 9.81 N

% same, write out legends
legends = {};
legends{1} = {'0 N (slide)', '0 N (bearing)', '0.98 N', ...
    '1.96 N', '2.94 N', '3.92 N'};
legends{2} = {'0 N', '0.98 N', '1.96 N', '2.94 N', '3.92 N'};
legends{3} = {'0 N', '0.98 N', '4.91 N', '9.81 N'};

% and the axis limits for each, adjusting for legend placement
y_lim{1} = [-2 33];
y_lim{2} = [-1 25];
y_lim{3} = [-5 100];

%% (2) Calculate statistics

% We will want, for each rotation and tip load, a mean and stddev of
% torques (across the 5 tests).
% Since naming is weird here, fall back to a cell array for each.
means = {};
stddevs = {};
% pick out the angles by index also.
thetas = {};
% and corresponding colors.
load_colors = {};

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
        % the color for this test
        load_colors{j}{k} = load_color_map(loads{j}{k});
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
        % plot(thetas{j}, means{j}{k}, 'LineWidth', lineWidth, 'MarkerSize', markerSize, 'Marker', '.', 'LineStyle', '-');
        % with error bars
        errorbar(thetas{j}, means{j}{k}, stddevs{j}{k}, 'LineWidth', lineWidth, 'MarkerSize', markerSize, 'Marker', '.', 'LineStyle', '-', 'Color', load_colors{j}{k});
    end

    % Add the legend, labels, and adjust the axes
    % title('Hardware')
    title(titles{j-1});
    xlabel('Theta (rad)')
    ylabel('Input Torque (N-cm)')
    ylim(y_lim{j-1});
    legend(legends{j-1}, 'Location', 'NW', 'FontSize', leg_fontsize);
end

% Manually specify the plot for design (i), with both the slide and
% bearing.
% Create the figure window and size it appropriately
FigureHandle = figure;
hold on

% Set up the window
set(gca, 'FontSize', fontsize);
set(FigureHandle, 'Position', fig_pos);
set(FigureHandle, 'PaperPosition', fig_paperpos);

% Plot one curve per load. 
% For the test with the slide, use a different line style and color
errorbar(thetas{1}, means{1}{1}, stddevs{1}{1}, 'LineWidth', lineWidth, 'MarkerSize', markerSize, 'Marker', '.', 'LineStyle', '--', 'Color', load_color_map('g0slide'));

% Number of means is an easy to use reference
for k=1:size(means{2}, 2)
    % with error bars
    errorbar(thetas{2}, means{2}{k}, stddevs{2}{k}, 'LineWidth', lineWidth, 'MarkerSize', markerSize, 'Marker', '.', 'LineStyle', '-', 'Color', load_colors{2}{k});
end

% Add the legend, labels, and adjust the axes
% title('Hardware')
title(titles{1});
xlabel('Theta (rad)');
ylabel('Input Torque (N-cm)');
ylim(y_lim{1});
legend(legends{1}, 'Location', 'NW', 'FontSize', leg_fontsize);



