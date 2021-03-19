% main wrapper

% clean up
clear all
close all

% loop
for nyear=2004:1:2017
    year = nyear;
    disp(year)
    %explore_sochic_floats;
    explore_sochic_meop_profiles;
    clear all
    close all
end