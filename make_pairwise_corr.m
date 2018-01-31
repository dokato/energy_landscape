function [ndata] = make_pairwise_corr(data, timewin)
%MAKE_PAIRWISE_CORR 
% data - data in format ROIs x timesteps
% timewin - time window to correlation
if nargin < 2
    timewin = 100;
end
[n, m] = size(data);
if n > m
   error('Make sure data is in format ROIs x timesteps'); 
end

corrwin = zeros(round(m - timewin), round(n*(n-1)/2));
idcs = sort(unique(tril(reshape(1:n*n, n, n), -1)));
idcs = idcs(2:end);
for i=1:length(corrwin)
    tempp = corr(data(:,i:i+timewin)');
    corrwin(i,:)=tempp(idcs);
end

ndata = corrwin';
end

