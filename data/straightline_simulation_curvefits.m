% straightline_simulation_curvefits.m
% Curve fits to the straight line simulation data
% Copyright 2015 Kyle Zampaglione, Andrew P. Sabelhaus
% This file contains previously-fitted power curve data for the 
% three different straight-line-edge actuator simulations.
% It plots those fitted curves.

clear all; close all; clc;

%Rung Width transmission 

x = linspace(0,1620,1000);


%Rung width 1 
%r^2 = .9997
a =  -3.033e-005;
b = 1.708;
c = 9.147; 
y1 = a*x.^b+c;

%Rung width 2
d = -6.066e-005;
e = 1.708;
f = 18.29;
y2 = d*x.^e+f;

%Rung width 3 
g = -9.099e-005;
h = 1.708;
i = 27.44;
y3 = g*x.^h+i; 

hold on
plot(x,y1)
plot(x,y2, 'r')
plot(x,y3, 'g')
title('Straight Line Actuator Rung Width')
xlabel('Degrees Rotated')
ylabel('Total Length')
legend('Rung Width = 1', 'Rung Width = 2','Rung Width = 3') 
xlim([0 1600])
ylim([0 30])
hold off

figure
hold on
tot_height_deriv1 = diff(y1);
num_turns_deriv1 = linspace(x(1), x(end), length(tot_height_deriv1));
plot(num_turns_deriv1, tot_height_deriv1)

tot_height_deriv2 = diff(y2);
num_turns_deriv2 = linspace(x(1), x(end), length(tot_height_deriv2));
plot(num_turns_deriv2, tot_height_deriv2, 'r')

tot_height_deriv3 = diff(y3);
num_turns_deriv3 = linspace(x(1), x(end), length(tot_height_deriv3));
plot(num_turns_deriv3, tot_height_deriv3, 'g')
legend('Rung Width = 1', 'Rung Width = 2','Rung Width = 3') 
xlim([0 1600])
title('Straight Line Actuator Rate of Length Change')
xlabel('Degrees Rotated')
ylabel('Rate of Length Change')


