function [ndata] = make_corr_to_avg(data, timewin)
%MAKE_CORR_TO_AVG
% data - data in format ROIs x timesteps
% timewin - time window to correlation

if nargin < 2
    timewin = 100;
end
[n, m] = size(data);
if n > m
   error('Make sure data is in format ROIs x timesteps'); 
end

corrwin = zeros(round(m - timewin), n);
datamean = mean(data,1);

for i=1:length(corrwin)
    for k=1:n
        corrwin(i,k) = corr(data(k,i:i+timewin)', datamean(i:i+timewin)') - 1/n;
    end
end
ndata = corrwin';
end

