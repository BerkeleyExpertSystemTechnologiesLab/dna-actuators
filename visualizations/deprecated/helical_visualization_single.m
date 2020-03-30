% helical_visualization_single.m
% Visualization of the curved rail double helix actuator, for 
% only one angle of twist
% Copyright 2015 Kyle Zampaglione, Andrew P. Sabelhaus
% 5.1.15
% Calculates change in z height for twisting of a helix


clear all; close all; clc;

%Initial Parameters =========================
%K = amount of twist in radians; must be larger than 0
%L = arc length or total length or rung
%D = width of rung
%r = radius of helix
%rungs = number of rungs in ladder
num_rotations = 3;
theta = num_rotations*pi;
%L = 15;
L = 16;
%D = 3;
D = 2;
r = D/2;
%rungs= 6;

%===========================================


%Initialize Movie Parameters
num_frames = length(pi/100:0.1:theta);
M(num_frames) = struct('cdata',[],'colormap',[]);
countframe = 1;

%Store all height values 
total_height_array = [];



%Plot all helixes over range 0 to K
%for j = pi/100:0.1:K %pi/100:0.1:K

c = sqrt((L/theta)^2 - r^2);
total_height = c*theta;
total_height_array(countframe)= total_height;


%Set up arrays for helixes
x_tot = length(0:0.1:theta);
y_tot = length(x_tot);
z_tot = length(x_tot);
x_tot2 = length(0:0.1:theta);
y_tot2 = length(x_tot2);
z_tot2 = length(x_tot2);

%Counter to move through array
count = 1;

%Plot Single Helix at given K value
for i = 0:0.01:theta
    %Plot first helix and store values
    x = r*cos(i) ;
    y = r*sin(i) ;
    z = c * i;
    x_tot(count) = x;
    y_tot(count) = y;
    z_tot(count) = z;

    %Plot second helix and store values
    x2 = r*cos(i+pi) ;
    y2 = r*sin(i+pi) ;
    z2 = c * i;
    x_tot2(count) = x2;
    y_tot2(count) = y2;
    z_tot2(count) = z2;
    count = count +1;
end



%Plot Helices===
hold on
set(gcf,'Position',[100,100,150,300]);
set(gcf,'PaperPosition',[2,2,3,4]);
plot3(x_tot,y_tot,z_tot, 'g','LineWidth',2);
plot3(x_tot2,y_tot2,z_tot2,'r','LineWidth',2);
%Plot Rungs ===


%Set up window ===
az = -37.5;
el = 8;
view(az,el);
%axis([-D D -D D 0 L]);
axis([-D/2 D/2 -D/2 D/2 0 L]);
%text(6,6,-2, sprintf('Total Height=%f',total_height))
%num_rotations = theta/(2*pi);
%title_text = sprintf('%3.3f Rotations over %3.0f Unit Long Actuator', num_rotations, L);
%title(title_text);

% Save images
save_path_base = 'img/helix_visualization';
% Save this figure
save_fullpath_fig = strcat(save_path_base, num2str(num_rotations), '.fig');
save_fullpath_eps = strcat(save_path_base, num2str(num_rotations), '.eps');
% savefig(save_fullpath_fig);
% print(save_fullpath_eps,'-depsc')


