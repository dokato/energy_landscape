function [ndata] = make_envelope(data, freq, fs)
%MAKE_ENVELOPE using hilbert transform
% data - data in format ROIs x timesteps
% freq - two element vector with frequencies to Hilbert transform
% fs - sampling freq

if nargin < 2
    freq = [8,12];
end
if nargin < 3
    error('Specify fs!');
end

[N, M] = size(data);
if  N > M
   error('Make sure data is in format ROIs x timesteps'); 
end

fn = fs/2;
Rp = 1; Rs = 10;
[n, Wn] = buttord(freq/fn, [freq(1)*0.9 freq(2)/0.9]/fn, Rp, Rs);
[b, a] = butter(n, Wn);
[sos, g] = tf2sos(b, a);  %freqz(sos, 2^16, fs)
hndata = zeros(size(data));
for k = 1:N
    hndata(k,:) = abs(hilbert(filtfilt(sos, g, data(k,:))));
end

ndata = zscore(hndata')';
% two seconds out of the data to get rid of filtering edge effects
ndata = ndata(:,fs:end-fs);
end

