function [Ecalc, LocalMinIndex, BasinGraph] = elat_main_hj(h, J, E, RoiNameFile)
% modification of elat main
%
if nargin < 3
    E = mfunc_Energy(h, J);
end
if nargin < 4
    Name = [];
else
    Name = flipud(importdata(RoiNameFile));
end

Ecalc = E;
%% Calculate Local Minima
nodeNumber = log2(length(E));
[LocalMinIndex, BasinGraph, AdjacentList] = mfunc_LocalMin(nodeNumber, E);

for i=1:size(LocalMinIndex)
    fprintf('LocalMinimum %d : state %d \n', i, LocalMinIndex(i));
end

save('BasinGraph.mat', 'BasinGraph')
%% Calculate Energy path by Dijkstra

[Cost, Path] = mfunc_DisconnectivityGraph(E, LocalMinIndex, AdjacentList);

%% Show activity pattern
% set the Name of signal before calling functiion by hand.
%Name = {'right ant thal', 'left ant thal', 'dACC/msFC', 'right al/fO',...
%    'left al/fO', 'right aPFC', 'left aPFC'};
% if fRoi
%     Name = flipud(importdata(RoiNameFile));
% else
%     Name = [];
% end
% Name = [];
vectorList = mfunc_VectorList(nodeNumber);
mfunc_ActivityMap(vectorList, LocalMinIndex, Name);
