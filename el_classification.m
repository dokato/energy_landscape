clear all

band = 'alpha';
network = 'fpn';

casename = [band '_' network];
load('etotal.mat')
%% With minima

Econ = etotal.con.(casename);
Epat = etotal.pat.(casename);

% here I concatenate both groups and compute energy values
% on mean from all subjects
Eall = [Econ; Epat];

[ec_all, locmin_all] = elat_main_hj([],[], mean(Eall,1));
close all;
% here I select all local minima separately from groups
econ_sub = Econ(:,locmin_all);
epat_sub = Epat(:,locmin_all);

% I concatenate groups again and label them
X = [econ_sub; epat_sub]; % whole data set
Y = ones(size(X,1),1);
Y(size(X,1)/2+1:end) = 2; % controls - 1, patients - 2

% leave 1 out
racc = zeros(length(Y),1);
for ii=1:length(Y)
   indxs = 1:length(Y);
   indxs(ii) = [];
   X_tr = X(indxs,:);
   Y_tr = Y(indxs);
   X_tst = X(ii,:);
   Y_tst = Y(ii);
   Mdl = fitcsvm(X_tr,Y_tr, 'Standardize',true,...
                 'KernelFunction','RBF',...
                 'KernelScale','auto');
   Y_pred = predict(Mdl,X_tst);
   racc(ii) = Y_pred==Y_tst;
end

accuracy = sum(racc)/length(racc)


%% PCA approach
Econ = etotal.con.(casename);
Epat = etotal.pat.(casename); 

X = [Econ; Epat]; % whole data set

Y = ones(size(X,1),1);
Y(size(X,1)/2+1:end) = 2; % controls - 1, patients - 2

Npca = 20;

racc = zeros(length(Y),1);
for ii=1:length(Y)
   indxs = 1:length(Y);
   indxs(ii) = [];
   X_tr = X(indxs,:);
   Y_tr = Y(indxs);
   X_tst = X(ii,:);
   Y_tst = Y(ii);
   [pcaCoeff, XpcaTrans, ~, ~, norm_pcaExp] = pca(X_tr, ...
       'Centered',false);

   Mdl = fitcsvm(XpcaTrans(:,1:Npca),Y_tr, 'Standardize',true,...
                 'KernelFunction','RBF',...
                 'KernelScale','auto');
   Y_pred = predict(Mdl,X_tst * pcaCoeff(:,1:Npca));
   racc(ii) = Y_pred==Y_tst;
end

accuracy = sum(racc)/length(racc)