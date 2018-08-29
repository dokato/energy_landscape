function distin = compDistintiv(minimumIdx,energies)
%compDistintiv computes distintivenes defined as:
%             average difference between energy value of minimum
%             and their neighbours
% INPUT:
%   minimumIdx - integer with minimum index
%   energies - vector with energy values
% OUTPUT:
%  distinctiveness - numerical value
Nn = log2(length(energies));
binStates = mfunc_VectorList(Nn);

binMinimum = getBinState(minimumIdx, binStates);

nbvec = neighbours(binMinimum,binStates);

energiesNeigh = zeros(length(nbvec),1);
ii = 1;
for nn = nbvec'
    energiesNeigh(ii) = energyOfState(nn, energies);
    ii = ii + 1;
end

distin = mean(energiesNeigh - energyOfState(nn, energies));
end

function bs = getBinState(numstate, binStates)
    bs = binStates(:, numstate);
end

function nbvec = neighbours(binstate, binStates)
    nbvec = zeros(size(binstate));
    for i = 1:length(binstate)
        nb = binstate;
        nb(i) = nb(i)*-1;
        nbvec(i) = getNumState(nb, binStates);
    end
end

function ns = getNumState(state, binStates)
    ns = find(sum(binStates==state) == size(binStates, 1));
end

function ee = energyOfState(numstate, energyVec)
    ee = energyVec(numstate);
end