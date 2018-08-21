band = 'alpha';
network = 'fpn';

casename = [band '_' network];

disp('Patients')
[ec_pat, locmin_pat] = elat_main_hj([],[], mean(etotal.pat.(casename),1));
close all;
disp('Controls')
[ec_con, locmin_con] = elat_main_hj([],[], mean(etotal.con.(casename),1));
close all;

norm_ec_pat = (ec_pat - min(ec_pat)) / (max(ec_pat) - min(ec_pat));
norm_ec_con = (ec_con - min(ec_con)) / (max(ec_con) - min(ec_con));

if length(locmin_con) > length(locmin_pat)
    different_mins = setdiff(locmin_con, locmin_pat);
    for dm = different_mins'
        dmvals_norm = (etotal.pat.(casename)(:,dm)- min(ec_pat)) / (max(ec_pat) - min(ec_pat));
        hax=axes;
        hist(dmvals_norm, 10);
        line([norm_ec_con(dm) norm_ec_con(dm)],get(hax,'YLim'),'Color','r')
        pause;
    end
elseif length(locmin_con) < length(locmin_pat)
    different_mins = setdiff(locmin_pat, locmin_con);
    for dm = different_mins'
        dmvals_norm = (etotal.pat.(casename)(:,dm)- min(ec_pat)) / (max(ec_pat) - min(ec_pat));
        hax=axes;
        hist(dmvals_norm, 10);
        line([norm_ec_pat(dm) norm_ec_pat(dm)],get(hax,'YLim'),'Color','r')
        pause;
    end
else
    disp('No differences in minima between P & C.')
end