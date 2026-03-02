function [cmap] = blue_shift(m)


if nargin < 1
    m = size(get(groot,'DefaultFigureColormap'),1);
end


if nargin < 1
   m = size(get(groot,'DefaultFigureColormap'),1);
end

% Define anchor positions along the colormap (0=bottom, 1=top).
positions = linspace(0,1,6);

% Define the RGB values [R, G, B] for each anchor point.
colors = [
    8,48,107;
    46,127,187;
    77,153,203;
    102,171,211;
    164,204,227;
    190,216,235;
]./255;

% Linearly interpolate to create the full colormap.
x_interp = linspace(0, 1, m)';
cmap = interp1(positions, colors, x_interp);

% Ensure all RGB values are clipped between 0 and 1.
cmap(cmap > 1) = 1;
cmap(cmap < 0) = 0;

 
end