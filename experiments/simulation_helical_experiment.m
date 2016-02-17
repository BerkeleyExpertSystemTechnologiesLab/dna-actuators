% simulation_helical_experiment.m
% Copyright 2015 Kyle Zampaglione, Andrew P. Sabelhaus
% This file plots data from the helical actuator tests.
% It is technically not an experiment, but uses data that was generated
% in the past.
% TO-DO: have this function generate the data as needed, like the 
% straight-line-edge version.

clc; clear all; close all;

% Load the helical actuator simulation data
load('../data/helical_simulation_data.mat');

%% Create the first figure window, for the displacement graph,
% and size it appropriately
PositionFigureHandle = figure;
hold on
%set(gca,'FontSize',11);
set(PositionFigureHandle,'Position',[100,100,500,300]);

plot(num_turns1, total_height_array1)
plot(num_turns15, total_height_array15, 'm')
plot(num_turns2, total_height_array2, 'r')
plot(num_turns2(1:length(total_height_array3)), total_height_array3, 'g')

legend('Rung Width = 1','Rung Width = 1.5', ...
    'Rung Width = 2', 'Rung Width = 3')

% Label and title the first figure:
title('Helical Actuator Displacement')
xlabel('Number of Rotations')
ylabel('Total Height')

hold off

%% Create the second figure window, for the rate of change graph,
% and size it appropriately
RateFigureHandle = figure;
hold on
%set(gca,'FontSize',11);
set(RateFigureHandle,'Position',[100,100,500,300]);

tot_height_deriv1 = diff(total_height_array1);
num_turns_deriv1 = linspace(num_turns1(1), num_turns1(end), length(tot_height_deriv1));
plot(num_turns_deriv1, tot_height_deriv1)

tot_height_deriv15= diff(total_height_array15);
num_turns_deriv15 = linspace(num_turns15(1), num_turns15(end), length(tot_height_deriv15));
plot(num_turns_deriv15, tot_height_deriv15, 'm')

tot_height_deriv2= diff(total_height_array2);
num_turns_deriv2 = linspace(num_turns2(1), num_turns2(end), length(tot_height_deriv2));
plot(num_turns_deriv2, tot_height_deriv2, 'r')

tot_height_deriv3= diff(total_height_array3);
num_turns_deriv3 = linspace(num_turns2(1), num_turns2(85), length(tot_height_deriv3));
plot(num_turns_deriv3, tot_height_deriv3, 'g')


legend('Rung Width = 1','Rung Width = 1.5', ...
    'Rung Width = 2', 'Rung Width = 3')
xlabel('Number of Rotations')
ylabel('Rate of Length Change')
title('Helical Actuator Rate of Length Change')

