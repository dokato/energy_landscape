function [steps, stepsBasins] = stateSwitchesFromSignal(signal, BasinGraph, threshold)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

if nargin < 3
    threshold = 0;
end
basinAssigns   = BasinGraph(:,3);
binData = pfunc_01_Binarizer(signal, threshold);

Nn = min(size(signal));
binStates = mfunc_VectorList(Nn);

steps = zeros(max(size(signal)),1);
for i=1:max(size(signal))
    steps(i) = getNumState(binData(:,i), binStates);
end

stepsBasins = zeros(max(size(signal)),1);
for i=1:max(size(signal))
    stepsBasins(i) = assignBasins(steps(i), basinAssigns);
end

end

function ns = getNumState(state, binStates)
    ns = find(sum(binStates==state) == size(binStates, 1));
end

function bb = assignBasins(numstate, basinAssigns)
    bb = basinAssigns(numstate);
end
