% trans_ratio_comparison.m
% Copyright 2020 Berkeley Emergent Space Tensegrities Lab and Andrew
% Sabelhaus
%
% Plots theoretical transission ratios of various reference actuator designs.

clear all;
close all;
clc;

% Plotting parameters.
fontsize = 14;
fig_pos = [100,100,500,350];
fig_paperpos = [1,1,5.8,3.5];
% % Set up the window
% set(gca, 'FontSize', fontsize);
% set(gca, 'Position', fig_pos);
% set(gca, 'PaperPosition', fig_paperpos);

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
% VI:
gc{3}.L0 = 26.67;
gc{3}.r = 1.905;
% stopped here.

% ...max theta will be calculated automatically.

% Other constants: number of points, etc.
num_pts = 20;
% Note, we get -inf at theta max, so a bit of conditioning:
num_pts_plot = num_pts - 1;
% colors for plots?
c_color = 'b';
d_color = 'r';
% Cycle through some markers for the different designs within the C or D.
markers = {'+','o','.','x','v','d','^','s','>','<'};
% or maybe different styles of dashes.
styles = {'-', '--', ':'};
% styles = {'-', '--', '-.'};
% line and marker size
lineWidth = 1.5;
markerSize = 6;

% Iterate and collect data for each design.
for i=1:size(gd,2)
    % We'll need different x-axes as well as y-axes for designs, since max
    % theta is different.
    gd{i}.theta_max = sr_max_theta(gd{i}.r, gd{i}.N, gd{i}.L0);
    gd{i}.theta = linspace(0, gd{i}.theta_max, num_pts);
    % Transmission ratio of the actuator:
    % the trans_ratio function is currently not polymorphic to arrays/vectors,
    % so loop (ugh).
    % preallocate:
    gd{i}.tr = zeros(size(gd{i}.theta));
    for j=1:num_pts
        gd{i}.tr(j) = sr_trans_ratio(gd{i}.theta(j), gd{i}.r, gd{i}.N, gd{i}.L0);
    end
end

% for the continuous rails:
for i=1:size(gc,2)
    % We'll need different x-axes as well as y-axes for designs, since max
    % theta is different.
    gc{i}.theta_max = helix_max_theta(gc{i}.r, gc{i}.L0);
    gc{i}.theta = linspace(0, gc{i}.theta_max, num_pts);
    % Transmission ratio of the actuator:
    % the trans_ratio function is currently not polymorphic to arrays/vectors,
    % so loop (ugh).
    % preallocate:
    gc{i}.tr = zeros(size(gc{i}.theta));
    for j=1:num_pts
        gc{i}.tr(j) = helix_trans_ratio(gc{i}.theta(j), gc{i}.r, gc{i}.L0);
    end
end

% Plot all the trans ratios on one graph:
tratiofig = figure;
hold on;

% hack: first 3 are D rails
for i=1:3
    p(i) = plot(gd{i}.theta(1:num_pts_plot), gd{i}.tr(1:num_pts_plot), 'Color', d_color, 'LineWidth', lineWidth, 'LineStyle', styles{i});
end
% next 3 are C rails
for i=1:3
    p(i+3) = plot(gc{i}.theta(1:num_pts_plot), gc{i}.tr(1:num_pts_plot), 'Color', c_color, 'LineWidth', lineWidth, 'LineStyle', styles{i});
end

% Try adding markers to the last ones to help with overlap
p(3).Marker = 'o';
p(6).Marker = 'o';

% Set up the window
set(gca, 'FontSize', fontsize);
set(tratiofig, 'Position', fig_pos);
set(tratiofig, 'PaperPosition', fig_paperpos);

title('Actuator Transmission Ratio');
xlabel('Theta (rad)');
ylabel('Trans Ratio (cm/rad)');
legend('I', 'II', 'III', 'IV', 'V', 'VI', 'Location', 'SE');
hold off;

% % And another plot for normalized displacement, seeing if this gives any
% % more insight:
% dispfig = figure;
% hold on;
% % hack: first 3 are D rails
% for i=1:3
%     p(i) = plot(gd{i}.theta, gd{i}.d, 'Color', d_color, 'LineWidth', lineWidth, 'LineStyle', styles{i});
% end
% % c-rails
% for i=1:3
%     p(i+3) = plot(gc{i}.theta, gc{i}.d, 'Color', c_color, 'LineWidth', lineWidth, 'LineStyle', styles{i});
% end
% % Try adding markers to the last ones to help with overlap
% p(3).Marker = 'o';
% p(6).Marker = 'o';
% 
% % Set up the window
% set(gca, 'FontSize', fontsize);
% set(dispfig, 'Position', fig_pos);
% set(dispfig, 'PaperPosition', fig_paperpos);
% 
% title('Actuator Displacement');
% xlabel('Theta (rad)');
% ylabel('Displacement (%)');
% legend('I', 'II', 'III', 'IV', 'V', 'VI', 'Location', 'Best');
% hold off;

% Finally, normalized actuator trans ratio: \theta vs. \theta max.
normtratiofig = figure;
hold on;
% hack: first 3 are D rails
% p = {};
for i=1:3
    p(i) = plot((gd{i}.theta(1:num_pts_plot))/gd{i}.theta_max, gd{i}.tr(1:num_pts_plot), 'Color', d_color, 'LineWidth', lineWidth, 'LineStyle', styles{i});
end
% c-rails
for i=1:3
    p(i+3) = plot((gc{i}.theta(1:num_pts_plot))/gc{i}.theta_max, gc{i}.tr(1:num_pts_plot), 'Color', c_color, 'LineWidth', lineWidth, 'LineStyle', styles{i});
end
% Try adding markers to the last ones to help with overlap
p(3).Marker = 'o';
p(6).Marker = 'o';

% Set up the window
set(gca, 'FontSize', fontsize);
set(normtratiofig, 'Position', fig_pos);
set(normtratiofig, 'PaperPosition', fig_paperpos);

title('Normalized Actuator Transmission Ratio');
xlabel('Percent Max Theta (%)');
ylabel('Trans Ratio (cm/rad)');
legend('I', 'II', 'III', 'IV', 'V', 'VI', 'Location', 'SW');
hold off;









