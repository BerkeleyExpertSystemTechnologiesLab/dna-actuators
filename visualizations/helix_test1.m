% helix_test1.m
% Test plot of an individual double helix.
% Copyright 2015 Kyle Zampaglione, Andrew P. Sabelhaus
%%Helix Test 

clear all; close all; clc;

%SETUP ============================================
figure
rungwidth = 3;
rungspacing = 2;  %abs distance between rungs 
twistangle =  90; %set twist angle in degrees
number_rungs = 4; 
%==================================================
%Calculate angle of rotation between each rung
indivtwist = twistangle/(number_rungs-1);

%First rung
x = 0; %initial x
y = rungwidth/2; %initial y
z_prev = 0; %initial z
plot3([-x,x],[-y,y], [0,0]);

hold on
b = sqrt((rungspacing*(number_rungs))^2 - (rungwidth/2)^2);

t = 0:0.05:twistangle;
x = rungwidth/2*sind(t);
y = rungwidth/2*cosd(t);
z = b*t*pi/180; 
plot3(x,y,z, 'g')
plot3(-x,-y,z, 'g')

%for i = 1:(number_rungs-1)


%end

hold off 
%axis equal
z_total = z(end)