load('/Users/pahi9557/Documents/MATLAB/Alfven_JRM09/data_prep_VIP4/VIP4_Alfven_prepared.mat')
Index_VIP4 = Index;
sorted_lines_1_360_VIP4 = sorted_lines_1_360;
clear JRM09; clear Index; clear sorted_lines_1_360;

load('/Users/pahi9557/Documents/MATLAB/Alfven_JRM09/data_prep_jrm09/JRM09_Alfven_prepared.mat')


figure()

grid on
hold on



for counter1 = 1:10:360

if counter1 < 360
a = Index(counter1);
b = Index(counter1 +1) - 1;

a1 = Index_VIP4(counter1);
b1 = Index_VIP4(counter1 +1) - 1;
end
if counter1 == 360
a = Index.Line_Index(counter1);
b = length(sorted_lines_1_360.phi); %last value in the list

a1 = Index_VIP4.Line_Index(counter1);
b1 = length(sorted_lines_1_360_VIP4.phi); %last value in the list
end


plot(sorted_lines_1_360.phi(a:b),sorted_lines_1_360.theta(a:b),'Color','b','linewidth',1);
plot(sorted_lines_1_360_VIP4.phi(a1:b1),sorted_lines_1_360_VIP4.theta(a1:b1),'Color','r','linewidth',1);
%ax1 = gca; % current axes
end


yt=[-90 -30 0 30 90];
set(gca,'ytick',yt)
%set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
%set(gca, 'YScale', 'log')
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title(['Number Density of O+ Along Field Line L = ' num2str(L)],'fontweight','bold','fontsize',18)
xlabel('EAST JOVIGRAPHIC LONGITUDE','fontweight','bold','fontsize',16) % x-axis label
ylabel('\theta_{sysIII}','fontweight','bold','fontsize',16) % y-axis label
h_legend = legend('VIP4','JRM09', 'Location','best');
%set(h_legend,'FontSize',20);
 xlim([0 360])
ylim([-90 90])


%generating new x tixk values
xt= sort(360 - xticks);
%%getting rid of old tick marks at top
 box off
ax1 = gca;
ax3 = axes('Position', get(ax1, 'Position'), 'FontSize', 10,...
           'Color','None','XColor','k','YColor','k', 'LineWidth', 1,...
           'XAxisLocation','top', 'XTick', [],... 
           'YAxisLocation','right', 'YTick', []);
linkaxes([ax1, ax3])

%adding new top axis
ax1_pos = get(gca,'Position');
ax2 = axes('Position', ax1_pos,...
           'XAxisLocation', 'top',... 
           'YAxisLocation', 'right',...
           'Color', 'none');
set(ax2,'YColor','none');
%title('2^{nd} Harmonics');
xlabel('Sys III West \phi','fontsize',16) % x-axis label
%title(['Integer Wave Front Locations when Io is at \phi =  ' num2str(desired_phi)],'fontweight','bold','fontsize',20)
xlim([0 360])
set(gca,'xtick',xt)
set(gca, 'xdir', 'reverse')
set(gca,'FontSize',16)

% ax1_pos = ax1.Position; % position of first axes
% ax2 = axes('Position',ax1_pos,...
%     'XAxisLocation','top',...
%     'YAxisLocation','left',...
%     'Color','none','YColor','none');
% title('WEST JOVIGRAPHIC LONGITUDE','fontweight','bold','fontsize',18)
% set(gca,'FontSize',16)



sorted_lines_1_360.X = sorted_lines_1_360.r.*sind(90 - sorted_lines_1_360.theta).*cosd(sorted_lines_1_360.phi);
sorted_lines_1_360.Y = sorted_lines_1_360.r.*sind(90 - sorted_lines_1_360.theta).*sind(sorted_lines_1_360.phi);
sorted_lines_1_360.Z = sorted_lines_1_360.r.*cosd(90 - sorted_lines_1_360.theta);

sorted_lines_1_360_VIP4.X = sorted_lines_1_360_VIP4.r.*sind(90 - sorted_lines_1_360_VIP4.theta).*cosd(sorted_lines_1_360_VIP4.phi);
sorted_lines_1_360_VIP4.Y = sorted_lines_1_360_VIP4.r.*sind(90 - sorted_lines_1_360_VIP4.theta).*sind(sorted_lines_1_360_VIP4.phi);
sorted_lines_1_360_VIP4.Z = sorted_lines_1_360_VIP4.r.*cosd(90 - sorted_lines_1_360_VIP4.theta);

figure()

hold on

for counter1 = 1:10:360

if counter1 < 360
a = Index(counter1);
b = Index(counter1 +1) - 1;

a1 = Index_VIP4(counter1);
b1 = Index_VIP4(counter1 +1) - 1;
end
if counter1 == 360
a = Index.Line_Index(counter1);
b = length(sorted_lines_1_360.phi); %last value in the list

a1 = Index_VIP4.Line_Index(counter1);
b1 = length(sorted_lines_1_360_VIP4.phi); %last value in the list
end


hc = scatter3(sorted_lines_1_360.X(a:b),sorted_lines_1_360.Y(a:b),sorted_lines_1_360.Z(a:b),1,'blue');
hc1 = scatter3(sorted_lines_1_360_VIP4.X(a1:b1),sorted_lines_1_360_VIP4.Y(a1:b1),sorted_lines_1_360_VIP4.Z(a1:b1),1,'red');

end

daspect([1 1 1])
xlabel('System 3 x (R_{J})','fontweight','bold','fontsize',22) 
ylabel('System 3 y (R_{J})','fontweight','bold','fontsize',22)
zlabel('System 3 z (R_{J})','fontweight','bold','fontsize',22)










%










figure()

grid on
hold on



counter1 = 290;

if counter1 < 360
a = Index(counter1);
b = Index(counter1 +1) - 1;

a1 = Index_VIP4(counter1);
b1 = Index_VIP4(counter1 +1) - 1;
end
if counter1 == 360
a = Index.Line_Index(counter1);
b = length(sorted_lines_1_360.phi); %last value in the list

a1 = Index_VIP4.Line_Index(counter1);
b1 = length(sorted_lines_1_360_VIP4.phi); %last value in the list
end


plot(sorted_lines_1_360.phi(a:b),sorted_lines_1_360.theta(a:b),'Color','r','linewidth',0.5);
plot(sorted_lines_1_360_VIP4.phi(a1:b1),sorted_lines_1_360_VIP4.theta(a1:b1),'Color','b','linewidth',0.5);
%ax1 = gca; % current axes



% yt=[-90 -30 0 30 90];
% set(gca,'ytick',yt)
%set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
%set(gca, 'YScale', 'log')
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title(['Number Density of O+ Along Field Line L = ' num2str(L)],'fontweight','bold','fontsize',18)
xlabel('EAST JOVIGRAPHIC LONGITUDE','fontweight','bold','fontsize',16) % x-axis label
ylabel('\theta_{sysIII}','fontweight','bold','fontsize',16) % y-axis label
h_legend = legend('VIP4','JRM09', 'Location','best');
set(h_legend,'FontSize',20);
%  xlim([0 360])
ylim([-40 40])

clear all


load('/Users/pahi9557/Documents/MATLAB/Alfven_JRM09/data_prep_jrm09/JRM09_Alfven_Model.mat')
%North Alfven Travel Time
counter1 = 290;

if counter1 < 360
    a = characteristic.North.index(counter1);
    b = characteristic.North.index(counter1 +1) - 1;
end
if counter1 == 360
    a = characteristic.North.index(counter1);
    b = length(characteristic.North.there.time); %last value in the list
end

figure()
grid on
semilogy(characteristic.North.there.theta(a:b),characteristic.North.there.time(a:b),'b','linewidth',.5);
hold on

load('/Users/pahi9557/Documents/MATLAB/Alfven_JRM09/data_prep_VIP4/VIP4_Alfven_Model.mat')
if counter1 < 360
    a = characteristic.North.index(counter1);
    b = characteristic.North.index(counter1 +1) - 1;
end
if counter1 == 360
    a = characteristic.North.index(counter1);
    b = length(characteristic.North.there.time); %last value in the list
end
semilogy(characteristic.North.there.theta(a:b),characteristic.North.there.time(a:b),'r','linewidth',.5);
%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
title(['Travel Time Along Field Line \Phi ' num2str(counter1 - 1)],'fontweight','bold','fontsize',18)
%title('\theta (normal latitude) vs Time','fontweight','bold','fontsize',18)
xlabel('\theta_{spin}','fontweight','bold','fontsize',18) % x-axis label
ylabel('time (s)','fontweight','bold','fontsize',18) % y-axis label
%h_legend = legend('Ne','O+', 'O++', 'O+Hot', 'Location','best');
%set(h_legend,'FontSize',20);
% xlim([0 5])
% ylim([0 5])


