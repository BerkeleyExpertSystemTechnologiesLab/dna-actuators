% straightline_visualization.m
% Straight-line-edge actuator visualization
% Copyright 2015 Kyle Zampaglione, Andrew P. Sabelhaus
% 2.11.15
% Calculates change in z height for twisting of a rope-ladder style helix
% connected with rigid (straight-line) edges.
% This simulation calculates the geometry of the structure for multiple
% successive angles of twist.
% NOTE: Calculations break down as period of rotation repeats with low
% number of rungs

clc; clear all; close all;

%% VALUES STORED THROUGHOUT MULTIPLE ITERATIONS 
z_totaled = [];
angle_out = [];
% an index into the above vectors
count = 1;

%% CONSTANTS FOR THE SIMULATION
% The rungs have a set width. This is also the width between the two
% edges of the helix.
rungwidth = 2;
% absolute distance between rungs. This value can also be interpreted as 
% the length of the edge of the structure between two successive rungs.
rungspacing = 2;  
number_rungs = 10; 
% Path to store the images that are generated
save_path_base = 'img/straightline_visualization';

%% SIMULATION
% j is the number of rotations to simulate. 
% For example, j=1 is 180 degrees, j=3 is 540 degrees, etc.
for j = 1:9
    %SETUP ============================================
    FigureHandle = figure;
    hold on
    %set(gca,'FontSize',11);
    % Set the size of the figure window
    set(FigureHandle,'Position',[100,100,150,300]);
    % Set the size of the figure window for printing (saving the fig)
    set(FigureHandle,'PaperPosition',[2,2,3,4]);
    zlim([0,18]);
    twistangle =  j*180; %set twist angle in degrees. This is the total angle of twist for the entire structure.
    angle_out(count) = twistangle; 
    %==================================================
    
    %Calculate angle of rotation between each rung
    indivtwist = twistangle/(number_rungs-1);
    
    % Here, z refers to the z-axis location of the center of the rung.
    % x and y refer to the location of one outer point of a rung
    % in that plane.
    % The rung center is at (0, 0, z).
    % One edge of the rung is then at (x, y, z) and the other is 
    % at (-x, -y, z).

    % First rung is at height 0 and lies along the x-axis
    x = 0; %initial x
    y = rungwidth/2; %initial y
    z_prev = 0; %initial z
    plot3([-x,x],[-y,y], [0,0]);

    hold on 

    for i = 1:(number_rungs-1)
        x_new = sind(indivtwist*i)*rungwidth/2; 
        y_new = cosd(indivtwist*i)*rungwidth/2;
        z = sqrt(rungspacing^2 - (x_new-x)^2 - (y_new-y)^2) + z_prev;
        plot3([-x_new,x_new], [-y_new,y_new], [z,z])
        plot3([x,x_new], [y,y_new],[z_prev,z],'g'); %connect rungs 
        plot3([-x,-x_new], [-y,-y_new],[z_prev,z],'g'); %connect rungs 
        x = x_new;
        y = y_new;
        z_prev = z;
    end

    hold off 
    axis equal
    %titletext = sprintf('Twist Angle = %d; Z-Height = %f',twistangle,z);
    %title(titletext)

    %legendtext = sprintf('Rung Width = %d ; Rung Spacing = %d',rungwidth, rungspacing );
    %legend(legendtext, 'Location','southoutside','Orientation','horizontal')
    view(45,12) 
    %print final z value to screen
    z_total = z;
    z_totaled(count) = z_total; 
    count = count+1;
    
    % Save this figure
    save_fullpath_fig = strcat(save_path_base, int2str(twistangle), '.fig');
    save_fullpath_eps = strcat(save_path_base, int2str(twistangle), '.eps');
    %savefig(save_fullpath_fig);
    %print(save_fullpath_eps,'-depsc')
end



