%
% Data exploration and visualisation step
% - Let's start by examining some of the constraints used for B-SOSE
%

%% Initial setup

% clean up workspace
clear all
close all

%% Set paths and folders

% which file are we looking at?
fid = '../data_in_bsose/NODC_SO_2013_MRB.nc';
ftitle = 'NODC_SO_2013_MRB';
ploc = '../plots_bsose/NODC_SO_2013_MRB/';
ftitle(ftitle=='_')=' ';

% does the folder exist? if not, create it
if ~exist(ploc, 'dir')
   mkdir(ploc)
end

% output plots to files?
makePlots = 1;

% colormap
load('~/Documents/MATLAB/colormaps/cividis.txt')
cmp = cividis;

%% Examine contents of file; grab some variables

% display the contents
ncdisp(fid)

% grab variables --------

% coordinates
prof_descr = ncread(fid,"prof_descr");
prof_depth = ncread(fid,"prof_depth");
depth = ncread(fid,"prof_depth");
prof_date = ncread(fid,"prof_depth");
prof_YYYYMMDD = ncread(fid,"prof_YYYYMMDD");
prof_lon = ncread(fid,"prof_lon");
prof_lat = ncread(fid,"prof_lat");

% convert to datenum and datestr
prof_datenum=datenum(num2str(prof_YYYYMMDD),'yyyymmdd');
prof_datestr=datestr(prof_datenum);

% for 2D plots
tt = repmat(prof_datenum,[1 length(prof_depth)]); 
zz = repmat(prof_depth,[1 length(prof_datenum)]);
tt = tt';

% temperature
prof_T = ncread(fid,"prof_T");
prof_Tweight = ncread(fid,"prof_Tweight");  % least-square weight
prof_Testim = ncread(fid,"prof_Testim");    % estimate (e.g. from Atlas)
prof_Terr = ncread(fid,"prof_Terr");        % instrumental error
prof_Tflag = ncread(fid,"prof_Tflag");      % flag i>0 --> rejected

% replace missing value (-9999) with NaN
prof_T(prof_T==-9999) = NaN;
prof_Tweight(prof_Tweight==-9999) = NaN;
prof_Testim(prof_Testim==-9999) = NaN;
prof_Terr(prof_Terr==-9999) = NaN;
prof_Tflag(prof_Tflag==-9999) = NaN;

% salinity
prof_S = ncread(fid,"prof_S");
prof_Sweight = ncread(fid,"prof_Sweight");
prof_Sestim = ncread(fid,"prof_Sestim");
prof_Serr = ncread(fid,"prof_Serr");
prof_Sflag = ncread(fid,"prof_Sflag");

% replace missing value (-9999) with NaN
prof_S(prof_S==-9999) = NaN;
prof_Sweight(prof_Sweight==-9999) = NaN;
prof_Sestim(prof_Sestim==-9999) = NaN;
prof_Serr(prof_Serr==-9999) = NaN;
prof_Sflag(prof_Sflag==-9999) = NaN;

%% Make some plots
%- Sanity checking
%- To get a sense for how it works

%% Location of the profiles

% current SO-WISE domain lon:(-85, 30) lat:(-84.2, -30)
% figure position
figpos = [122 75 1095 704];

figure('color','w','position',figpos)
m_proj('lambert','long',[-85 30],'lat',[-85 -30]);
m_coast('patch',[1 .85 .7]);
m_line(prof_lon,prof_lat,'marker','+','color',[0.0 0.0 0.8],'linewi',2,...
          'linest','none','markersize',8,'markerfacecolor','w')
m_line(prof_lon-360,prof_lat,'marker','+','color',[0.0 0.0 0.8],'linewi',2,...
          'linest','none','markersize',8,'markerfacecolor','w')
m_grid('box','fancy','tickdir','in','xaxislocation','top');
title([ftitle ...
         ' | latitudes and longitudes of profiles | from ' ...
         num2str(prof_YYYYMMDD(1)) ...
         ' to ' ...
         num2str(prof_YYYYMMDD(end))]);
% make plot
if makePlots
   saveas(gcf,[ploc 'location_of_profiles'],'jpg'); 
end

%% Temperature

% measured value prof_T
figure('color','w','position',figpos)
pcolor(tt,zz,prof_T)
shading flat
colorbar
set(gca,'ydir','reverse');
datetick('x', 29, 'keepticks')
colormap(cmp)
ylabel('Depth [m]');
title([ftitle ' potential temperature (°C)']);
caxis([-2 30]);
% make plot
if makePlots
   saveas(gcf,[ploc 'prof_T'],'jpg'); 
end

% least-square weight
figure('color','w','position',figpos)
pcolor(tt,zz,prof_Tweight)
shading flat
colorbar
set(gca,'ydir','reverse');
datetick('x', 29, 'keepticks')
colormap(cmp)
ylabel('Depth [m]');
title([ftitle ' potential temperature least-square weight (degree C)^-2']);
% make plot
if makePlots
   saveas(gcf,[ploc 'prof_Tweight'],'jpg'); 
end

% estimate (from atlas)
figure('color','w','position',figpos)
pcolor(tt,zz,prof_Testim)
shading flat
colorbar
set(gca,'ydir','reverse');
datetick('x', 29, 'keepticks')
colormap(cmp)
ylabel('Depth [m]');
title([ftitle ' pot. temp. estimate (e.g. from atlas) (°C)']);
% make plot
if makePlots
   saveas(gcf,[ploc 'prof_Testim'],'jpg'); 
end

% instrumental error
figure('color','w','position',figpos)
pcolor(tt,zz,prof_Terr)
shading flat
colorbar
set(gca,'ydir','reverse');
datetick('x', 29, 'keepticks')
colormap(cmp)
ylabel('Depth [m]');
title([ftitle ' pot. temp. instrumental error (°C)']);
% make plot
if makePlots
   saveas(gcf,[ploc 'prof_Terr'],'jpg'); 
end

% flag
figure('color','w','position',figpos)
pcolor(tt,zz,prof_Tflag)
shading flat
colorbar
set(gca,'ydir','reverse');
datetick('x', 29, 'keepticks')
colormap(cmp)
ylabel('Depth [m]');
title([ftitle ' pot. temp. flag (i>0 means rejected)']);
% make plot
if makePlots
   saveas(gcf,[ploc 'prof_Tflag'],'jpg'); 
end

%% Salinity

% measured value 
figure('color','w','position',figpos)
pcolor(tt,zz,prof_S)
shading flat
colorbar
set(gca,'ydir','reverse');
datetick('x', 29, 'keepticks')
colormap(cmp)
ylabel('Depth [m]');
title([ftitle ' salinity (psu)']);
% make plot
if makePlots
   saveas(gcf,[ploc 'prof_S'],'jpg');  %#ok<*UNRCH>
end

% least-square weight
figure('color','w','position',figpos)
pcolor(tt,zz,prof_Sweight)
shading flat
colorbar
set(gca,'ydir','reverse');
datetick('x', 29, 'keepticks')
colormap(cmp)
ylabel('Depth [m]');
title([ftitle ' salinity least-square weight (psu)^-2']);
% make plot
if makePlots
   saveas(gcf,[ploc 'prof_Sweight'],'jpg'); 
end

% estimate (from atlas)
figure('color','w','position',figpos)
pcolor(tt,zz,prof_Sestim)
shading flat
colorbar
set(gca,'ydir','reverse');
datetick('x', 29, 'keepticks')
colormap(cmp)
ylabel('Depth [m]');
title([ftitle ' salinity estimate (e.g. from atlas) (psu)']);
% make plot
if makePlots
   saveas(gcf,[ploc 'prof_Sestim'],'jpg'); 
end

% instrumental error
figure('color','w','position',figpos)
pcolor(tt,zz,prof_Serr)
shading flat
colorbar
set(gca,'ydir','reverse');
datetick('x', 29, 'keepticks')
colormap(cmp)
ylabel('Depth [m]');
title([ftitle ' salinity instrumental error (psu)']);
% make plot
if makePlots
   saveas(gcf,[ploc 'prof_Serr'],'jpg'); 
end

% flag
figure('color','w','position',figpos)
pcolor(tt,zz,prof_Sflag)
shading flat
colorbar
set(gca,'ydir','reverse');
datetick('x', 29, 'keepticks')
colormap(cmp)
ylabel('Depth [m]');
title([ftitle ' salinity flag (i>0 means rejected)']);
% make plot
if makePlots
   saveas(gcf,[ploc 'prof_Sflag'],'jpg'); 
end

