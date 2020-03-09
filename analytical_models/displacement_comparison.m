% displacement_comparison.m
% Copyright 2020 Berkeley Emergent Space Tensegrities Lab and Andrew
% Sabelhaus
%
% Plots theoretical displacements of various reference actuator designs.

clear all;
close all;
clc;

% We'll do six designs, as in our journal paper submission, one struct for
% each. First 3 are discrete rails, remaining 3 are continuous rails.
% Geometries: all in cm, rad.

% D-rails:
gd = {};
% I
gd{1}.L0 = 30.48;
gd{1}.r = 2.54;
gd{1}.N = 7;
% II
gd{2}.L0 = 22.86;
gd{2}.r = 2.54;
gd{2}.N = 7;
% III
gd{3}.L0 = 26.67;
gd{3}.r = 1.905;
gd{3}.N = 8;

% C-rails:
gc = {};
% IV
gc{1}.L0 = 30.48;
gc{1}.r = 2.54;
% V:
gc{2}.L0 = 22.86;
gc{2}.r = 2.54;
% stopped here.

% ...max theta will be calculated automaticlly.

% Other constants: number of points, etc.
% num_pts = 100;
num_pts = 20;
% colors for plots?
c_color = 'b';
d_color = 'r';
% Cycle through some markers for the different designs within the C or D.
markers = {'+','o','.','x','v','d','^','s','>','<'};
% or maybe different styles of dashes.
styles = {'-', '--', ':'};
% line and marker size
lineWidth = 1.5;
markerSize = 6;

% Iterate and collect data for each design.
for i=1:size(gd,2)
    % We'll need different x-axes as well as y-axes for designs, since max
    % theta is different.
    gd{i}.theta_max = sr_max_theta(gd{i}.r, gd{i}.N, gd{i}.L0);
    gd{i}.theta = linspace(0, gd{i}.theta_max, num_pts);
    % Length of the actuator:
    % the length function is currently not polymorphic to arrays/vectors,
    % so loop (ugh).
    % preallocate:
    gd{i}.L = zeros(size(gd{i}.theta));
    for j=1:num_pts
        gd{i}.L(j) = sr_length(gd{i}.theta(j), gd{i}.r, gd{i}.N, gd{i}.L0);
    end
    % Let's also calculate normalized displacement as a percent of initial
    % length. That's 1 - L/L0, with 0 percent displacement vs. 100 percent
    % displacement
    gd{i}.d = 1 - (gd{i}.L ./ gd{i}.L0);
end

% Plot all the displacements on one graph:
figure;
hold on;
% hack: first 3 are D rails
for i=1:3
%     plot(g{i}.theta, g{i}.L, 'Color', d_color, 'Marker', markers{i}, ...
%          'MarkerSize', markerSize, 'LineWidth', lineWidth, 'LineStyle', '-');
    plot(gd{i}.theta, gd{i}.L, 'Color', d_color, 'LineWidth', lineWidth, 'LineStyle', styles{i});
end
title('Actuator Length, D-rails');
xlabel('Theta (rad)');
ylabel('Length (cm)');
legend('I', 'II', 'III');
hold off;

% And another plot for normalized displacement, seeing if this gives any
% more insight:
figure;
hold on;
% hack: first 3 are D rails
for i=1:3
    plot(gd{i}.theta, gd{i}.d, 'Color', d_color, 'LineWidth', lineWidth, 'LineStyle', styles{i});
end
title('Actuator Displacement, D-rails');
xlabel('Theta (rad)');
ylabel('Displacement (%)');
legend('I', 'II', 'III');
hold off;









