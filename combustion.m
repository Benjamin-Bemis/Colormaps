function [cmap] = combustion(m)


if nargin < 1
    m = size(get(groot,'DefaultFigureColormap'),1);
end


if nargin < 1
   m = size(get(groot,'DefaultFigureColormap'),1);
end

% Define anchor positions along the colormap (0=bottom, 1=top).
positions = [
    0.00;  % Light Blue/Cyan
    0.25;  % Royal Blue
    0.50;  % Dark Indigo (transition point)
    0.65;  % Red
    0.85;  % Orange
    1.00   % Yellow
];

% Define the RGB values [R, G, B] for each anchor point.
colors = [
    50/256, 127/256, 168/256;  % Light Blue/Cyan
    0.16, 0.00, 0.39;  % Dark Indigo
    0.00, 0.00, 1.00;  % Royal Blue
    1.00, 0.00, 0.00;  % Red
    1.00, 0.65, 0.00;  % Orange
    1.00, 1.00, 0.00   % Yellow
];

% Linearly interpolate to create the full colormap.
x_interp = linspace(0, 1, m)';
cmap = interp1(positions, colors, x_interp);

% Ensure all RGB values are clipped between 0 and 1.
cmap(cmap > 1) = 1;
cmap(cmap < 0) = 0;

 
end