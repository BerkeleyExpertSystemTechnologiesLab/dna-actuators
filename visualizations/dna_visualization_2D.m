% dna_visualization_2D.m
% Copyright 2015 Kyle Zampaglione, Andrew P. Sabelhaus
% A function file to draw the structure of the DNA, in cross section.
% Function takes no arguments.
% -------------------------------------------------------
figure
a=0:0.05:4*pi;
r=1.5;

rcos = r*cos(a);
rsin = r*sin(a);
x1 = [rcos; rcos]';
y1 = [rsin; rsin]';
z = [a; a+0.4]';
surface(x1,y1,z,'facecolor','b','edgecolor','none');
%patch(surf2patch([rcos; rcos]',[rsin; rsin]',z),'facecolor','b','edgecolor','none'); % alternatively, use a patch!

a = a + pi;
rcos = r*cos(a);
rsin = r*sin(a);
x2 = [rcos; rcos]';
y2 = [rsin; rsin]';
surface(x2,y2,z,'facecolor','r','edgecolor','none');

I = 1:15:length(x1);
line([x1(I);x2(I)],[y1(I);y2(I)],[z(I);z(I)]);

axis on
view([55 10])
axis equal
camlight right; lighting phong