% straightline_visualization.m
% Straight-line-edge actuator visualization
% Copyright 2015-2020 Kyle Zampaglione, Andrew P. Sabelhaus
% Calculates change in z height for twisting of a rope-ladder style helix
% connected with rigid (straight-line) edges.
% This simulation calculates the geometry of the structure for multiple
% successive angles of twist.
% NOTE: Calculations break down as period of rotation repeats with low
% number of rungs

clc; clear all; close all;

% Add the paths to the modeling equations
addpath( '../analytical_models' );

%% CONSTANTS FOR THE SIMULATION
% Design I for the discrete rails. All in cm.
% The rungs have a set width. This is also the width between the two
% edges of the helix.
w = 2 * 2.54;
% The initial length of the helix (also the length of a rail)
L0 = 30.48;
% Number of rungs
N = 7;
% absolute distance between rungs. This value can also be interpreted as 
% the length of the edge of the structure between two successive rungs.
% ell_i = 1;  
ell_i = L0 / (N-1);

% Path to store the images that are generated
save_path_base = '../img/journal2020/D_rails_vis';

% Range of input angles to evaluate.
% Let's do it in terms of 'one rotation equals pi degrees.'
% Maximum rotation angle: 18.85 for design I.
max_rot = 15;
% choosing the number of rotations to be an interval of N+1 of the maximum
% rotations makes the visualization easier: even numbers.
num_rot = 3;
% The range of input rotations to visualize, in radians, is
rotations = linspace(0, max_rot, num_rot);

% Store the length of the actuator for each rotation.
L = zeros(size(rotations));

% For plotting, some parameters on color and thickness.
rungcolor = 'k';
rungthickness = 2;
railcolor = 'b';
railthickness = 2;


%% VALUES STORED THROUGHOUT MULTIPLE ITERATIONS 
% z_totaled = [];
L_history = [];
angle_out = [];
% an index into the above vectors
count = 1;



%% SIMULATION
% j is the number of rotations to simulate. 
% For example, j=1 is 180 degrees, j=3 is 540 degrees, etc.

% Here, just iterate over the number of rotations
%for j = 1:9
for j=1:size(rotations,2)
    %SETUP ============================================
    FigureHandle = figure;
    hold on
    set(gca,'FontSize',14);
    % Set the size of the figure window
    % Vertical:
    set(FigureHandle,'Position',[100,100,550,220]);
    % Set the size of the figure window for printing (saving the fig)
%     set(FigureHandle,'PaperPosition',[2,2,3,4]);
    % Label the axes
%     xlabel('  X');
%     ylabel('Y   ');
    %zlabel('Z');
    
    % For the horizontal actuator, the x-axis is length.
    % and y-z are the radial and polar coordinates
    xlabel('Length (cm)');
    ylabel('Y');
    zlabel('Z');
    
    title('Discrete-Rails Actuator Visualization');
    
    % Vertical:
%     zlim([0,11]);

    % Horizontal:
    xlim([0, 32]);
    zlim([-2.6, 2.6]);
    ylim([-2.6, 2.6]);
    %==================================================
    
    % The angle between each rung is
    theta_i = rotations(j) / (N-1);
    
    % Here, z refers to the z-axis location of the center of the rung.
    % x and y refer to the location of one outer point of a rung
    % in that plane.
    % The rung center is at (0, 0, z).
    % One edge of the rung is then at (x, y, z) and the other is 
    % at (-x, -y, z).

%     % First rung is at height 0 and lies along the x-axis
%     x = 0; %initial x
%     y = w/2; %initial y
%     z_prev = 0; %initial z
%     % 0-th rung
%     plot3([-x,x],[-y,y], [0,0], rungcolor, 'LineWidth', rungthickness);
    
    % For the horizontal simulation, we'll do x as the length direction,
    % and y-z as the other two.
    z = 0; %initial z, one of the polar coordinates
    y = w/2; %initial y, one of the radial coordinates
    x_prev = 0; %initial x, length
    % 0-th rung
    plot3([x_prev,x_prev],[-y,y], [-z,z], rungcolor, 'LineWidth', rungthickness);
    

    % Iterate over each rung and plot it
    for i = 1:(N-1)
%         x_new = sin(theta_i * i) * w/2;
%         y_new = cos(theta_i * i) * w/2;
        z_new = sin(theta_i * i) * w/2;
        y_new = cos(theta_i * i) * w/2;
%         z = sqrt(ell_i^2 - (x_new-x)^2 - (y_new-y)^2) + z_prev;
        x = sqrt(ell_i^2 - (z_new-z)^2 - (y_new-y)^2) + x_prev;
        
        % plot the rung
%         plot3([-x_new,x_new], [-y_new,y_new], [z,z], rungcolor, 'LineWidth', rungthickness);
        plot3([x,x], [-y_new,y_new], [-z_new,z_new], rungcolor, 'LineWidth', rungthickness);
        % plot the two rails
%         plot3([x,x_new], [y,y_new],[z_prev,z],railcolor, 'LineWidth', railthickness); %connect rungs 
        plot3([x_prev,x], [y,y_new],[z,z_new],railcolor, 'LineWidth', railthickness);
%         plot3([-x,-x_new], [-y,-y_new],[z_prev,z], railcolor, 'LineWidth', railthickness); %connect rungs 
        plot3([x_prev,x], [-y,-y_new],[-z,-z_new], railcolor, 'LineWidth', railthickness);
        
        % update for next iteration (next rung)
%         x = x_new;
%         y = y_new;
%         z_prev = z;
        z = z_new;
        y = y_new;
        x_prev = x;
    end

    hold off 
    axis equal
    %titletext = sprintf('Twist Angle = %d; Z-Height = %f',twistangle,z);
    %title(titletext)

    %legendtext = sprintf('Rung Width = %d ; Rung Spacing = %d',rungwidth, rungspacing );
    %legend(legendtext, 'Location','southoutside','Orientation','horizontal')
    
    % For the vertical"
%     view(45,12) 
    
    % For the horizontal:
%     view(18,18)
%     view(0,0);
%     view(17,37)
%     view(26,16)
    view(26,8);
    %print final z value to screen
    z_total = z;
    z_totaled(count) = z_total; 
    count = count+1;
    
    % Trying to force vector graphics
    set(gcf,'renderer','Painters')
    
    % Save this figure
    save_fullpath_fig = strcat(save_path_base, int2str(theta_i), '.fig');
    save_fullpath_eps = strcat(save_path_base, int2str(theta_i), '.eps');
    save_fullpath = strcat(save_path_base, int2str(theta_i));
%     saveas(gcf, save_fullpath, 'svg');
    %savefig(save_fullpath_fig);
    %print(save_fullpath_eps,'-depsc')
end



