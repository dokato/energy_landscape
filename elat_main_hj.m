function [Ecalc, LocalMinIndex, BasinGraph] = elat_main_hj(h, J, E, RoiNameFile, plotGen)
% modification of elat main
%
if nargin < 3 || isempty(E)
    E = mfunc_Energy(h, J);
end
if nargin < 4 || isempty(RoiNameFile)
    Name = [];
else
    Name = flipud(importdata(RoiNameFile));
end
if nargin < 5
    plotGen = 1;
end

Ecalc = E;
%% Calculate Local Minima
nodeNumber = log2(length(E));
[LocalMinIndex, BasinGraph, AdjacentList] = mfunc_LocalMin(nodeNumber, E);

for i=1:size(LocalMinIndex)
    fprintf('LocalMinimum %d : state %d \n', i, LocalMinIndex(i));
end

save('BasinGraph2.mat', 'BasinGraph')
%% Calculate Energy path by Dijkstra

if plotGen
    [Cost, Path] = mfunc_DisconnectivityGraph(E, LocalMinIndex, AdjacentList);

    %% Show activity pattern
    vectorList = mfunc_VectorList(nodeNumber);
    mfunc_ActivityMap(vectorList, LocalMinIndex, Name);
end