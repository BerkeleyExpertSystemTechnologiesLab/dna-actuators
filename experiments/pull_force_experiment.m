% pull_force_experiment.m
% Pull Force Testing Experiment
% Copyright 2015 Andrew P. Sabelhaus, Kyle Zampaglione
% This file contains the data from the pull force tests,
% and plots that data.

clear all; close all; clc;

% In angles, these rotations were: [450; 540; 630; 720];
experimental_rotations = [1.25; 1.5; 1.75; 2];

% These are in N
experimental_forces = [35; 19; 8; 1];

% These are in cm
experimental_lengths = [35.2; 32.7; 29.4; 25.7];

%% Create plots
% First, rotations.
RotationsFigureHandle = figure;
hold on
%set(gca,'FontSize',11);
set(RotationsFigureHandle,'Position',[100,100,450,300]);
set(RotationsFigureHandle,'PaperPosition',[1,1,4.5,3]);

title('Force at Deformation vs. Actuator Rotation')
xlabel('Rotation (units of\pi radians)')
ylabel('Force (N)')

% 2016-04-29 changed to radians as x-axis units
experimental_rotations = experimental_rotations .* 2;
plot(experimental_rotations,experimental_forces,'o-','LineWidth',2);
grid on;
grid minor;
%xlim([1 2.2])
xlim([2 4.4])
ylim([0 50])

% Save images
% Create the filenames for both images
save_path_base = '../img/pull_force_experiment_rotations';
save_fullpath_fig = strcat(save_path_base, '.fig');
save_fullpath_eps = strcat(save_path_base, '.eps');

% Uncomment the lines below to save.
savefig(save_fullpath_fig);
print(save_fullpath_eps,'-depsc')

hold off;

% Then, plot force vs. lengths.
%LengthsFigureHandle = figure;
%hold on
%set(gca,'FontSize',11);
%set(LengthsFigureHandle,'Position',[100,100,450,300]);
%set(LengthsFigureHandle,'PaperPosition',[1,1,4.5,3]);

%title('Force at Deformation vs. Actuator Length')
%xlabel('Actuator Length (cm)')
%ylabel('Force (N)')
%plot(experimental_lengths,experimental_forces,'o-','LineWidth',2);
%grid on;
%grid minor;
%xlim([10,41]);

% Save images
% Create the filenames for both images
%save_path_base = 'img/pull_force_experiment_lengths';
%save_fullpath_fig = strcat(save_path_base, '.fig');
%save_fullpath_eps = strcat(save_path_base, '.eps');

% Uncomment the lines below to save.
%savefig(save_fullpath_fig);
%print(save_fullpath_eps,'-depsc')
