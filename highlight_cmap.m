function cmap = highlight_cmap(m, highlight_range, highlight_map, base_color)
% HIGHLIGHT_CMAP Creates a colormap that highlights a specific data range.
%
%   cmap = CREATE_HIGHLIGHT_CMAP(M, HIGHLIGHT_RANGE, HIGHLIGHT_MAP, BASE_COLOR)
%   creates a colormap with M colors that uses the colormap specified by
%   HIGHLIGHT_MAP for the data range defined by HIGHLIGHT_RANGE, and a
%   solid BASE_COLOR for all other values.
%
%   Inputs:
%       M               - The total number of colors in the colormap (e.g., 256).
%       HIGHLIGHT_RANGE - A 2-element vector [min_frac, max_frac] defining the
%                         fractional range to highlight (values from 0 to 1).
%       HIGHLIGHT_MAP   - The colormap for the highlighted section. This can be
%                         a string for a built-in map (e.g., 'jet', 'hot') or
%                         an N-by-3 matrix for a custom map (like the one
%                         from create_diverging_cmap).
%       BASE_COLOR      - An [R, G, B] triplet for the non-highlighted regions
%                         (e.g., [0.5, 0.5, 0.5] for gray).
%
%   How to use with your data:
%   To highlight a specific data range [min_val, max_val], you need to
%   convert it to a fractional range based on your color axis limits [cmin, cmax].
%   Calculate the range as:
%   min_frac = (min_val - cmin) / (cmax - cmin);
%   max_frac = (max_val - cmin) / (cmax - cmin);
%   highlight_range = [min_frac, max_frac];
%
%   Example:
%       % Generate some sample data
%       figure;
%       data = peaks(250);
%       contourf(data, 20);
%       axis equal;
%       colorbar;
%
%       % Highlight values between 3 and 8 using the 'hot' colormap
%       caxis([-8, 8]); % Set color limits
%       cmin = -8;
%       cmax = 8;
%
%       % Define the data range to highlight
%       min_val_to_highlight = 3;
%       max_val_to_highlight = 8;
%
%       % Convert data range to fractional range
%       min_frac = (min_val_to_highlight - cmin) / (cmax - cmin);
%       max_frac = (max_val_to_highlight - cmin) / (cmax - cmin);
%       h_range = [min_frac, max_frac];
%
%       % Create and apply the colormap
%       cmap = create_highlight_cmap(256, h_range, 'hot', [0.7 0.7 0.7]);
%       colormap(cmap);
%       title('Colormap Highlighting Values from 3 to 8');

% --- Argument Handling ---
if nargin < 4
    % Default base color is a light gray.
    base_color = [0.7, 0.7, 0.7];
end
if nargin < 3
    % Default highlight map is 'jet'.
    highlight_map = 'jet';
end
if nargin < 2
    % Default highlight range is the top 20% of the map.
    highlight_range = [0.8, 1.0];
end
if nargin < 1
    % If no size M is specified, use the current figure's colormap size.
    m = size(get(gcf,'colormap'),1);
end

% Validate highlight_range
if ~isnumeric(highlight_range) || numel(highlight_range) ~= 2 || ...
   highlight_range(1) < 0 || highlight_range(2) > 1 || highlight_range(1) >= highlight_range(2)
    error('Input ''highlight_range'' must be a 2-element vector [min, max] with values between 0 and 1.');
end

% --- Create the Base Colormap ---
% Initialize the entire colormap with the base color.
cmap = repmat(base_color, m, 1);

% --- Determine Indices for Highlighting ---
% Calculate the starting and ending row indices for the highlight section.
start_index = floor(highlight_range(1) * (m - 1)) + 1;
end_index = ceil(highlight_range(2) * (m - 1)) + 1;
num_highlight_colors = end_index - start_index + 1;

% --- Generate and Insert the Highlight Colormap ---
% Check if highlight_map is a string or a matrix
if ischar(highlight_map) || isstring(highlight_map)
    % If it's a string, call the corresponding colormap function.
    % We use feval to call the function by its string name.
    highlight_colors = feval(highlight_map, num_highlight_colors);
else
    % If it's already a matrix, interpolate it to the correct size.
    if size(highlight_map, 2) ~= 3
        error('Custom ''highlight_map'' must be an N-by-3 matrix.');
    end
    % Create query points for interpolation
    original_indices = linspace(0, 1, size(highlight_map, 1));
    query_indices = linspace(0, 1, num_highlight_colors);
    highlight_colors = interp1(original_indices, highlight_map, query_indices);
end

% Place the generated highlight colors into the main colormap.
cmap(start_index:end_index, :) = highlight_colors;

% Ensure the output values are clipped to the [0, 1] range.
cmap(cmap > 1) = 1;
cmap(cmap < 0) = 0;

end
