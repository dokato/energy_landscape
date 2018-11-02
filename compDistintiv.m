function distin = compDistintiv(minimumIdx,energies, basinMatrix)
%compDistintiv computes distintivenes defined as:
%             average difference between energy value of neighbours
%             and minimum
% INPUT:
%   minimumIdx - integer with minimum index
%   energies - vector with energy values
%   basinMatrix - basin matrix ELAT
% OUTPUT:
%  distinctiveness - numerical value
Nn = log2(length(energies));
binStates = mfunc_VectorList(Nn);

binMinimum = getBinState(minimumIdx, binStates);

nbvec = neighbours(binMinimum,binStates);
% only neigbours which belong to the graph
nbvecx = [];
for nn = nbvec'
    if basinMatrix(nn,3) == basinMatrix(minimumIdx,3)
        nbvecx = [nbvecx nn];
    end
end

energiesNeigh = zeros(length(nbvecx),1);
ii = 1;
for nn = nbvecx
    energiesNeigh(ii) = energyOfState(nn, energies);
    ii = ii + 1;
end

distin = mean(energiesNeigh - energyOfState(minimumIdx, energies));
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