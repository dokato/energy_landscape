% DMN:
dmn_labels= {
'Precuneus_L'
'Precuneus_R'
'Cingulum_Ant_L'
'Cingulum_Ant_R'
'Cingulum_Post_L'
'Cingulum_Post_R'
'Parietal_Inf_L'
'Parietal_Inf_R'
'Frontal_Med_Orb_L'
'Frontal_Med_Orb_R'
};

% FPN:
fpn_labels= {
'Frontal_Inf_Tri_L'
'Frontal_Inf_Tri_R'
'Frontal_Mid_L'
'Frontal_Mid_R'
'Parietal_Inf_L'
'Parietal_Inf_R'
'Parietal_Sup_L'
'Parietal_Sup_R'
'Angular_L'
'Angular_R'
};

% SMN
smn_labels = {
'Precentral_L'
'Precentral_R'
'Postcentral_L'
'Postcentral_R'
'Supp_Motor_Area_L'
'Supp_Motor_Area_R'
};

%VN
vn_labels = {
'Occipital_Sup_L'
'Occipital_Sup_R'
'Occipital_Mid_L'
'Occipital_Mid_R'
'Occipital_Inf_L'
'Occipital_Inf_R'
'Calcarine_L'
'Calcarine_R'
'Lingual_L'
'Lingual_R'
};

%AN
an_labels = {
'Temporal_Sup_L'
'Temporal_Sup_R'
'Heschl_L'
'Heschl_R'
'Postcentral_L'
'Postcentral_R'
};

%FN
fn_labels = {
'Frontal_Sup_L'
'Frontal_Sup_R'
'Frontal_Sup_Orb_L'
'Frontal_Sup_Orb_R'
'Frontal_Mid_L'
'Frontal_Mid_R'
'Frontal_Mid_Orb_L'
'Frontal_Mid_Orb_R'
'Frontal_Inf_Oper_L'
'Frontal_Inf_Oper_R'
'Frontal_Inf_Tri_L'
'Frontal_Inf_Tri_R'
'Frontal_Inf_Orb_L'
'Frontal_Inf_Orb_R'
};

fpn_activations= {
'Frontal_Inf_Tri_R'
'Frontal_Mid_R'
'Parietal_Inf_L'
'Parietal_Inf_R'
'Parietal_Sup_L'
'Parietal_Sup_R'
'Angular_L'
'Angular_R'
};

dmn_activations= {
'Precuneus_L'
'Precuneus_R'
'Cingulum_Ant_L'
'Cingulum_Ant_R'
'Cingulum_Post_L'
'Cingulum_Post_R'
'Parietal_Inf_L'
'Parietal_Inf_R'
'Frontal_Med_Orb_L'
'Frontal_Med_Orb_R'
};

plot_3d_activations(fpn_labels, fpn_activations)


% temp ---------------------------------
netlabels= {
'Precentral_L'
'Precentral_R'
};

network_values = [-3, 3];
vals = zeros(length(AAL_Labels),1)*nan;
for j = 1: length(netlabels)
    IndexC = strfind(AAL_Labels, netlabels{j});
    Index = find(not(cellfun('isempty', IndexC)));
    vals(Index) = network_values(j);
end