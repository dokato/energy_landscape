band = 'beta';
network = 'dmnlr';

load('etotal-orig')
casename = [band '_' network];

disp('Patients')
[ec_pat, locmin_pat] = elat_main_hj([],[], mean(etotal.pat.(casename),1));
close all;
disp('Controls')
[ec_con, locmin_con] = elat_main_hj([],[], mean(etotal.con.(casename),1));
close all;

norm_ec_pat = ec_pat - min(ec_pat);
norm_ec_con = ec_con - min(ec_con);

% if length(locmin_con) > length(locmin_pat)
%     different_mins = setdiff(locmin_con, locmin_pat);
%     aset = etotal.con.(casename);
%     bset = etotal.pat.(casename);
% elseif length(locmin_con) < length(locmin_pat)
%     different_mins = setdiff(locmin_pat, locmin_con);
%     aset = etotal.pat.(casename);
%     bset = etotal.con.(casename);
% else
%     disp('No differences in minima between P & C.')
% end

aset = etotal.con.(casename);
bset = etotal.pat.(casename);
different_mins = unique([locmin_con;locmin_pat]);

alphasidak = @(alpha, m) 1 - (1 - alpha).^(1/m);

all_pvals = [];
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
    figure;
    hold on;
    bar(1:2,[mean(vec_aset_norm), mean(vec_bset_norm)])
    errorbar(1:2,[mean(vec_aset_norm), mean(vec_bset_norm)], [std(vec_aset_norm), std(vec_bset_norm)], '.')
    hold off

    [pnor,hnor] = ranksum(vec_aset_norm, vec_bset_norm)
    all_pvals = [all_pvals pnor];
    [p,h] = ranksum(vec_aset_norm, vec_bset_norm, 'alpha',alphasidak(0.05,length(different_mins)))
    %line([norm_ec_pat(dm) norm_ec_pat(dm)],get(hax,'YLim'),'Color','r')
    %pause;
end

%pvals = [0.0250 0.0013 0.6940 0.1727 6.0031e-04 0.0016 0.0044 0.5767 0.1265 0.0871 0.0096 0.1093 0.0940 4.0087e-09 8.6461e-08 7.3506e-10 4.0087e-09 8.6461e-08 8.6461e-08 0.5520 0.0686];
%fdr_bh(pvals)

disp('-------')
ii = 0;
for p = all_pvals
    ii = ii + 1;
    dm = different_mins';
    disp([num2str(dm(ii)) ' - ' num2str(p)])
end