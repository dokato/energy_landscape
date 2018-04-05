function [bestThr, racc] = bestThreshold(data_to_binarize)
%UNTITLED2 Summary of this function goes here
%   data_to_binarize - unbinarized data

thrvec = linspace(-0.7,0.7, 23);
racc = zeros(size(thrvec));

for i = 1:length(thrvec)
    binarizedData = pfunc_01_Binarizer(data_to_binarize,thrvec(i));
    [h,J] = pfunc_02_Inferrer_ML(binarizedData);
    %%[h,J] = pfunc_02_Inferrer_PL(binarizedData);
    [probN, prob1, prob2, rD, r] = pfunc_03_Accuracy(h, J, binarizedData);
    racc(i) = r;
end
[m,i] = max(racc);
bestThr = thrvec(i);
%plot(thrvec, racc)
end

