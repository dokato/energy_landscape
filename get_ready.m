% prepare data for ELAP software

% x-fpn029 x-dmn029 pc-dmn029
fname = 'pc-dmn029';
fs = 250; % sampling freq

filename = ['data/' fname '.mat'];
matx = load(filename);
fn = fieldnames(matx);
matx = matx.(fn{1})';
if size(matx,1) > size(matx,2)
   matx = matx';
end
demeaned = zscore(matx')';

%pairwise = make_pairwise_corr(demeaned);
%avgcorr  = make_corr_to_avg(demeaned);
envdata_alpha = make_envelope(demeaned, [8 13], fs);
envdata_beta_1 = make_envelope(demeaned, [18 22], fs);
envdata_beta_2 = make_envelope(demeaned, [22 26], fs);
envdata_beta_3 = make_envelope(demeaned, [26 30], fs);
envdata_beta = (envdata_beta_1 + envdata_beta_2 + envdata_beta_3)./3;
clear envdata_beta_1 envdata_beta_2 envdata_beta_3
envdata_gamma_1 = make_envelope(demeaned, [30 35], fs);
envdata_gamma_2 = make_envelope(demeaned, [35 40], fs);
envdata_gamma_3 = make_envelope(demeaned, [40 45], fs);
envdata_gamma = (envdata_gamma_1 + envdata_gamma_2 + envdata_gamma_3)./3;
clear envdata_gamma_1 envdata_gamma_2 envdata_gamma_3

% uncomment when matrix is too big
%demeaned = demeaned(:,1:250*60*3);

%avgcorr2 = avgcorr.^2;
%avgcorr2 = zscore(avgcorr2')';
%save('data/elatinput.mat', 'pairwise')
%save('data/elatinput.mat', 'avgcorr2')

save('data/elatinput.mat', 'envdata_alpha')
Param.InputFile='data/elatinput.mat';
Param.fRoi=1;
Param.RoiFile=['data/' fname 'labels.dat'];
Param.OutputFolder='out/';
Param.DataType=1;
Param.fSaveBasinList=0;
Param.Threshold=0;
main(Param)

pause;

save('data/elatinput.mat', 'envdata_beta')
Param.InputFile='data/elatinput.mat';
Param.fRoi=1;
Param.RoiFile=['data/' fname 'labels.dat'];
Param.OutputFolder='out/';
Param.DataType=1;
Param.fSaveBasinList=0;
Param.Threshold=0;
main(Param)

pause;

save('data/elatinput.mat', 'envdata_gamma')
Param.InputFile='data/elatinput.mat';
Param.fRoi=1;
Param.RoiFile=['data/' fname 'labels.dat'];
Param.OutputFolder='out/';
Param.DataType=1;
Param.fSaveBasinList=0;
Param.Threshold=0;
main(Param)
