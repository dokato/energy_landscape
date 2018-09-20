band = 'beta';
network = 'dmnlr';

casename = [band '_' network];

disp('Patients')
[ec_pat, locmin_pat] = elat_main_hj([],[], mean(etotal.pat.(casename),1));
close all;
disp('Controls')
[ec_con, locmin_con] = elat_main_hj([],[], mean(etotal.con.(casename),1));
close all;

norm_ec_pat = ec_pat - min(ec_pat);
norm_ec_con = ec_con - min(ec_con);

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

alphasidak = @(alpha, m) 1 - (1 - alpha).^(1/m);

for dm = different_mins'
    vec_aset_norm = [];
    for us=1:size(aset,1)
        aset_norm = aset(us, dm) - min(aset(us,:));
        vec_aset_norm = [vec_aset_norm aset_norm];
    end
    vec_bset_norm = [];
    for us=1:size(bset,1)
        bset_norm = bset(us, dm) - min(bset(us,:));
        vec_bset_norm = [vec_bset_norm bset_norm];
    end
    
    hold on
    histogram(vec_aset_norm, 'FaceColor', 'g')
    histogram(vec_bset_norm, 'FaceColor', 'r')
    legend
    title(num2str(dm))
    hold off
    [pnor,hnor] = ranksum(vec_aset_norm, vec_bset_norm)
    [p,h] = ranksum(vec_aset_norm, vec_bset_norm, 'alpha',alphasidak(0.05,14))
    %line([norm_ec_pat(dm) norm_ec_pat(dm)],get(hax,'YLim'),'Color','r')
    pause;
end
