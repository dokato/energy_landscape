band = 'beta';
network = 'dmnlr';

casename = [band '_' network];
load('etotal.mat')
disp('Patients')
[ec_pat, locmin_pat] = elat_main_hj([],[], mean(etotal.pat.(casename),1));
close all;
disp('Controls')
[ec_con, locmin_con] = elat_main_hj([],[], mean(etotal.con.(casename),1));
close all;

if length(locmin_con) > length(locmin_pat)
    different_mins = setdiff(locmin_con, locmin_pat);
    aset = etotal.con.(casename);
    bset = etotal.pat.(casename);
elseif length(locmin_con) < length(locmin_pat)
    different_mins = setdiff(locmin_pat, locmin_con);
    aset = etotal.pat.(casename);
    bset = etotal.con.(casename);
else
    disp('No differences in minima between P & C.')
end

% for dm = different_mins'
%     vecDist = [];
%     for us=1:size(aset,1)
%         vecDist = [vecDist compDistintiv(dm,aset(us,:))];
%     end
%     dm
%     meanDistinctivity = mean(vecDist);
%     meanDistinctivity
% end

for dm = different_mins'
    vecDist = [];
    for us=1:size(bset,1)
        vecDist = [vecDist compDistintiv(dm,bset(us,:))];
    end
    dm
    meanDistinctivity = mean(vecDist);
    meanDistinctivity
end
