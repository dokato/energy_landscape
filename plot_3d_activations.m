function plot_3d_activations(netlabels, activeregions)
% plot_3d_activations
% INPUT:
%   netlabels - cell with names of network regions from AAL atlas
%   activeregions - regions which are about to show to be active
% OUTPUT:
%    brain plot with marked networks and active regions

load('/home/c1745595/projects/epilepsy_data/matlab/aal_labels.mat')

vals = zeros(length(AAL_Labels),1)*nan;

network_values = -10;

for j = 1: length(netlabels)
    IndexC = strfind(AAL_Labels, netlabels{j});
    Index = find(not(cellfun('isempty', IndexC)));
    vals(Index) = network_values;
end

activeregions_values = 10;
for j = 1: length(activeregions)
    IndexC = strfind(AAL_Labels, activeregions{j});
    Index = find(not(cellfun('isempty', IndexC)));
    vals(Index) = activeregions_values;
end

figure;
A = atemplate('hemi','left', 'overlay',vals,'method',{'aal_light','spheres'});
%A = atemplate('overlay', vals, 'method','raycast', 'colbar', 0);
alpha 0.8;
slice3();
end

