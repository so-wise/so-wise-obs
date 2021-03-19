%
% Explore SO-CHIC dataset as prepared by Shenjie Zhou
%

%% Initial setup

% this has been replaced by main_sochic_float_loop, which goes through all
% years

%% Add paths and filenames

% which file are we looking at?
% -- you should only need to change the year number below

year = 2001;

floc = '../data_in_so-chic/Profiles_TS/PFL_prepare/';
ftitle0 = ['Float_merged_' num2str(year)];
fname = [floc ftitle0 '.nc'];
ftitle = ftitle0;
ftitle(ftitle0=='_') = ' ' ;

% plot location
ploc = ['../plots_so-chic/floats/' ftitle0 '/'];

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
ncdisp(fname)

% grab some grid variables
prof_lat = ncread(fname,'LATITUDE');
prof_lon = ncread(fname,'LONGITUDE');

% date and time
t0_ref = ncread(fname,'REFERENCE_DATE_TIME');
t = ncread(fname,'JULD');

% pressure
p = ncread(fname,'PRES');
p_adjusted = ncread(fname,'PRES_ADJUSTED');

% temperature
temp = ncread(fname,'TEMP');
temp_adjusted = ncread(fname,'TEMP_ADJUSTED');
temp_adjusted_error = ncread(fname,'TEMP_ADJUSTED_ERROR');

% psal
psal = ncread(fname,'PSAL');
psal_adjusted = ncread(fname,'PSAL_ADJUSTED');
psal_adjusted_error = ncread(fname,'PSAL_ADJUSTED_ERROR');

%% Location of the profiles

% current SO-WISE domain lon:(-85, 30) lat:(-84.2, -30)
% figure position
figpos = [122 75 1095 704];

figure('visible','on','color','w','position',figpos)
%m_proj('lambert','long',[-85 30],'lat',[-85 -50]);
m_proj('lambert','long',[-78 38],'lat',[-85 -48]);
m_coast('patch',[1 .85 .7]);
m_line(prof_lon,prof_lat,'marker','+','color',[0.0 0.0 0.8],'linewi',2,...
          'linest','none','markersize',8,'markerfacecolor','w') 
m_line(prof_lon-360,prof_lat,'marker','+','color',[0.0 0.0 0.8],'linewi',2,...
          'linest','none','markersize',8,'markerfacecolor','w')
m_grid('box','fancy','tickdir','in','xaxislocation','top');
%title([ftitle ' Argo float profiles']);
m_text(-30,-80,num2str(year),'fontsize',32);
% make plot
if makePlots
   saveas(gcf,[ploc 'zoomin_location_of_profiles' num2str(year)],'jpg'); 
end

%% Make some plots
%- Sanity checking
%- To get a sense for how it works

%% Plots

% pressure
figure('visible','off','color','w','position',figpos)
pcolor(p)
shading flat
colorbar
title('Pressure')
set(gca,'ydir','reverse');
colormap(cmp);
% make plot
if makePlots
   saveas(gcf,[ploc 'pressure'],'jpg'); 
end

% pressure adjusted
figure('visible','off','color','w','position',figpos)
pcolor(p_adjusted)
shading flat
colorbar
title('Pressure adjusted')
set(gca,'ydir','reverse');
colormap(cmp);
% make plot
if makePlots
   saveas(gcf,[ploc 'pressure_adjusted'],'jpg'); 
end

% temperature
figure('visible','off','color','w','position',figpos)
pcolor(temp)
shading flat
colorbar
title('Temperature ')
set(gca,'ydir','reverse');
colormap(cmp);
% make plot
if makePlots
   saveas(gcf,[ploc 'temperature'],'jpg'); 
end

% temperature adjusted
figure('visible','off','color','w','position',figpos)
pcolor(temp_adjusted)
shading flat
colorbar
title('Temperature adjusted ')
set(gca,'ydir','reverse');
colormap(cmp);
% make plot
if makePlots
   saveas(gcf,[ploc 'temperature_adjusted'],'jpg'); 
end

% temperature adjusted
figure('visible','off','color','w','position',figpos)
pcolor(temp_adjusted_error)
shading flat
colorbar
title('Temperature adjusted (error) ')
set(gca,'ydir','reverse');
colormap(cmp);
% make plot
if makePlots
   saveas(gcf,[ploc 'temperature_adjusted_error'],'jpg'); 
end

% salt
figure('visible','off','color','w','position',figpos)
pcolor(psal)
shading flat
colorbar
title('Practical salinity ')
set(gca,'ydir','reverse');
colormap(cmp);
% make plot
if makePlots
   saveas(gcf,[ploc 'psal'],'jpg'); 
end

% salt adjusted
figure('visible','off','color','w','position',figpos)
pcolor(psal_adjusted)
shading flat
colorbar
title('Practical salinity adjusted ')
set(gca,'ydir','reverse');
colormap(cmp);
% make plot
if makePlots
   saveas(gcf,[ploc 'psal_adjusted'],'jpg'); 
end

% salt adjusted error
figure('visible','off','color','w','position',figpos)
pcolor(psal_adjusted_error)
shading flat
colorbar
title('Salinity adjusted (error) ')
set(gca,'ydir','reverse');
colormap(cmp);
% make plot
if makePlots
   saveas(gcf,[ploc 'psal_adjusted_error'],'jpg'); 
end

