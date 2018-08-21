function [steps, stepsBasins] = metrophastings(Nsim, Eavg, BasinGraph)
% Metropolis Hastings Algorithm for stets switch in energy landscape models
% INPUT:
%   Nsim - nr of steps in simulation
%   Eavg - vector of enegies assigned to states
%   BasinGraph - BasinGraph matrix from energy landscape ELAT program
% OUTPUT:
%   steps - vector with indices of states
%   stepsBasins - vector with assignement of states to basins
% Read par. 2.10 from Ezaki et al 2018 Human Brain Mapping. for more.
% Dominik Krzeminski 2018

energiesVec    = Eavg; 
basinAssigns   = BasinGraph(:,3);


Nn = log2(BasinGraph(end,1));
binStates = mfunc_VectorList(Nn);

steps = zeros(Nsim,1);
steps(1) = datasample(1:Nn,1);
for i=2:Nsim
    neighvec = neighbours(getBinState(steps(i-1), binStates), binStates);
    nxt = randsample(neighvec, 1);
    Eprev = energyOfState(steps(i-1), energiesVec);
    Enxt  = energyOfState(nxt, energiesVec);
    q = min([1, exp(Eprev - Enxt)]);
    steps(i) = randsample([steps(i-1), nxt], 1, true, [1-q, q]);
end
stepsBasins = zeros(Nsim,1);
for i=1:Nsim
    stepsBasins(i) = assignBasins(steps(i), basinAssigns);
end

end

function bs = getBinState(numstate, binStates)
    bs = binStates(:, numstate);
end

function ns = getNumState(state, binStates)
    ns = find(sum(binStates==state) == size(binStates, 1));
end

function nbvec = neighbours(binstate, binStates)
    nbvec = zeros(size(binstate));
    for i = 1:length(binstate)
        nb = binstate;
        nb(i) = nb(i)*-1;
        nbvec(i) = getNumState(nb, binStates);
    end
end

function ee = energyOfState(numstate, energyVec)
    ee = energyVec(numstate);
end

function bb = assignBasins(numstate, basinAssigns)
    bb = basinAssigns(numstate);
end
