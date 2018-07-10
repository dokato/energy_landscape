function [Evec, binSteps] = enerland_simulation(minima, Nsim)
% Generate signal of specified number of states and minima
% INPUT:
%   minima - matrix with local minima in order (from lowest to highest)
%            (nr of minima x states), eg [-1 -1  1;
%                                          1  1 -1]
%   Nsim   - number of simulated time steps
% OUTPUT:
%   Evec     - vector of generated energies
%   binSteps - binary vector with states assigned to the time points
%              based on Metropolis-Hastings algorithm
% Read par. 2.10 from Ezaki et al 2018 Human Brain Mapping. for more.
% Dominik Krzeminski 2018

states = size(minima, 2);
binStates = mfunc_VectorList(states);

Evec = 100 + zeros(2^states,1);
elmin = -3;

minimaids = [];
% minima states
for i=1:size(minima,1)
    idmin = getNumState(minima(i,:)', binStates);
    disp(['Minimum state:', num2str(idmin)])
    Evec(idmin) = elmin;
    elmin = elmin + 0.05;
    minimaids = [minimaids idmin];
end
% neighbours
for i=1:size(minima,1)
    idmin = getNumState(minima(i,:)', binStates);
    nbvec = neighbours(getBinState(idmin, binStates), binStates);
    nbvec = setdiff(nbvec, minimaids);
    nbofnbs = [];
    mvals = [];
    % increase energy of neighbours
    for ni = nbvec'
        nbvec2 = neighbours(getBinState(ni, binStates), binStates);
        nbvec2 = setdiff(nbvec2, minimaids);
        nbofnbs = [nbofnbs nbvec2'];
        if Evec(ni) == 100
            mval = Evec(idmin) + 0.6 + 0.1*rand(1,1);
        else
            mval = Evec(ni) + 0.2*rand(1,1);
        end
        Evec(ni) = mval;
        mvals = [mvals mval];
    end
    nbofnbs = unique(nbofnbs);
    maxmval = max(mvals);
    % increase energy of neighbours of neighbours
    for nii = nbofnbs'
        if Evec(nii) == 100
            Evec(nii) = maxmval + 0.4 + 0.1*rand(1,1);
        else
            Evec(nii) = Evec(ni) + 0.2*rand(1,1);
        end        
    end
end

Evec(find(Evec==100)) = -0.05*rand(length(find(Evec==100)),1);


steps = zeros(Nsim,1);
steps(1) = datasample(1:2^states,1);
binSteps = zeros(Nsim,states);
binSteps(i,:) = getBinState(steps(1), binStates);
for i=2:Nsim
    neighvec = neighbours(getBinState(steps(i-1), binStates), binStates);
    nxt = randsample(neighvec, 1);
    Eprev = energyOfState(steps(i-1), Evec);
    Enxt  = energyOfState(nxt, Evec);
    q = min([1, exp(Eprev - Enxt)]);
    steps(i) = randsample([steps(i-1), nxt], 1, true, [1-q, q]);
    binStep = getBinState(steps(i), binStates);
    binSteps(i,:) = getBinState(steps(i), binStates);
end
binSteps = binSteps';
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
