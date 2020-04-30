% displacement_experiment.m
% Copyright 2015 Andrew P. Sabelhaus, Kyle Zampaglione
% This file contains the observed data from the displacement
% experiment with the third prototype (spring steel rails).
% It plots that data against another set from simulation.

clear all; close all; clc;

% for using the helix_length function
addpath(genpath('../analytical_models'));

% Plotting parameters.
fontsize = 14;
fig_pos = [100,100,500,350];
fig_paperpos = [1,1,5.8,3.5];
% line and marker size
lineWidth = 1.5;
markerSize = 12;

% Used later, here are the constants for the actuator studied in this test:
% in inches:
L = 16;
r = 1;
% in cm:
L_cm = L * 2.54;
r_cm = r * 2.54;

% This is the data recorded by hand:
% Actuator lengths, in cm:
experimental_lengths = [40.5; 40.3; 39.8; 38.5; 37.2; 35.2; 32.7; ...
                        29.4; 25.7; 18.5; 10];

% Number of rotations for the actuator as turned by hand:
experimental_rotations = [0; 0.25; 0.5; 0.75; 1; 1.25; 1.5; 1.75; ...
                            2; 2.25; 2.5];

% 2016-04-29, 2020-4-30: Changed x-axis units from rotations to radians.
% One "rotation" is 360 degrees, i.e., 2*pi radians.
% experimental_rotations = experimental_rotations .* 2;
experimental_rotations = experimental_rotations .* (2*pi);

% We need two sets of data from the model:

% (1) points for direct comparison to the experiment.

% There are this many experimental datapoints:
num_datapoints = size(experimental_rotations,1);
% thus:
simulation_lengths_forerrorcalc = zeros(num_datapoints, 1);

% Loop through all the experimental rotation values and store the 
% simulated lengths at those values
for i = 1: num_datapoints
    % The length of the actuator at a certain rotation will be the
    % following. NOTE that we correct for a different in notation here.
    % The displacement experiment used 1 rotation = 360 degrees, not 180.
    % So, each 0.25 rotation is 90 degrees.
    simulation_lengths_forerrorcalc(i) = helix_length(experimental_rotations(i), r_cm, L_cm);
end

% Calculate the RMSE, in centimeters:
residuals = simulation_lengths_forerrorcalc - experimental_lengths;
sum_squared_error = sum( residuals.^2);
rmse = sqrt( sum_squared_error/num_datapoints);

% from current tests, this rmse = 0.7385, shortened to .74 by sigfigs.

% (2) a large number of points for a smooth curve.

num_pts_plot = 100;
plotting_pts = linspace(0, max(experimental_rotations), num_pts_plot);

% get a curve of the model predictions.
sim_len_plot = zeros(size(plotting_pts));
for i=1:num_pts_plot
    sim_len_plot(i) = helix_length(plotting_pts(i), r_cm, L_cm);
end

% Plot these two curves.
% Create the figure window and size it appropriately
FigureHandle = figure;
hold on
% Set up the window
set(gca, 'FontSize', fontsize);
set(FigureHandle, 'Position', fig_pos);
set(FigureHandle, 'PaperPosition', fig_paperpos);

% Create the plots themselves
plot(plotting_pts, sim_len_plot, 'r', 'LineWidth', lineWidth);
plot(experimental_rotations, experimental_lengths, 'b+', 'LineWidth', lineWidth, 'MarkerSize', markerSize);

% Add the legend, labels, and adjust the axes
title('C-Rails Displacement Experiment')
%xlabel('Number of Rotations (1 rotation = 360 degrees)')
xlabel('Theta (rad)')
ylabel('Length (cm)')
legend('Analytical Model','Hardware Experiment','Location', 'SW')

% determined by hand
ylim([5, 45]);
xlim([-0.1, 16]);

% Save images
% Create the filenames for both images
save_path_base = '../img/displacement_experiment';
save_fullpath_fig = strcat(save_path_base, '.fig');
save_fullpath_eps = strcat(save_path_base, '.eps');

% Uncomment the lines below to save.
% savefig(save_fullpath_fig);
% print(save_fullpath_eps,'-depsc')


%% The following section was an investigation into the nature of the curves that were observed. It was not reported, since it is still preliminary work.
% Fit these curves to a power law, which was chosen by inspection:
% Power law is of the form: f(x) = a*x^b + c, and is performed
% using the matlab 'fit' function with 'power2' fitttype.

% First, we need to condition the experimental data ever so slightly:
% the fit funciton chokes on the initial point of 0 rotations. All values 
% must be positive.
%experimental_rotations(1) = 1e-4;

% Fit both curves:
%fit_simulation = fit(simulaton_rotations, simulation_lengths_cm,'power2');
%fit_experimental = fit(experimental_rotations, experimtnal_lengths,'power2');

%% Old hard-coded data?



% % This is the data from the simulation with 17 rungs,
% % a width of 2, and 5*pi rotations.
% % Units are inches here.
% simulation_lengths = [
%    16.0000
%    15.9995
%    15.9983
%    15.9966
%    15.9942
%    15.9912
%    15.9875
%    15.9833
%    15.9784
%    15.9729
%    15.9667
%    15.9599
%    15.9525
%    15.9445
%    15.9358
%    15.9265
%    15.9166
%    15.9060
%    15.8948
%    15.8830
%    15.8705
%    15.8574
%    15.8436
%    15.8292
%    15.8142
%    15.7985
%    15.7821
%    15.7651
%    15.7475
%    15.7292
%    15.7102
%    15.6906
%    15.6703
%    15.6493
%    15.6277
%    15.6054
%    15.5825
%    15.5588
%    15.5345
%    15.5095
%    15.4838
%    15.4574
%    15.4303
%    15.4026
%    15.3741
%    15.3449
%    15.3150
%    15.2844
%    15.2531
%    15.2211
%    15.1883
%    15.1548
%    15.1206
%    15.0856
%    15.0499
%    15.0134
%    14.9762
%    14.9382
%    14.8995
%    14.8600
%    14.8196
%    14.7786
%    14.7367
%    14.6940
%    14.6505
%    14.6062
%    14.5611
%    14.5151
%    14.4683
%    14.4207
%    14.3722
%    14.3228
%    14.2726
%    14.2215
%    14.1695
%    14.1166
%    14.0628
%    14.0080
%    13.9524
%    13.8958
%    13.8382
%    13.7797
%    13.7202
%    13.6597
%    13.5982
%    13.5357
%    13.4721
%    13.4075
%    13.3419
%    13.2752
%    13.2073
%    13.1384
%    13.0683
%    12.9971
%    12.9247
%    12.8512
%    12.7764
%    12.7004
%    12.6231
%    12.5446
%    12.4648
%    12.3836
%    12.3011
%    12.2173
%    12.1320
%    12.0453
%    11.9571
%    11.8675
%    11.7763
%    11.6835
%    11.5891
%    11.4931
%    11.3954
%    11.2960
%    11.1948
%    11.0917
%    10.9868
%    10.8800
%    10.7711
%    10.6603
%    10.5473
%    10.4321
%    10.3147
%    10.1949
%    10.0727
%     9.9480
%     9.8208
%     9.6908
%     9.5580
%     9.4222
%     9.2834
%     9.1414
%     8.9961
%     8.8472
%     8.6947
%     8.5382
%     8.3776
%     8.2127
%     8.0431
%     7.8686
%     7.6889
%     7.5035
%     7.3121
%     7.1141
%     6.9090
%     6.6961
%     6.4747
%     6.2438
%     6.0024
%     5.7492
%     5.4824
%     5.2000
%     4.8994
%     4.5769
%     4.2275
%     3.8438
%     3.4145];
% 
% % The recorded number of rotations from simulation:
% 
% simulation_rotations = [
%         0.1000
%     0.1154
%     0.1308
%     0.1462
%     0.1615
%     0.1769
%     0.1923
%     0.2077
%     0.2231
%     0.2385
%     0.2538
%     0.2692
%     0.2846
%     0.3000
%     0.3154
%     0.3308
%     0.3462
%     0.3615
%     0.3769
%     0.3923
%     0.4077
%     0.4231
%     0.4385
%     0.4538
%     0.4692
%     0.4846
%     0.5000
%     0.5154
%     0.5308
%     0.5462
%     0.5615
%     0.5769
%     0.5923
%     0.6077
%     0.6231
%     0.6385
%     0.6538
%     0.6692
%     0.6846
%     0.7000
%     0.7154
%     0.7308
%     0.7462
%     0.7615
%     0.7769
%     0.7923
%     0.8077
%     0.8231
%     0.8385
%     0.8538
%     0.8692
%     0.8846
%     0.9000
%     0.9154
%     0.9308
%     0.9462
%     0.9615
%     0.9769
%     0.9923
%     1.0077
%     1.0231
%     1.0385
%     1.0538
%     1.0692
%     1.0846
%     1.1000
%     1.1154
%     1.1308
%     1.1462
%     1.1615
%     1.1769
%     1.1923
%     1.2077
%     1.2231
%     1.2385
%     1.2538
%     1.2692
%     1.2846
%     1.3000
%     1.3154
%     1.3308
%     1.3462
%     1.3615
%     1.3769
%     1.3923
%     1.4077
%     1.4231
%     1.4385
%     1.4538
%     1.4692
%     1.4846
%     1.5000
%     1.5154
%     1.5308
%     1.5462
%     1.5615
%     1.5769
%     1.5923
%     1.6077
%     1.6231
%     1.6385
%     1.6538
%     1.6692
%     1.6846
%     1.7000
%     1.7154
%     1.7308
%     1.7462
%     1.7615
%     1.7769
%     1.7923
%     1.8077
%     1.8231
%     1.8385
%     1.8538
%     1.8692
%     1.8846
%     1.9000
%     1.9154
%     1.9308
%     1.9462
%     1.9615
%     1.9769
%     1.9923
%     2.0077
%     2.0231
%     2.0385
%     2.0538
%     2.0692
%     2.0846
%     2.1000
%     2.1154
%     2.1308
%     2.1462
%     2.1615
%     2.1769
%     2.1923
%     2.2077
%     2.2231
%     2.2385
%     2.2538
%     2.2692
%     2.2846
%     2.3000
%     2.3154
%     2.3308
%     2.3462
%     2.3615
%     2.3769
%     2.3923
%     2.4077
%     2.4231
%     2.4385
%     2.4538
%     2.4692
%     2.4846
%     2.5000];




