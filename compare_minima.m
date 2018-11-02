band = 'theta';
network = 'dmnlr';

% SIGNIFICANT: beta fpn (0.0153), low_gamma fpn (0.0215)

casename = [band '_' network];

load('etotal.mat')
vec_locmin_pat = [];
minims_pat = [];
evaloffs_pat = [];
for i=1:size(etotal.pat.(casename),1)
    [ec_pat, locmin_pat] = elat_main_hj([],[], ...
        squeeze(etotal.pat.(casename)(i,:)));
    close all;
    vec_locmin_pat = [vec_locmin_pat length(locmin_pat)];
    [i,m]=min(ec_pat);
    minims_pat = [minims_pat m];
    evaloffs_pat = [evaloffs_pat ec_pat(1)];
end

vec_locmin_con = [];
minims_con = [];
evaloffs_con = [];
for i=1:size(etotal.pat.(casename),1)
    [ec_con, locmin_con] = elat_main_hj([],[], ...
        squeeze(etotal.con.(casename)(i,:)));
    close all;
    vec_locmin_con = [vec_locmin_con length(locmin_con)];
    [i,m]=min(ec_con);
    minims_con = [minims_con m];
    evaloffs_con = [evaloffs_con ec_con(1)];
end

hold on
histogram(vec_locmin_con, 'FaceColor', 'g')
histogram(vec_locmin_pat, 'FaceColor', 'r')
legend
hold off

[p,h] = ranksum(vec_locmin_con, vec_locmin_pat)

