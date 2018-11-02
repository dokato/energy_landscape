function [nh, nJ] = shuffleJh(h, J, mode)
%SHUFFLEJH shuffles randomly J and H
if nargin < 3
    mode = 1;
end

nJ = zeros(size(J));
idcs_l = find(tril(ones(size(J)),-1));

if mode == 1
    % shuffle approach
    allJs = unique(J(find(J~=0)));
    allJs = allJs(randperm(length(allJs)));
    nJ(idcs_l) = allJs(1:length(idcs_l));
    nJ = (nJ+nJ') - eye(size(nJ,1)).*diag(nJ);
    nh = h(randperm(length(h)));
else
    % gaussian approach
    allJs = unique(J(find(J~=0)));
    allJs = randn(size(allJs))*std(allJs) + mean(allJs);
    nJ(idcs_l) = allJs(1:length(idcs_l));
    nJ = (nJ+nJ') - eye(size(nJ,1)).*diag(nJ);
    nh = randn(size(h))*std(h) + mean(h);
end
end

