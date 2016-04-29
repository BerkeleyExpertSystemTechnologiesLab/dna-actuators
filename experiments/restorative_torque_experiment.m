% restorative_torque_experiment.m
% Restorative Torque Testing Experiment
% Copyright 2015 Andrew P. Sabelhaus, Kyle Zampaglione
% This file contains the data from the restorative torque tests,
% and plots that data.

clear all; close all; clc;

% Number of rotations for the actuator as turned by hand:
experimental_rotations = [0; 0.25; 0.5; 0.75; 1; 1.25; 1.5; 1.75; ...
                            2; 2.25; 2.5];
                        
% Pick out the number of datapoints we have, to make this script cleaner:
num_datapoints = size(experimental_rotations, 1);

% The test was performed five times.
% Here, each row is one test, and each column is angle of rotation.
experimental_torques = [
    0, 0.12, 0.43, 0.63, 0.71, 0.62, 0.47, 0.25, 0.21, 0.05, 0;
    0, 0.12, 0.37, 0.57, 0.70, 0.64, 0.49, 0.29, 0.17, 0.07, 0;
    0, 0.12, 0.37, 0.58, 0.72, 0.61, 0.50, 0.26, 0.18, 0.04, 0;
    0, 0.06, 0.37, 0.60, 0.70, 0.67, 0.48, 0.30, 0.17, 0.08, 0;
    0, 0.07, 0.38, 0.66, 0.73, 0.66, 0.51, 0.32, 0.20, 0.08, 0];

% Convert all these torques from inch-pounds to newton-centimeters:
lb_to_N = 4.44822;
lbf_in_to_N_cm = lb_to_N * 2.54;
experimental_torques_si = experimental_torques .* lbf_in_to_N_cm;

% Pick out the number of tests we did for ease later:
num_tests = size(experimental_torques_si, 1);

% Calculate the averages for each angle of rotation:
avg_torques = sum(experimental_torques_si) ./ num_tests;

% Length data were re-used from the displacement experiment:
experimental_lengths = [40.5; 40.3; 39.8; 38.5; 37.2; 35.2; 32.7; ...
                        29.4; 25.7; 18.5; 10];
                    
%% Create two plots: torque vs. rotations, torque vs. lengths.

% First, rotations.
RotationsFigureHandle = figure;
hold on
%set(gca,'FontSize',11);
set(RotationsFigureHandle,'Position',[100,100,450,300]);
set(RotationsFigureHandle,'PaperPosition',[1,1,4.5,3]);

% 2016-04-29: changed x-axis units from rotations to radians (pi rad.)
% x-axis is now "pi rad." For example, "2" is "2pi"
experimental_rotations = experimental_rotations .* 2;

title('Restorative Torque vs. Actuator Rotation')
xlabel('Rotation (units of\pi radians)')
ylabel('Restorative Torque (N-cm)')
plot(experimental_rotations,avg_torques,'o-','LineWidth',2);
grid on;
grid minor;

% Save images
% Create the filenames for both images
save_path_base = '../img/restorative_torque_experiment_rotations';
save_fullpath_fig = strcat(save_path_base, '.fig');
save_fullpath_eps = strcat(save_path_base, '.eps');

% Uncomment the lines below to save.
savefig(save_fullpath_fig);
print(save_fullpath_eps,'-depsc')

hold off;

% Then, plot torque vs. lengths.
LengthsFigureHandle = figure;
hold on
%set(gca,'FontSize',11);
set(LengthsFigureHandle,'Position',[100,100,450,300]);
set(LengthsFigureHandle,'PaperPosition',[1,1,4.5,3]);

title('Restorative Torque vs. Actuator Length')
xlabel('Actuator Length (cm)')
ylabel('Restorative Torque (N-cm)')
plot(experimental_lengths,avg_torques,'o-','LineWidth',2);
grid on;
grid minor;
xlim([10,41]);

% Save images
% Create the filenames for both images
save_path_base = '../img/restorative_torque_experiment_lengths';
save_fullpath_fig = strcat(save_path_base, '.fig');
save_fullpath_eps = strcat(save_path_base, '.eps');

% Uncomment the lines below to save.
savefig(save_fullpath_fig);
print(save_fullpath_eps,'-depsc')
