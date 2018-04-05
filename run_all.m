% ELAT run on all subjects
clear all

%run ../../matlab/osl/osl-core/osl_startup.m

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input_elat = 'envdata_beta';
prefix = 'beta-dmnlr';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subj = {'021'  '027'  '029'  '030'  '031'  '036'  '037'  '040'  ...
    '041'  '042'  '043'  '044'  '047'  '049'  '050'};

%rrall = [];
for s = subj
   fname = [prefix s{1}];
   get_ready;
   %rrall = [rrall; rr];
   close all;
end

Ef = [];
locmims = [];
for s = subj
   load(['out/' prefix s{1} '/Energy.mat'])
   Ef = [Ef; E'];
   locmims = [locmims length(LocalMinIndex)];
end
Eavg = mean(Ef,1);


elat_main_hj([],[], Eavg);
