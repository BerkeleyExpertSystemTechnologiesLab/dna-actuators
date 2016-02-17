% helical_visualization_reversed.m
% Helical Actuator Visualization, Reverse Twisting (Negative Angles)
% Copyright 2015 Kyle Zampaglione, Andrew P. Sabelhaus
% 5.1.15
% Calculates change in z height for twisting of a helix


close all
%clear all
%Initial Parameters =========================
%K = amount of twist in radians; must be larger than 0
%L = arc length or total length or rung
%D = width of rung
%r = radius of helix
%rungs = number of rungs in ladder
K = 4*pi+1;
L = 14;
D = 2;
r = D/2;
rungs = 9;

%===========================================

%Initialize Movie Parameters
num_frames = length(pi/100:0.1:K);
N(num_frames) = struct('cdata',[],'colormap',[]);
countframe = 1;
total_height_array = [];



%Plot all helixes over range 0 to K
for j = pi/100:0.1:K
    
    c = sqrt((L/j)^2 - r^2);
    total_height = c*j;
    total_height_array(countframe)= total_height;
    
    
    %Set up arrays for helixes
    x_tot = length(0:0.1:j);
    y_tot = length(x_tot);
    z_tot = length(x_tot);
    x_tot2 = length(0:0.1:j);
    y_tot2 = length(x_tot2);
    z_tot2 = length(x_tot2);
    
    %Counter to move through array
    count = 1;
    
    %Plot Single Helix at given K value
    for i = 0:0.01:j
        %Plot first helix and store values
        x = r*cos(-i) ;
        y = r*sin(-i) ;
        z = c * i;
        x_tot(count) = x;
        y_tot(count) = y;
        z_tot(count) = z;
        
        %Plot second helix and store values
        x2 = r*cos(-(i+pi)) ;
        y2 = r*sin(-(i+pi)) ;
        z2 = c * i;
        x_tot2(count) = x2;
        y_tot2(count) = y2;
        z_tot2(count) = z2;
        count = count +1;
    end
    
    
    
    %Plot Helices===
    hold on
    plot3(x_tot,y_tot,z_tot, 'g');
    plot3(x_tot2,y_tot2,z_tot2,'r');
    %Plot Rungs ===
    
    
    %Set up window ===
    az = -37.5;
    el = 8;
    view(az,el);
    axis([-D D -D D 0 L]);
    text(6,6,-2, sprintf('Total Height=%f',total_height))
    num_rotations = -K/(2*pi);
    title_text = sprintf('%3.3f Rotations over %3.0f Unit Long Actuator', num_rotations, L);
    title(title_text);
    
    pause(0.05);
    
    
    N(countframe) = getframe(gcf);
    countframe = countframe + 1;
    %close(gcf);
    
    
    %Clear every image except the last one=====
    if j<(K-0.1)
        clf;
    end
    
end




%Plot number of turns vs total length
figure
hold on
num_turns = linspace(0.1,K/(2*pi), length(total_height_array));
plot(num_turns, total_height_array)
title('Total Length vs Num of Turns')
xlabel('Number of turns')
ylabel('Total Length')

hold off

%Derivative; rate of change of turns vs length
figure
tot_height_deriv = diff(total_height_array);
num_turns_deriv = linspace(0,K/(2*pi), length(tot_height_deriv));
plot(num_turns_deriv, tot_height_deriv)
title('Derviative of total length vs num turns')
xlabel('Number of turns')
ylabel('Rate of change in length')

