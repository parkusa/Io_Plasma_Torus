%This bit of code produces the workspace "Alfven_data", which is loaded
%below instead and save an hour. These modules are located in
%Alfven_cent_frame
%--------------------
% sorting_and_equators% loads and sorts all of the field lines in system 3 coordinates
% 
% JRM09_Alfven_lat_dist% uses our model to compute number densities for each point
% ifusing VIP4 ---> Alfven_lat_dist% uses our model to compute number densities for each point
%--------------------
load('/Users/pahi9557/Documents/MATLAB/Alfven_JRM09/data_prep_jrm09/JRM09_Alfven_data.mat')

Alfven_speed_model%This module computes the alfven speed at each point

JRM09_Alfven_North_South_sorter_model%prepares the system 3 equator values for the next module

JRM09_Alfven_N_S_Travel_Time_model % This module computes the North and South travle time
%along the magnetic field lines

plot_travel_times_model%generates speed and travel time plots

close all;clc %clear warnings from non-unique data set and jbfill notes from cmd wndw

JRM09_Alfven_characteristic %caluclates charcteristic distances and times for each 
%longitudinal equatorial crossing