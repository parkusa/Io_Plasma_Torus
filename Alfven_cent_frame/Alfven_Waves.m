%This bit of code produces the workspace "Alfven_data", which is loaded
%below instead and save an hour.
%--------------------
% sorted_lines_full_cent_frame % loads and sorts all of the field lines in system 3 coordinates
% 
% Alfven_lat_dist% uses our model to compute number densities for each point
%--------------------

load('/Users/pahi9557/Documents/MATLAB/Alfven_Waves/Alfven_cent_frame/Alfven_data.mat')

Alfven_speed%This module computes the alfven speed at each point

Alfven_large_thetas%This module deals with the alfven speed at thetas
%larger than 35 deg lat centrifugal or smaller than -35 deg lat centrifugal. It also prpares the system 
%3 equator values for the next module

Alfven_N_S_Trravel_Time % This module computes the North and South travle time
%along the magnetic field lines

clc

plot_complete_travel_time