% helical_visualization.m
% Helical-edge (continuous rail) actuator visualization
% Copyright 2015-2020 Kyle Zampaglione, Andrew P. Sabelhaus
% Plots a visualization of helical actuator at various displacements.

clc; clear all; close all;

% Add the paths to the modeling equations
addpath( '../analytical_models' );

%% CONSTANTS FOR THE SIMULATION
% Design IV for the continuous rails. All in cm.
% The rungs have a set width. This is also the width between the two
% edges of the helix.
w = 2 * 2.54;
% The initial length of the helix (also the length of a rail)
L0 = 30.48;
% Number of rungs. This is for visualization only.
N = 7;
%  We will need to discretize the points along the edges of the helix for
%  plotting, so just choose a large number here. A multiple of N makes the
%  plotting easier.
edge_discr = 105;
% An easy way to determine which points to place rungs at is in intervals
% of 
rung_interval = floor(edge_discr/N);

% Range of input angles to evaluate. This *should* be in radians
% Maximum rotation angle: 12 for design IV.
% TO-DO: NORMALIZE TO D-RAILS!!!
max_rot = 11.8;
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
for j=1:size(rotations,2)
    %SETUP ============================================
    FigureHandle = figure;
    hold on
    set(gca,'FontSize',14);
    % Set the size of the figure window
    % Vertical:
    set(FigureHandle,'Position',[100,100,550,220]);
    
    % For the horizontal actuator, the x-axis is length.
    % and y-z are the radial and polar coordinates
    xlabel('Length (cm)');
    ylabel('Y');
    zlabel('Z');
    
    title('Continuous-Rails Actuator Visualization');

    % Horizontal:
    xlim([0, 32]);
    zlim([-2.6, 2.6]);
    ylim([-2.6, 2.6]);
    %==================================================
    
    % This particular rotation will use the following thetas:
    theta = linspace(0, rotations(j), edge_discr);
    % The slope of the helix, used for iterating over angle
    b = sqrt(L0^2 / rotations(j)^2 - (w/2)^2);
    
    % Procedure, for each theta:
    % 1) Plot the rails. Loop from theta=0 to theta=max (i.e., rot(j)).
    % 2) Plot the rungs. It's safe to assume they're evenly spaced.
    %       So, calculate the interval vs. L0, get the two points, draw
    %       line.
    
    
    % For the horizontal simulation, we'll do x as the length direction,
    % and y-z as the other two.
    z = 0; %initial z, one of the polar coordinates
    y = w/2; %initial y, one of the radial coordinates
    x_prev = 0; %initial x, length
    % 0-th rung
    plot3([x_prev,x_prev],[-y,y], [-z,z], rungcolor, 'LineWidth', rungthickness);
    
    for t=1:size(theta,2)
        % The x-coordinate at this value is
%         x = helix_length(theta(t), w/2, L0);
        x = b * theta(t);
        % The polar coordinates of the base circle in the y,z plane are 
        z_next = sin(theta(t)) * w/2;
        y_next = cos(theta(t)) * w/2;
        % A line between this point and the previous one.
        plot3([x_prev,x], [y,y_next],[z,z_next],railcolor, 'LineWidth', railthickness);
        % For the other rail too:
        plot3([x_prev,x], [-y,-y_next],[-z,-z_next], railcolor, 'LineWidth', railthickness);
        % If this point on the curve is where a rail is attached, i.e. this
        % index of theta is an interval of edge_discr/N,
        if (mod(t, rung_interval) == 0)
            % Plot a rung.
            plot3([x,x], [-y_next,y_next], [-z_next,z_next], rungcolor, 'LineWidth', rungthickness);
        end
        % Update for next iteration
        z = z_next;
        y = y_next;
        x_prev = x;
    end
    

%     % Iterate over each rung and plot it
%     for i = 1:(N-1)
%         z_new = sin(theta_i * i) * w/2;
%         y_new = cos(theta_i * i) * w/2;
%         x = sqrt(ell_i^2 - (z_new-z)^2 - (y_new-y)^2) + x_prev;
%         
%         % plot the rung
%         plot3([x,x], [-y_new,y_new], [-z_new,z_new], rungcolor, 'LineWidth', rungthickness);
%         % plot the two rails
%         plot3([x_prev,x], [y,y_new],[z,z_new],railcolor, 'LineWidth', railthickness);
%         plot3([x_prev,x], [-y,-y_new],[-z,-z_new], railcolor, 'LineWidth', railthickness);
%         
%         % update for next iteration (next rung)
%         z = z_new;
%         y = y_new;
%         x_prev = x;
%     end

    hold off 
    axis equal
    
    % For the vertical"
%     view(45,12) 
    
    % For the horizontal:
%     view(18,18)
%     view(0,0);
%     view(17,37)
%     view(26,16)
    view(26,8);
    %print final z value to screen
%     z_total = z;
%     z_totaled(count) = z_total; 
%     count = count+1;
    
    % Trying to force vector graphics
    set(gcf,'renderer','Painters')
end



