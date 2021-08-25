load('/Users/pahi9557/Documents/MATLAB/Alfven_Waves/AW_data_prep/full_field_data_1_360.mat')

% for first run of the code to get B in Teslas
% a = 10^(-9);
% sorted_lines_1_360.B_Mag = sorted_lines_1_360.B_Mag*a;
% clear a;

permeability_of_free_space = 4*pi*10^(-7);
mass_density68 = 16*(sorted_lines_1_360.O_density+sorted_lines_1_360.O1_density+sorted_lines_1_360.HotO_density)+32*(sorted_lines_1_360.S_density+sorted_lines_1_360.S1_density+sorted_lines_1_360.S2_density)+sorted_lines_1_360.H_density+23*sorted_lines_1_360.Na_density;
mass_density68 = mass_density68*(1.66054*10^(-21));
sorted_lines_1_360.Alfven_speed = sorted_lines_1_360.B_Mag./(permeability_of_free_space*mass_density68).^(1/2);
sorted_lines_1_360.Alfven_speed(isinf(sorted_lines_1_360.Alfven_speed))=0;
sorted_lines_1_360.Alfven_speed = sorted_lines_1_360.Alfven_speed*10^(-3);
% 
% figure()
% grid on
% semilogy(sorted_lines_1_360.Theta,sorted_lines_1_360.HotO_density,'Linewidth',4);
% hold on
% semilogy(sorted_lines_1_360.Theta,sorted_lines_1_360.H_density,'Linewidth',4);
% semilogy(sorted_lines_1_360.Theta,sorted_lines_1_360.O_density,'Linewidth',4);
% semilogy(sorted_lines_1_360.Theta,sorted_lines_1_360.O1_density,'Linewidth',4);
% semilogy(sorted_lines_1_360.Theta,sorted_lines_1_360.Na_density,'Linewidth',4);
% semilogy(sorted_lines_1_360.Theta,sorted_lines_1_360.S_density,'Linewidth',4);
% semilogy(sorted_lines_1_360.Theta,sorted_lines_1_360.S1_density,'Linewidth',4);
% i = semilogy(sorted_lines_1_360.Theta,sorted_lines_1_360.S2_density,'Linewidth',4);
% set(i, 'Color', (1/255)*[255 204 229])
% yt=[ 0:.5:1 10:30:90 100:200:800];
% set(gca,'ytick',yt)
% set(gca,'yminorgrid','on')
% %xt=(0:1:6);
% %set(gca,'xtick',xt)
% set(gca,'xminorgrid','on')
% set(gca,'FontSize',16)
% title('Density at M = 6 \phi = 68','fontweight','bold','fontsize',22)
% ylabel('ions/cm^3','fontweight','bold','fontsize',22) % x-axis label
% xlabel('\theta_{sys3}','fontweight','bold','fontsize',22) % y-axis label
% h_legend = legend('hot O+', 'H+','O+','O++','Na+','S+','S++','S+++','Location','best');
% set(h_legend,'FontSize',20);
% xlim([-35 35])