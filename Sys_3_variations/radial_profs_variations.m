

PLS_master_to20%This module loads all of the data from the PLS_Master
%This version elimates duplicates in the data set. This module exists
%in the Lat-Dist/Io_Torus_Modules

VIP_cent_location_mapping %This module is supposed to compute the centrifu-
%locations in sys3 for each sc location. However, since that is already do-
%ne, this module really just computes one variable

VIP_fitting_electrons % This prepares all of the electron properties along 
%M shells

VIP_equator_nmax % This module produces the number density at each location 
%extrapolated to the equator. 

figure(1)

grid on
semilogy(VIP_cent_loc.r,VIP_nmax_eq.n_max_Sulfur,'linewidth',7);
hold on
i = semilogy(VIP_cent_loc.r,VIP_nmax_eq.n_max_Sulfur2,'linewidth',7);
set(i, 'Color', (1/255)*[255 204 229])
semilogy(VIP_cent_loc.r,VIP_nmax_eq.n_max_Electron,'g','linewidth',7);


clear all;

PLS_master_to20%This module loads all of the data from the PLS_Master
%This version elimates duplicates in the data set. This module exists
%in the Lat-Dist/Io_Torus_Modules

VIP_cent_location_mapping %This module is supposed to compute the centrifu-
%locations in sys3 for each sc location. However, since that is already do-
%ne, this module really just computes one variable

VIP_fitting_electrons % This prepares all of the electron properties along 
%M shells

VIP_Cassini_UVIS_variation_part_1% changes the centrifugal profiles to be what
%they would be if there was no time variation. This assumes that measured
%valued were affected by the variation

VIP_equator_nmax % This module produces the number density at each location 
%extrapolated to the equator. 




semilogy(VIP_cent_loc.r,VIP_nmax_eq.n_max_Sulfur,'k.','MarkerSize',7);
hold on
i = semilogy(VIP_cent_loc.r,VIP_nmax_eq.n_max_Sulfur2,'k.','MarkerSize',7);
semilogy(VIP_cent_loc.r,VIP_nmax_eq.n_max_Electron,'k.','MarkerSize',7);

%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
title('Centrifugal Radial Density Profiles','fontweight','bold','fontsize',18)
xlabel('\rho_{cent}','fontweight','bold','fontsize',18) % x-axis label
ylabel('#/cm^3','fontweight','bold','fontsize',18) % y-axis label
h_legend = legend('S+','S+++', 'e-','Sys3 Variation', 'Location','best');
set(h_legend,'Box','off','color','k');
set(h_legend,'FontSize',20);
set(gca,'xcolor','k','ycolor','k','zcolor','k','xminorgrid','on','yminorgrid','on','zminorgrid','on',...
    'FontSize',16)
xlim([5.5 10])
%ylim([0 5])