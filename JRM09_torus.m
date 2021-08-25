PLS_master_to20%This module loads all of the data from the PLS_Master
%This version elimates duplicates in the data set. This module exists
%in the Lat-Dist/Io_Torus_Modules

JRM09_cent_location_mapping %This module is supposed to compute the centrifu-
%locations in sys3 for each sc location. However, since that is already do-
%ne, this module really just computes one variable

JRM09_fitting_electrons % This prepares all of the electron properties along
%M shells

JRM09_Cassini_UVIS_variation_part_1% changes the centrifugal profiles to be what
%they would be if there was no time variation. This assumes that measured
%valued were affected by the variation

%If you don't want the variation, comment out the above module and the
%other time variation module

JRM09_equator_nmax % This module produces the number density at each location
%extrapolated to the equator.

JRM09_M10_cutoff % This module cuts the lists down so we only model what's inside
% M = 10.

JRM09_Cold_Torus_Fudge % Fran and I have created a fudge for values for rho_cent
%5-6RJ.

JRM09_Smoother %Smooths the radial profiles to get rid of jagged edges and fake
%anomalies

JRM09_grid_maker% making the grid and loading the centrifugal locations generated 
%at each grid point using Parker's version of Kaleb's produce field line
%code.

JRM09_Grid_Interp%This module interps all required variables to run n_max on the grid of
%points. Including electron properties,fcorot and equatorial densitties.

JRM09_Cassini_UVIS_variation%This module,located in sys_3_variations/sys_3_torus_modules,
%adds in the sinusoidal variation of S+ and S+++ observed by Cassini

%If you don't want the variation, comment out the above module and the
%other time variation module

JRM09_Grid_extrp%This module runs n_max code to extrapolate the density at each grid point

progressbar(1); %closes the progress bar module