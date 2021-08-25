%This module had much more purpose in the lat_dist simple dipole code.


%This module is supposed to generate the location of the centrigugal
%equator in system III for each of the spacecraft locations. However, I
%have to do that in IDL using Kaleb's produce_field_lines_code, which I
%have already done and added to the PLS_master_to20 module in the structure
%VIP_cent_loc



load('/Users/pahi9557/Documents/MATLAB/JRM09/JRM09_data_prep/JRM09_voyager_equators.mat')
%switching to co-lat, b/c that's what my VIP4 code is in at this point, and
%I want to mirror that
JRM09_cent_loc.theta = 90 - JRM09_cent_loc.theta;
JRM09_mag_loc.theta = 90 - JRM09_mag_loc.theta;


%When I computed the equators, I only did it for values where r <= 10.5 RJ.
%So, I had to delete a bunch of values. Here, I put zeros back in as place
%holders for those values.
a = linspace(1,1,226);
a = 0*a;
JRM09_cent_loc.r = [a JRM09_cent_loc.r']';
JRM09_cent_loc.theta = [a JRM09_cent_loc.theta']';
JRM09_cent_loc.phi = [a JRM09_cent_loc.phi']';

JRM09_mag_loc.r = [a JRM09_mag_loc.r']';
JRM09_mag_loc.theta = [a JRM09_mag_loc.theta']';
JRM09_mag_loc.phi = [a JRM09_mag_loc.phi']';
clear a;




JRM09_rho_cent_location_in_sys3 = JRM09_cent_loc.r.*sind(JRM09_cent_loc.theta);
