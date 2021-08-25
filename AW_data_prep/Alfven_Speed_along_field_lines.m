load('/Users/pahi9557/Documents/MATLAB/Alfven_Waves/AW_data_prep/full_field_data_68_158.mat')
a = 10^(-9);
%field_line_68.B_mag = field_line_68.B_mag*a;
%field_line_158.B_mag = field_line_158.B_mag*a;

clear a;
permeability_of_free_space = 4*pi*10^(-7);
mass_density68 = 16*(field_line_68.O_density+field_line_68.O1_density+field_line_68.HotO_density)+32*(field_line_68.S_density+field_line_68.S1_density+field_line_68.S2_density)+field_line_68.H_density+23*field_line_68.Na_density;
mass_density68 = mass_density68*(1.66054*10^(-21));
field_line_68.Alfven_speed = field_line_68.B_mag./(permeability_of_free_space*mass_density68).^(1/2);
field_line_68.Alfven_speed(isinf(field_line_68.Alfven_speed))=0;
field_line_68.Alfven_speed = field_line_68.Alfven_speed*10^(-3);


mass_density158 = 16*(field_line_158.O_density+field_line_158.O1_density+field_line_158.HotO_density)+32*(field_line_158.S_density+field_line_158.S1_density+field_line_158.S2_density)+field_line_158.H_density+23*field_line_158.Na_density;
mass_density158 = mass_density158*(1.66054*10^(-21));
field_line_158.Alfven_speed = field_line_158.B_mag./(permeability_of_free_space*mass_density158).^(1/2);
field_line_158.Alfven_speed(isinf(field_line_158.Alfven_speed))=0;
field_line_158.Alfven_speed = field_line_158.Alfven_speed*10^(-3);



%first run Alfven_Speed_along_field_lines

figure()
grid on
semilogy(field_line_68.Theta,field_line_68.Alfven_speed,'k','linewidth',2);
hold on
semilogy(field_line_158.Theta,field_line_158.Alfven_speed,'m','linewidth',2);


%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
title('Alfen Wave Speed at M = 6 ','fontweight','bold','fontsize',18)
xlabel('\theta_{sys3}','fontweight','bold','fontsize',18) % x-axis label
ylabel('Alfven Speed Km/s','fontweight','bold','fontsize',18) % y-axis label
h_legend = legend('\phi = 68','\phi = 158','Location','best');
set(h_legend,'FontSize',20);
xlim([-35 35])
%ylim([0 5])


figure()
grid on
semilogy(field_line_68.Theta,field_line_68.HotO_density,'Linewidth',4);
hold on
semilogy(field_line_68.Theta,field_line_68.H_density,'Linewidth',4);
semilogy(field_line_68.Theta,field_line_68.O_density,'Linewidth',4);
semilogy(field_line_68.Theta,field_line_68.O1_density,'Linewidth',4);
semilogy(field_line_68.Theta,field_line_68.Na_density,'Linewidth',4);
semilogy(field_line_68.Theta,field_line_68.S_density,'Linewidth',4);
semilogy(field_line_68.Theta,field_line_68.S1_density,'Linewidth',4);
i = semilogy(field_line_68.Theta,field_line_68.S2_density,'Linewidth',4);
set(i, 'Color', (1/255)*[255 204 229])
yt=[ 0:.5:1 10:30:90 100:200:800];
set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=(0:1:6);
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
title('Density at M = 6 \phi = 68','fontweight','bold','fontsize',22)
ylabel('ions/cm^3','fontweight','bold','fontsize',22) % x-axis label
xlabel('\theta_{sys3}','fontweight','bold','fontsize',22) % y-axis label
h_legend = legend('hot O+', 'H+','O+','O++','Na+','S+','S++','S+++','Location','best');
set(h_legend,'FontSize',20);
xlim([-35 35])

figure()
grid on
semilogy(field_line_158.Theta,field_line_158.HotO_density,'Linewidth',4);
hold on
semilogy(field_line_158.Theta,field_line_158.H_density,'Linewidth',4);
semilogy(field_line_158.Theta,field_line_158.O_density,'Linewidth',4);
semilogy(field_line_158.Theta,field_line_158.O1_density,'Linewidth',4);
semilogy(field_line_158.Theta,field_line_158.Na_density,'Linewidth',4);
semilogy(field_line_158.Theta,field_line_158.S_density,'Linewidth',4);
semilogy(field_line_158.Theta,field_line_158.S1_density,'Linewidth',4);
i = semilogy(field_line_158.Theta,field_line_158.S2_density,'Linewidth',4);
set(i, 'Color', (1/255)*[255 204 229])
yt=[ 0:.5:1 10:30:90 100:200:800];
set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=(0:1:6);
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
title('Density at M = 6 \phi = 158','fontweight','bold','fontsize',22)
ylabel('ions/cm^3','fontweight','bold','fontsize',22) % x-axis label
xlabel('\theta_{sys3}','fontweight','bold','fontsize',22) % y-axis label
h_legend = legend('hot O+', 'H+','O+','O++','Na+','S+','S++','S+++','Location','best');
set(h_legend,'FontSize',20);
xlim([-35 35])

clear i; clear h_legend; clear mass_density158; clear mass_density68; 
clear permeability_of_free_space; clear yt;
