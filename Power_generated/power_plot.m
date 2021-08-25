%load('/Users/pahi9557/Documents/MATLAB/Alfven_Waves/Power_generated/power_generated.mat')
load('/Users/pahi9557/Documents/MATLAB/Alfven_JRM09/data_prep_VIP4/VIP4_Alfven_Model.mat')
%finding the mass density and B field at each longitude at R = 6, along the
%spin equator
rho_sys_3_equator_density = mass_density.mass_density(Index.Sys3_equator);
B_sys_3_equator_magentic_field = sorted_lines_1_360.B_Mag(Index.Sys3_equator);
Power_at_Io = 4*(57000)^2*(1815000)^2.*B_sys_3_equator_magentic_field.*(rho_sys_3_equator_density/permeability_of_free_space).^(1/2);


%again, for JRM09
load('/Users/pahi9557/Documents/MATLAB/Alfven_Waves/Power_generated/power_generated_JRM09.mat')
rho_sys_3_equator_density_JRM09 = mass_density_JRM09.mass_density(Index_JRM09.Sys3_equator);
B_sys_3_equator_magentic_field_JRM09 = sorted_lines_1_360_JRM09.B_Mag(Index_JRM09.Sys3_equator);
Power_at_Io_JRM09 = 4*(57000)^2*(1815000)^2.*B_sys_3_equator_magentic_field_JRM09.*(rho_sys_3_equator_density_JRM09/permeability_of_free_space).^(1/2);
x2 = linspace(0,359,360)';

rho_sys_3_equator_density_JRM09_upper = mass_density_JRM09_upper.mass_density(Index_JRM09_upper.Sys3_equator);
B_sys_3_equator_magentic_field_JRM09_upper = sorted_lines_1_360_JRM09_upper.B_Mag(Index_JRM09_upper.Sys3_equator);
Power_at_Io_JRM09_upper = 4*(57000)^2*(1815000)^2.*B_sys_3_equator_magentic_field_JRM09_upper.*(rho_sys_3_equator_density_JRM09_upper/permeability_of_free_space).^(1/2);
x2 = linspace(0,359,360)';

figure()
subplot(3,1,1);
grid on
plot(x,smooth(Power_at_Io),'r','linewidth',2);
hold on
plot(x2,smooth(Power_at_Io_JRM09),'b','linewidth',2);

plot(x,Power_at_Io,'k.','linewidth',2);

plot(x,smooth(Power_at_Io),'r','linewidth',2);


%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title(['Number Density of O+ Along Field Line L = ' num2str(L)],'fontweight','bold','fontsize',18)
title('Power Generated at Io, P \propto B\rho^{1/2}','fontweight','bold','fontsize',18)
%xlabel('East Longitude','fontweight','bold','fontsize',18) % x-axis label
ylabel('Watts','fontweight','bold','fontsize',18) % y-axis label
h_legend = legend('VIP4','JRM09', 'Location','best');
set(h_legend,'FontSize',20);
xlim([0 360])
% ylim([0 5])


subplot(3,1,2);
grid on
plot(x,B_sys_3_equator_magentic_field,'k.','linewidth',2);
hold on
plot(x,smooth(B_sys_3_equator_magentic_field),'r','linewidth',2);

plot(x2,B_sys_3_equator_magentic_field_JRM09,'k.','linewidth',2);
plot(x2,smooth(B_sys_3_equator_magentic_field_JRM09),'b','linewidth',2);
%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title(['Number Density of O+ Along Field Line L = ' num2str(L)],'fontweight','bold','fontsize',18)
%title('Magnetic Field at Io','fontweight','bold','fontsize',18)
%xlabel('East Longitude','fontweight','bold','fontsize',18) % x-axis label
ylabel('Tesla','fontweight','bold','fontsize',18) % y-axis label
%h_legend = legend('Ne','O+', 'O++', 'O+Hot', 'Location','best');
%set(h_legend,'FontSize',20);
xlim([0 360])
% ylim([0 5])



subplot(3,1,3);

% xmaxa = 360;
% a=axes('Position',[.1 .2 .8 .7]);
% set(a,'Units','normalized');


grid on
plot(x,rho_sys_3_equator_density,'k.','linewidth',2);
hold on
plot(x,smooth(rho_sys_3_equator_density),'r','linewidth',2);

plot(x2,rho_sys_3_equator_density_JRM09,'k.','linewidth',2);
plot(x2,smooth(rho_sys_3_equator_density_JRM09),'b','linewidth',2);


% set limits and labels
%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title(['Number Density of O+ Along Field Line L = ' num2str(L)],'fontweight','bold','fontsize',18)
%title('Mass Density at Io','fontweight','bold','fontsize',18)
xlabel('East Longitude','fontweight','bold','fontsize',18) % x-axis label
ylabel('kg/cm^3','fontweight','bold','fontsize',18) % y-axis label
%h_legend = legend('Ne','O+', 'O++', 'O+Hot', 'Location','best');
%set(h_legend,'FontSize',20);
xlim([0 360])
% ylim([0 5])











%%%




a = linspace(0,359,360);
a = a';
b = Index.Alfven_Travel_Time_Total/60;
b2 =  Index_JRM09.Alfven_Travel_Time_Total/60;





% b(68) = (b(67) + b(69))/2;
% b(248) = (b(247) + b(249))/2;
% b2(68) = (b2(67) + b2(69))/2;
% b2(248) = (b2(247) + b2(249))/2;
% b3(68) = (b3(67) + b3(69))/2;
% b3(248) = (b3(247) + b3(249))/2;



y=b;
x=a;
y2=b2;



% M = movmedian(b,1);
figure()
subplot(2,1,1);
grid on

%hax1 = axes();

yy1 = smooth(x,y,0.1,'loess');
yy2 = smooth(x,y2,0.1,'loess');


[xx,ind] = sort(x);
plot(xx,yy1(ind),'r','linewidth',2)
hold on
plot(xx,yy2(ind),'b','linewidth',1);

%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
title('Period of Complete Travel Time vs East Longitude','fontweight','bold','fontsize',18)
xlabel('East Longitude','fontweight','bold','fontsize',18) % x-axis label
ylabel('Travel Time (min)','fontweight','bold','fontsize',18) % y-axis label
h_legend = legend('VIP4','JRM09', 'Location','best');
%set(h_legend,'FontSize',20);
% xlim([0 5])
% ylim([0 15])

subplot(2,1,2);
grid on
plot(x,Index.Alfven_Travel_Time_North/60,'r', 'Linewidth',2)
hold on;
plot(x,Index_JRM09.Alfven_Travel_Time_North/60,'b', 'Linewidth',2)
p3 = plot(x,Index.Alfven_Travel_Time_South/60,'r', 'Linewidth',2);
plot(x,Index_JRM09.Alfven_Travel_Time_South/60,'b', 'Linewidth',2);





% Changing Opacities
% p1.Color(4) = 0.75;
% p2.Color(4) = 0.75;
% p4.Color(4) = 0.75;
% p5.Color(4) = 0.75;

text(361,11,'North','fontweight','bold','fontname','Kannada MN','fontsize',18)
text(361,3.8,'South','fontweight','bold','fontname','Kannada MN','fontsize',18)
%listfonts to see all fonts
%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
title('North and South (One Way) Travel Time vs East Longitude','fontweight','bold','fontsize',18)
xlabel('East Longitude','fontweight','bold','fontsize',18) % x-axis label
ylabel('Travel Time (min)','fontweight','bold','fontsize',18) % y-axis label
%h_legend = legend('To Planet: V_A = V_{35}','To Planet: V_A = c', 'To +/- 35^\circ_{cent}','model','location','best');
%set(h_legend,'FontSize',20);
%ylim([0 15])

figure()
grid on

%hax1 = axes();



[xx,ind] = sort(x);
plot(xx,yy2(ind)-yy1(ind),'r','linewidth',2)
hold on


%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
title('Difference in one way period, JRM09 - VIP4','fontweight','bold','fontsize',18)
xlabel('East Longitude','fontweight','bold','fontsize',18) % x-axis label
ylabel('Travel Time (min)','fontweight','bold','fontsize',18) % y-axis label
%h_legend = legend('VIP4','JRM09', 'Location','best');
%set(h_legend,'FontSize',20);
% xlim([0 5])
% ylim([0 15])

