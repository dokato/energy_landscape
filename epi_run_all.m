% ELAT run on all subjects
%clear all

%run ../../matlab/osl/osl-core/osl_startup.m

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input_elat = 'envdata_theta';
prefix = 'theta-fpn';
datafolder = 'epidata2/networksP/';
RoiNameFile = 'rois-fpn2.dat';
FigFolderName = 'epifigs2/Pat';
save_fig = 1;
condition = 'pat';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%contrsubjects = {'011012-50' '050412-3' '090811-1' '091210-2' '120309-1' ...
%    '121010-2' '130213-1' '150413-50' '160212-50' '171012-50' '180413-1' ...
%    '191212-52' '201011-3' '230511-1' '240513-51' '240912-50' '250413-50' ...
%    '251012-50' '251012-99' '260213-50' '260313-50' '270511-1' '280213-3' ...
%    '290812-50' '300413-2' '300610-2'};

%episubjects = {'020609-2' '021211-50' '040711-1' '051109-1' '051109-4' ...
%    '061210-50' '070211-50' '070709-1' '081111-50' '091109-2' '110110-4' ...
%    '110411-1' '110711-50' '120911-50' '130611-50' '130709-2' '131211-50' ...
%    '150811-50' '151110-1' '171011-50' '201211-50' '241011-50' '280211-51'};

subjects = {};
for i=1:26
    subjects = [subjects num2str(i)];
end

subj = subjects;%eval(condition);

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

elat_main_hj([],[], Eavg, RoiNameFile);

load('etotal')
etotal.(condition).(strrep(prefix,'-','_')) = Ef;
save('etotal','etotal')

%% Save Figures

if save_fig
   FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
   for iFig = 1:length(FigList)
     FigHandle = FigList(iFig);
     FigName   = get(FigHandle, 'Name');
     savefig(FigHandle, fullfile(FigFolderName, [prefix '_' condition num2str(iFig) '.fig']));
     print(FigHandle, fullfile(FigFolderName, [prefix '_' condition num2str(iFig)]) ,'-dpng')
   end
end
