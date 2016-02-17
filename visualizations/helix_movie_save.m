% helix_movie_save.m
% Saves a copy of the movie created by the helical_visualization script.
% Copyright 2015 Kyle Zampaglione, Andrew P. Sabelhaus

G = [M,fliplr(M),N, fliplr(N)];
for i = 1:length(G) 
       im = frame2im(G(i));
    [imind,cm] = rgb2ind(im,256);
    outfile = fullfile('C:\Users\Kyle\Documents\MATLAB','ladder.gif');
 
    % On the first loop, create the file. In subsequent loops, append.
    if i==1
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
    else
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'WriteMode','append');
    end
end