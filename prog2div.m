function cmap_div = prog2div(cmap_prog, center_end)
%PROG2DIV Convert a progressive colormap to a divergent colormap.
%   CMAP_DIV = PROG2DIV(CMAP_PROG) converts a progressive colormap
%   (e.g., parula, viridis) into a divergent colormap. By default, it uses
%   the LAST color of CMAP_PROG as the central color of the new map.
%   The resulting colormap progresses from the first color of CMAP_PROG to
%   the last, and then back to the first. For example, if CMAP_PROG is
%   blue-to-yellow, the output will be blue-to-yellow-to-blue.
%
%   CMAP_DIV = PROG2DIV(CMAP_PROG, CENTER_END) specifies which end of
%   CMAP_PROG to use as the central color. CENTER_END can be:
%     'last'  (default) - Use the last color as the center.
%     'first' - Use the first color as the center.
%
%   Example 1: Create a blue-yellow-blue divergent map from parula
%    prog_map = parula(128);
%    div_map = prog2div(prog_map);
%    figure;
%    imagesc(peaks(500));
%    colormap(div_map);
%    colorbar;
%    title('Divergent Map (Center: Last Color of Parula)');

%   Example 2: Create a yellow-blue-yellow divergent map from parula
%     prog_map = parula(128);
%     div_map = prog2div(prog_map, 'first');
%     figure;
%     imagesc(peaks(500));
%     colormap(div_map);
%     colorbar;
%     title('Divergent Map (Center: First Color of Parula)');
%
%   See also: colormap, parula, flipud.

% --- Input Validation ---
if nargin < 1
    error('prog2div:NotEnoughInputs', 'This function requires at least one input argument (a colormap).');
end

if ~isnumeric(cmap_prog) || size(cmap_prog, 2) ~= 3 || size(cmap_prog, 1) < 2
    error('prog2div:InvalidColormap', 'Input must be a valid colormap (an M-by-3 matrix of numeric values).');
end

if nargin < 2
    center_end = 'last'; % Default behavior
end

if ~ischar(center_end) || ~any(strcmpi(center_end, {'first', 'last'}))
    error('prog2div:InvalidOption', "Second argument must be either 'first' or 'last'.");
end

% --- Main Logic ---
n_colors = size(cmap_prog, 1);

if strcmpi(center_end, 'last')
    % Use the last color as the center.
    % The map goes from cmap_prog(1) -> cmap_prog(end) -> cmap_prog(1)
    
    % First wing is the original colormap.
    wing1 = cmap_prog;
    
    % Second wing is the original colormap reversed, without the endpoint
    % which is now the center.
    wing2 = flipud(cmap_prog(1:n_colors-1, :));
    
    % Combine them
    cmap_div = [wing1; wing2];
    
else % center_end is 'first'
    % Use the first color as the center.
    % The map goes from cmap_prog(end) -> cmap_prog(1) -> cmap_prog(end)
    
    % First wing goes from the last color to the first.
    wing1 = flipud(cmap_prog);
    
    % Second wing goes from the second color back to the last.
    wing2 = cmap_prog(2:n_colors, :);
    
    % Combine them
    cmap_div = [wing1; wing2];
end

end
