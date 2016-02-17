% dna_visualization_3D.m
% Copyright 2015 Kyle Zampaglione, Andrew P. Sabelhaus
% A function file to draw the structure of the DNA
% Function takes no arguments.
% -------------------------------------------------------
function dna
l=input('Enter no. of complete loops in helix structure(even no.): ');
 % ask user for no. of turns
if(mod(l,2)~=0) % check if the no. is even
 fprintf('Error! Wrong number entered please restart. ');
 return
end
l=(l/2)+0.5; %to make open half loops at
 % each end
x=linspace(-l*pi,l*pi,100); %start and end x co-ord
y=sin(x); %y co-ord for each x
plot(x,y,x,-y); %plot the double helix
hold on
j=-l*3; % x co-ord for the 1st base
axis ([j-1 -j+1 -3 3]);
z=-l+1; % to plot bases in the 1st 2
 % halves
while(z<(l*3+1)) % loop to switch halves
 while(j<z) % loop to plot the bases
 a=sin(j);
 i=linspace(a,-a,1000);
 plot(j,i)
 j=j+0.4;
 a=sin(j);
 end
z=z+1; % switch to next 2 halves
end