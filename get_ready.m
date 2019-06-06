% Prepare data for ELAP software
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x-fpn029 x-dmn029 pc-dmn029
%'021'  '027'  '029'  '030'  '031'  '036'  '037'  '040'  
%'041'  '042'  '043'  '044'  '047'  '049'  '050'
%fname = 'alpha-dmnlr027';
%input_elat = 'envdata_alpha';
%datafolder = 'data/';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fs = 250; % sampling freq

filename = [datafolder fname '.mat'];
matx = load(filename);
fn = fieldnames(matx);
matx = matx.(fn{1})';
if size(matx,1) > size(matx,2)
   matx = matx';
end
demeaned = zscore(matx')';

envdata_theta = make_envelope(demeaned, [4 7], fs, 1);
envdata_alpha = make_envelope(demeaned, [8 13], fs, 1);
envdata_beta_1 = make_envelope(demeaned, [18 22], fs, 1);
envdata_beta_2 = make_envelope(demeaned, [22 26], fs, 1);
envdata_beta_3 = make_envelope(demeaned, [26 30], fs, 1);
envdata_beta = (envdata_beta_1 + envdata_beta_2 + envdata_beta_3)./3;
clear envdata_beta_1 envdata_beta_2 envdata_beta_3
envdata_gamma_1 = make_envelope(demeaned, [30 35], fs, 1);
envdata_gamma_2 = make_envelope(demeaned, [35 40], fs, 1);
envdata_gamma_3 = make_envelope(demeaned, [40 45], fs, 1);
envdata_gamma = (envdata_gamma_1 + envdata_gamma_2 + envdata_gamma_3)./3;
clear envdata_gamma_1 envdata_gamma_2 envdata_gamma_3
time_limit = 40000;

envdata_theta = envdata_theta(:,1:time_limit);
envdata_alpha = envdata_alpha(:,1:time_limit);
envdata_beta = envdata_beta(:,1:time_limit);
envdata_gamma = envdata_gamma(:,1:time_limit);

save('data/elatinput.mat', input_elat)
Param.InputFile='data/elatinput.mat';
Param.fRoi=1;
Param.RoiFile=[datafolder fname 'labels.dat'];
out_folder = ['out/' fname condition '/'];
mkdir(out_folder)
Param.OutputFolder= out_folder;
Param.DataType=1;
Param.fSaveBasinList=0;
% [bestThr, rr] = bestThreshold(eval(input_elat));
Param.Threshold = 0;
main(Param)

%disp('BEST THRESHOLD')
%bestThr
