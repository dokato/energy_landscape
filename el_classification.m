restoredefaultpath;
addpath('/home/c1745595/matlab/ELAT')

%clear all
band = 'low_gamma';
network = 'dmnlr';

casename = [band '_' network];
load('etotal-orig.mat')
%% With minima

Econ = etotal.con.(casename);
Epat = etotal.pat.(casename);

% here I concatenate both groups and compute energy values
% on mean from all subjects
Eall = [Econ; Epat];

% I concatenate groups again and label them
X = Eall; % whole data set
Y = ones(size(X,1),1);
Y(size(X,1)/2+1:end) = 2; % controls - 1, patients - 2

% leave 1 out
% racc = zeros(length(Y),1);
% for ii=1:length(Y)
%    indxs = 1:length(Y);
%    indxs(ii) = [];
%    X_tr = X(indxs,:);
%    Y_tr = Y(indxs);
%    X_tst = X(ii,:);
%    Y_tst = Y(ii);
%    [ec_tr, locmin_tr] = elat_main_hj([],[], mean(X_tr,1), [], 0);
%    close all;
%    X_tr  = X_tr(:,locmin_tr(2:end-1)) - X_tr(:,1);
%    X_tst = X_tst(:,locmin_tr(2:end-1)) - X_tst(:,1);
%    Mdl = fitcsvm(X_tr,Y_tr, 'Standardize',true,...
%                  'KernelFunction','RBF',...
%                  'KernelScale','auto');
%    Y_pred = predict(Mdl,X_tst);
%    racc(ii) = Y_pred==Y_tst;
% end
% 
% accuracy = sum(racc)/length(racc)

%%
disp('started shuffling procedure')
N = 500;
randaccuracy = zeros(N,1);
for n=1:N
    addpath(genpath('/home/c1745595/matlab/ELAT'));
    Ytmp = Y(randperm(length(Y)));
    racc = zeros(length(Y),1);
    for ii=1:length(Y)
       indxs = 1:length(Y);
       indxs(ii) = [];
       X_tr = X(indxs,:);
       Y_tr = Ytmp(indxs);
       X_tst = X(ii,:);
       Y_tst = Ytmp(ii);
       [ec_tr, locmin_tr] = elat_main_hj([],[], mean(X_tr,1), [], 0);
       close all;
       X_tr  = X_tr(:,locmin_tr(2:end-1)) - X_tr(:,1);
       X_tst = X_tst(:,locmin_tr(2:end-1)) - X_tst(:,1);
       Mdl = fitcsvm(X_tr,Y_tr, 'Standardize',true,...
                     'KernelFunction','RBF',...
                     'KernelScale','auto');
       Y_pred = predict(Mdl,X_tst);
       racc(ii) = Y_pred==Y_tst;
    end
    randaccuracy(n) = sum(racc)/length(racc);
end

eval([casename '=randaccuracy;'])
save(['randaccuracy' casename '2.mat'],casename)

%% PCA approach
% Econ = etotal.con.(casename);
% Epat = etotal.pat.(casename); 
% 
% X = [Econ; Epat]; % whole data set
% 
% Y = ones(size(X,1),1);
% Y(size(X,1)/2+1:end) = 2; % controls - 1, patients - 2
% 
% Npca = 20;
% 
% racc = zeros(length(Y),1);
% for ii=1:length(Y)
%    indxs = 1:length(Y);
%    indxs(ii) = [];
%    X_tr = X(indxs,:);
%    Y_tr = Y(indxs);
%    X_tst = X(ii,:);
%    Y_tst = Y(ii);
%    [pcaCoeff, XpcaTrans, ~, ~, norm_pcaExp] = pca(X_tr, ...
%        'Centered',false);
% 
%    Mdl = fitcsvm(XpcaTrans(:,1:Npca),Y_tr, 'Standardize',true,...
%                  'KernelFunction','RBF',...
%                  'KernelScale','auto');
%    Y_pred = predict(Mdl,X_tst * pcaCoeff(:,1:Npca));
%    racc(ii) = Y_pred==Y_tst;
% end
% 
% accuracy = sum(racc)/length(racc)
