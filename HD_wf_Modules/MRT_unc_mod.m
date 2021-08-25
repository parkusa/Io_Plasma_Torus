%This module computes the uncertainty in IFP predictions due to a 50%
%increase in mass density (~22% inc in travel time)

load('/Users/pahi9557/Documents/MATLAB/HDAlfven_JRM09/MAW_RAW_11_2.mat')
load('/Users/pahi9557/Documents/MATLAB/HDAlfven_JRM09/MAW_RAW_incTT_1_19_19.mat')


HDMAW.Io_east_long(352:360) = [];
HDMAW.north.r(352:360) = [];
HDMAW.north.theta_lat(352:360) = [];
HDMAW.north.phi_east(352:360) = [];
HDMAW.south.r(352:360) = [];
HDMAW.south.theta_lat(352:360) = [];
HDMAW.south.phi_east(352:360) = [];

HDRAW.Io_east_long(352:360) = [];
HDRAW.north.r(352:360) = [];
HDRAW.north.theta_lat(352:360) = [];
HDRAW.north.phi_east(352:360) = [];
HDRAW.south.r(352:360) = [];
HDRAW.south.theta_lat(352:360) = [];
HDRAW.south.phi_east(352:360) = [];

HDTEB.Io_east_long(352:360) = [];
HDTEB.north.r(352:360) = [];
HDTEB.north.theta_lat(352:360) = [];
HDTEB.north.phi_east(352:360) = [];
HDTEB.south.r(352:360) = [];
HDTEB.south.theta_lat(352:360) = [];
HDTEB.south.phi_east(352:360) = [];


[, col] = find(HDRAW_inc.Io_east_long==0);


HDMAW.Io_east_long(col) = [];
HDMAW.north.r(col) = [];
HDMAW.north.theta_lat(col) = [];
HDMAW.north.phi_east(col) = [];
HDMAW.south.r(col) = [];
HDMAW.south.theta_lat(col) = [];
HDMAW.south.phi_east(col) = [];

HDRAW.Io_east_long(col) = [];
HDRAW.north.r(col) = [];
HDRAW.north.theta_lat(col) = [];
HDRAW.north.phi_east(col) = [];
HDRAW.south.r(col) = [];
HDRAW.south.theta_lat(col) = [];
HDRAW.south.phi_east(col) = [];

HDTEB.Io_east_long(col) = [];
HDTEB.north.r(col) = [];
HDTEB.north.theta_lat(col) = [];
HDTEB.north.phi_east(col) = [];
HDTEB.south.r(col) = [];
HDTEB.south.theta_lat(col) = [];
HDTEB.south.phi_east(col) = [];

HDMAW_inc.Io_east_long(col) = [];
HDMAW_inc.north.r(col) = [];
HDMAW_inc.north.theta_lat(col) = [];
HDMAW_inc.north.phi_east(col) = [];
HDMAW_inc.south.r(col) = [];
HDMAW_inc.south.theta_lat(col) = [];
HDMAW_inc.south.phi_east(col) = [];

HDRAW_inc.Io_east_long(col) = [];
HDRAW_inc.north.r(col) = [];
HDRAW_inc.north.theta_lat(col) = [];
HDRAW_inc.north.phi_east(col) = [];
HDRAW_inc.south.r(col) = [];
HDRAW_inc.south.theta_lat(col) = [];
HDRAW_inc.south.phi_east(col) = [];

HDTEB_inc.Io_east_long(col) = [];
HDTEB_inc.north.r(col) = [];
HDTEB_inc.north.theta_lat(col) = [];
HDTEB_inc.north.phi_east(col) = [];
HDTEB_inc.south.r(col) = [];
HDTEB_inc.south.theta_lat(col) = [];
HDTEB_inc.south.phi_east(col) = [];

clear col;



HDMRT_unc = struct();
HDMRT_unc.Io_east_long = HDRAW_inc.Io_east_long;
HDMRT_unc.north_MAW_phi_east = abs(HDMAW.north.phi_east - HDMAW_inc.north.phi_east);
HDMRT_unc.north_RAW_phi_east = abs(HDRAW.north.phi_east - HDRAW_inc.north.phi_east);
HDMRT_unc.north_TEB_phi_east = abs(HDTEB.north.phi_east - HDTEB_inc.north.phi_east);

HDMRT_unc.south_MAW_phi_east = abs(HDMAW.south.phi_east - HDMAW_inc.south.phi_east);
HDMRT_unc.south_RAW_phi_east = abs(HDRAW.south.phi_east - HDRAW_inc.south.phi_east);
HDMRT_unc.south_TEB_phi_east = abs(HDTEB.south.phi_east - HDTEB_inc.south.phi_east);

HDMRT_unc.actual.north_MAW_phi_east = HDMAW.north.phi_east;
HDMRT_unc.actual.north_RAW_phi_east = HDRAW.north.phi_east;
HDMRT_unc.actual.north_TEB_phi_east = HDTEB.north.phi_east;
HDMRT_unc.actual.south_MAW_phi_east = HDMAW.south.phi_east;
HDMRT_unc.actual.south_RAW_phi_east = HDRAW.south.phi_east;
HDMRT_unc.actual.south_TEB_phi_east = HDTEB.south.phi_east;

HDMRT_unc.actual_inc.north_MAW_phi_east = HDMAW_inc.north.phi_east;
HDMRT_unc.actual_inc.north_RAW_phi_east = HDRAW_inc.north.phi_east;
HDMRT_unc.actual_inc.north_TEB_phi_east = HDTEB_inc.north.phi_east;
HDMRT_unc.actual_inc.south_MAW_phi_east = HDMAW_inc.south.phi_east;
HDMRT_unc.actual_inc.south_RAW_phi_east = HDRAW_inc.south.phi_east;
HDMRT_unc.actual_inc.south_TEB_phi_east = HDTEB_inc.south.phi_east;




HDMRT_unc.actual.north_MAW_phi_east(1) = HDMRT_unc.actual.north_MAW_phi_east(1);

clear HDMAW; clear HDRAW; clear HDTEB;

clear HDMAW_inc; clear HDRAW_inc; clear HDTEB_inc;
clear HST_2009;


