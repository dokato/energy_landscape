% ELAT run on all subjects
clear all

%run ../../matlab/osl/osl-core/osl_startup.m

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
datafolder = 'cmdata/';
input_elat = 'envdata_alpha';
prefix = 'alpha-fpn';
save_fig = 1;
FigFolderName = 'cmfigs/sloreta/';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subj = {'021'  '027'  '029'  '030'  '031'  '036'  '037'  '040'  ...
    '041'  '042'  '043'  '044'  '047'  '049'  '050'};

rrall = [];
for s = subj
   fname = [prefix s{1}];
   get_ready;
   rrall = [rrall; rr];
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

if save_fig
   FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
   for iFig = 1:length(FigList)
     FigHandle = FigList(iFig);
     FigName   = get(FigHandle, 'Name');
     savefig(FigHandle, fullfile(FigFolderName, [prefix '_' num2str(iFig) '.fig']));
     print(FigHandle, fullfile(FigFolderName, [prefix '_' num2str(iFig)]) ,'-dpng')
   end
end

disp('Mean model fitting score:')
mean(rrall)
sqrt(std(rrall)/length(rrall))

%[st,basst] = metrophastings(1000000, Eavg, BasinGraph);
%basst = basst(round(5*length(basst)/6):end);
%switchIndex(basst)
%plotTemporalSwitches(basst, 250);
