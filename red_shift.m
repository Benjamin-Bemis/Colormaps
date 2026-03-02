function [cmap] = red_shift(m)


if nargin < 1
    m = size(get(groot,'DefaultFigureColormap'),1);
end


if nargin < 1
   m = size(get(groot,'DefaultFigureColormap'),1);
end

% Define anchor positions along the colormap (0=bottom, 1=top).
positions = linspace(0,1,8);

% Define the RGB values [R, G, B] for each anchor point.
colors = [
    102,0,12;
    146,10,19;
    191,44,49;
    205,26,30;
    229,51,39;
    242,72,52;
    248,99,70;
    250,127,95;
]./255;

% Linearly interpolate to create the full colormap.
x_interp = linspace(0, 1, m)';
cmap = interp1(positions, colors, x_interp);

% Ensure all RGB values are clipped between 0 and 1.
cmap(cmap > 1) = 1;
cmap(cmap < 0) = 0;

 
end