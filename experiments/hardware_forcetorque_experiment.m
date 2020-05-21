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

% We need the helix_length function
% Add the paths to the modeling equations
addpath( '../analytical_models' );

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

% For calculating efficiencies, we need the actual applied force for each
% test. The most algorithmic way would be to map the labels to actual
% forces, similar to the color map. Using same key ordering...
loads_in_N = {0.0, 0.98, 1.96, 2.94, 3.92, 4.905, 9.81, 0.0};
load_map = containers.Map(key_set, loads_in_N);

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
% store the lengths for efficiency calculations
lengths = {};
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
            % store the length of the actuator for this test. many repeated
            % variables here but it's easier this way
            lengths{j}{k}(h) = helix_length(thetas{j}(h), r, L0);
            % 2D cell array w/ vector:
            % {design#}{appliedload}(rotation)
            % which corresponds to j,k,h.
            means{j}{k}(h) = mean(forcetorque_jk(h,:));
            stddevs{j}{k}(h) = std(forcetorque_jk(h,:));
        end
    end
end

%% Also, we need to numerically integrate to get efficiency.

% Calculate the eta for each test: generally,
% eta = work_in / work_out = (F dL) / (T d\theta)
% With a constant force,
% work_in = F(L0 - L(theta))
% but the torque and angle vary:
% work_out = \int_0^\theta torque(\phi) \phi d\phi

% Due to the nature of the test, where an applied load was hung on the free
% end and the actuator was turned from 0 to theta_ijk five times, we do
% *not* have consistency between test indices!
% For numerical integration, the correct propogation-of-errors way would be
% to probabilistically manipulate random variables...
% ...an easier way is to just use the means, which is what we'll do.

eta_means = {};
eta_stddevs = {};

% For all the designs...
for j=1:size(designs,2)
    % Pull out the data for this design
    hardware_data_j = eval(designs{j});
    % For each applied load for this design...
    for k=1:size(loads{j}, 2)
        % First, pull out this particular test. Matrix should be (num_theta
        % x num_tests)
        torque_jk = getfield(hardware_data_j, loads{j}{k});
        % Iteratively calculate a trapezoidal approx to the integration.
        % the efficiency at theta = 0 is always eta = 0, no matter the
        % input torque.
        eta_means{j}{k}(1) = 0.0;
        eta_stddevs{j}{k}(1) = 0.0;
        % For each angle > 0, for this load, for this design, ...
        for h=2:size(thetas{j},1)
            % trapezoid, which is
            % \int_i-1^theta(i) = (\theta(i) - theta(i-1)) * (tau(i) + tau(i-1))/2
            % note that torque_jk(h,:) is a vector and everything else is
            % scalar
            delta_work_in_jkh = (thetas{j}(h) - thetas{j}(h-1)) ...
                * (torque_jk(h,:) + means{j}{k}(h-1)) / 2;
            % Add to the previous mean to get the total
            work_in_jkh = eta_means{j}{k}(h-1) + delta_work_in_jkh;
            % The work out is F (L0 - L)
            work_out_jkh = load_map(loads{j}{k}) * (L0 - lengths{j}{k}(h));
            % now, a vector of efficiencies, one for each of the 5 tests at
            % this theta
            eta_jk = work_out_jkh ./ work_in_jkh;
            % Correct for division by zero: define eta(0/0) = 0.
            eta_jk( isnan(eta_jk) ) = 0.0;
            % Now, eta_jk should be 1 x 5, we can calculate statistics on
            % it also.
            eta_means{j}{k}(h) = mean(eta_jk);
            eta_stddevs{j}{k}(h) = std(eta_jk);
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
    
    % Do an efficiency plot also.
    % Create the figure window and size it appropriately
    FigureHandle = figure;
    hold on
    
    % Set up the window
    set(gca, 'FontSize', fontsize);
    set(FigureHandle, 'Position', fig_pos);
    set(FigureHandle, 'PaperPosition', fig_paperpos);
    % efficiency will change with applied load.
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



