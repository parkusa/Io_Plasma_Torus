%for further explanation of the following block of code see:
%Relative_variation_plots.m
c = 1 ;  % constant offest
lambda = linspace(0,360,361); %system 3 longitude
lambda = lambda'; % change from column vector to row vector (transpose)
A = 0.19; %Amplitude of variation
phi = 150; %phase of the variation
S_variation = mixing_ratio(A,lambda,phi,c); %generating sinusoid
A = 0.28; %Amplitude of variation
phi = 330; %phase of the variation
S2_variation = mixing_ratio(A,lambda,phi,c); %generating sinusoid
clear A; clear phi; clear c;


%Just loading all of the Voyager data (and a few extra variables) in order
%to see how the relative variation might affect the electron density
PLS_master_to20%This module loads all of the data from the PLS_Master
%This version elimates duplicates in the data set. This module exists
%in the Lat-Dist/Io_Torus_Modules

electrons = SDensity + 3*SDensity2;

Mfactor_S = interp1(lambda,S_variation,Phi);
Mfactor_S2 = interp1(lambda,S2_variation,Phi);
SDensity_varied = Mfactor_S.*SDensity;
SDensity2_varied = Mfactor_S2.*SDensity2;

electrons_new = SDensity_varied + 3*SDensity2_varied;
electron_variation = electrons_new./electrons;

%visualizae variation

figure()
grid on
plot(Rad,electron_variation,'k','linewidth',3);
hold on


%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title(['Number Density of O+ Along Field Line L = ' num2str(L)],'fontweight','bold','fontsize',18)
title('Voyager Electron Variation: S+, S+++','fontweight','bold','fontsize',18)
xlabel('RJ','fontweight','bold','fontsize',18) % x-axis label
ylabel('n_e/n_{e,\lambda}','fontweight','bold','fontsize',18) % y-axis label
%h_legend = legend('Ne','O+', 'O++', 'O+Hot', 'Location','best');
%set(h_legend,'FontSize',20);
% xlim([0 5])
% ylim([0 5])

electrons = ODensity + 2*ODensity1 + HotODensity + SDensity + 2*SDensity1 + 3*SDensity2 + HDensity + NaDensity;
electrons_new = ODensity + 2*ODensity1 + HotODensity + SDensity_varied + 2*SDensity1 + 3*SDensity2_varied + HDensity + NaDensity;

electron_variation = electrons_new./electrons;

%visualizae variation

figure()
grid on
plot(Rad,electron_variation,'k','linewidth',3);
hold on


%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title(['Number Density of O+ Along Field Line L = ' num2str(L)],'fontweight','bold','fontsize',18)
title('Voyager Electron Variation: All Species','fontweight','bold','fontsize',18)
xlabel('RJ','fontweight','bold','fontsize',18) % x-axis label
ylabel('n_{e,\lambda}/n_e','fontweight','bold','fontsize',18) % y-axis label
%h_legend = legend('Ne','O+', 'O++', 'O+Hot', 'Location','best');
%set(h_legend,'FontSize',20);
% xlim([0 5])
% ylim([0 5])