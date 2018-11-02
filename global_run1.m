% GLOBAL RUN OF ELAT
% The best strategy is to run it from cmd-line:
% matlab2017 -nodisplay -nosplash -nodesktop -r "run('global_run1.m');"

restoredefaultpath;
addpath('/home/c1745595/matlab/ELAT')

% --------------------------------------------SMN Control
input_elat = 'envdata_alpha';
prefix = 'alpha-smn';
datafolder = 'epidata2/networksC/';
RoiNameFile = 'rois-smn2.dat';
FigFolderName = 'epifigs2/Con';
save_fig = 1;
condition = 'con';

epi_run_all
%resampl_el_stats

clear all;
input_elat = 'envdata_beta';
prefix = 'beta-smn';
datafolder = 'epidata2/networksC/';
RoiNameFile = 'rois-smn2.dat';
FigFolderName = 'epifigs2/Con';
save_fig = 1;
condition = 'con';

epi_run_all
%resampl_el_stats

clear all
input_elat = 'envdata_gamma';
prefix = 'low-gamma-smn';
datafolder = 'epidata2/networksC/';
RoiNameFile = 'rois-smn2.dat';
FigFolderName = 'epifigs2/Con';
save_fig = 1;
condition = 'con';

epi_run_all
%resampl_el_stats

% --------------------------------------------SMN Patients
clear all;
input_elat = 'envdata_alpha';
prefix = 'alpha-smn';
datafolder = 'epidata2/networksP/';
RoiNameFile = 'rois-smn2.dat';
FigFolderName = 'epifigs2/Pat';
save_fig = 1;
condition = 'pat';

epi_run_all
%resampl_el_stats

clear all
input_elat = 'envdata_beta';
prefix = 'beta-smn';
datafolder = 'epidata2/networksP/';
RoiNameFile = 'rois-smn2.dat';
FigFolderName = 'epifigs2/Pat';
save_fig = 1;
condition = 'pat';

epi_run_all
%resampl_el_stats

clear all
input_elat = 'envdata_gamma';
prefix = 'low-gamma-smn';
datafolder = 'epidata2/networksP/';
RoiNameFile = 'rois-smn2.dat';
FigFolderName = 'epifigs2/Pat';
save_fig = 1;
condition = 'pat';

epi_run_all
%resampl_el_stats

% --------------------------------------------FPN Control
clear all
input_elat = 'envdata_alpha';
prefix = 'alpha-fpn';
datafolder = 'epidata2/networksC/';
RoiNameFile = 'rois-fpn2.dat';
FigFolderName = 'epifigs2/Con';
save_fig = 1;
condition = 'con';

epi_run_all
%resampl_el_stats

clear all;
input_elat = 'envdata_beta';
prefix = 'beta-fpn';
datafolder = 'epidata2/networksC/';
RoiNameFile = 'rois-fpn2.dat';
FigFolderName = 'epifigs2/Con/';
save_fig = 1;
condition = 'con';

epi_run_all
%resampl_el_stats

clear all;
input_elat = 'envdata_gamma';
prefix = 'low-gamma-fpn';
datafolder = 'epidata2/networksC/';
RoiNameFile = 'rois-fpn2.dat';
FigFolderName = 'epifigs2/Con/';
save_fig = 1;
condition = 'con';

epi_run_all
%resampl_el_stats

% --------------------------------------------FPN Patients
clear all;
input_elat = 'envdata_alpha';
prefix = 'alpha-fpn';
datafolder = 'epidata2/networksP/';
RoiNameFile = 'rois-fpn2.dat';
FigFolderName = 'epifigs2/Pat/';
save_fig = 1;
condition = 'pat';

epi_run_all
%resampl_el_stats

input_elat = 'envdata_beta';
prefix = 'beta-fpn';
datafolder = 'epidata2/networksP/';
RoiNameFile = 'rois-fpn2.dat';
FigFolderName = 'epifigs2/Pat/';
save_fig = 1;
condition = 'pat';

epi_run_all
%resampl_el_stats

input_elat = 'envdata_gamma';
prefix = 'low-gamma-fpn';
datafolder = 'epidata2/networksP/';
RoiNameFile = 'rois-fpn2.dat';
FigFolderName = 'epifigs2/Pat/';
save_fig = 1;
condition = 'pat';

epi_run_all
%resampl_el_stats
