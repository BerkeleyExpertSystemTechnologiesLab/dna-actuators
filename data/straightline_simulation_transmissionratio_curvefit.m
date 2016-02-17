% straightline_simulation_transmissionratio_curvefit.m
% Copyright 2015 Kyle Zampaglione, Andrew P. Sabelhaus
% Plot the transmission ratio from straight line ladder model, using
% a curve that was previously fitted.

clear all; close all; clc;

%twistangle = [0.001, 180, 360, 540, 720, 810, 900]
%length =  [10.0000, 9.5100 ,8.0900, 5.8800, 3.0900, 1.5600, 0]
%plug into cftool and do power fit to 2 terms 

a =  -7.4050e-005;
b = 1.739;
c = 10.07; 

x = linspace(0,900,1000);
plot(x,a*x.^b+c)
title('Straight Line Actuator Transmission Curve')
xlabel('Degrees Rotated')
ylabel('Total Length')

