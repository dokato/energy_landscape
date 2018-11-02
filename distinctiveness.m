band = 'alpha';
network = 'smn';

casename = [band '_' network];
load('etotal.mat')
disp('Patients')
[ec_pat, locmin_pat, basin_pat] = elat_main_hj([],[], mean(etotal.pat.(casename),1));
close all;
disp('Controls')
[ec_con, locmin_con, basin_con] = elat_main_hj([],[], mean(etotal.con.(casename),1));
close all;

if length(locmin_con) > length(locmin_pat)
    different_mins = setdiff(locmin_con, locmin_pat);
    aset = etotal.con.(casename);
    bset = etotal.pat.(casename);
    basinMat = basin_con;
    basinMat_x = basin_pat;
elseif length(locmin_con) < length(locmin_pat)
    different_mins = setdiff(locmin_pat, locmin_con);
    aset = etotal.pat.(casename);
    bset = etotal.con.(casename);
    basinMat = basin_pat;
    basinMat_x = basin_con;
else
    disp('No differences in minima between P & C.')
end

for dm = different_mins'
    vecDist = [];
    for us=1:size(aset,1)
        vecDist = [vecDist compDistintiv(dm,aset(us,:), basinMat)];
    end
    dm
    meanDistinctivity = mean(vecDist);
    meanDistinctivity
end

% for dm = different_mins'
%     vecDist = [];
%     for us=1:size(bset,1)
%         vecDist = [vecDist compDistintiv(dm,bset(us,:),basinMat_x)];
%     end
%     dm
%     meanDistinctivity = mean(vecDist);
%     meanDistinctivity
% end
