% we now sort the wf list and associated values
[wf.list, I] = sort(wf.list); 
wf.r1 = wf.r1(I,:);
wf.r2 = wf.r2(I,:);
wf.theta1 = wf.theta1(I,:);
wf.theta2 = wf.theta2(I,:);
wf.phi1 = wf.phi1(I,:);
wf.phi2 = wf.phi2(I,:);
clear I;

%use built in peak fitting function to find which field lines have alfven
%waves reaching the inopshere
[peakValues_North1, indexes_North1] = findpeaks(smooth(wf.theta1,23));
[peakValues_North2, indexes_North2] = findpeaks(smooth(wf.theta2,23));

[peakValues_South1, indexes_South1] = findpeaks((-1)*smooth(wf.theta1,23));
[peakValues_South2, indexes_South2] = findpeaks((-1)*smooth(wf.theta2,23));

peakValues_North = [peakValues_North1' peakValues_North2'];
peakValues_South = [peakValues_South1' peakValues_South2'];

%condensing indexes
indexes_North = [indexes_North1' indexes_North2']';
indexes_South = [indexes_South1' indexes_South2']';


%figure 1 is the original tracking the wavefronts plot

figure(1)
grid on
plot(wf.list,smooth(wf.theta1),'k','linewidth',2);
hold on
plot(wf.list,smooth(wf.theta2),'r','linewidth',2);

plot(wf.list,smooth(wf.north_ionosphere,60),'k','linewidth',2);
plot(wf.list,smooth(wf.south_ionosphere),'k','linewidth',2);


plot(wf.list(indexes_North2),wf.north_ionosphere(indexes_North2),'*b','Markersize',8);
plot(wf.list(indexes_South2),wf.south_ionosphere(indexes_South2),'*b','Markersize',8);
plot(wf.list(indexes_North1),wf.north_ionosphere(indexes_North1),'*b','Markersize',8);
plot(wf.list(indexes_South1),wf.south_ionosphere(indexes_South1),'*b','Markersize',8);

plot(desired_phi,0,'y.','Markersize',50);

for c = 1:length(indexes_North1)
plot([indexes_North1(c)/10,indexes_North1(c)/10],[peakValues_North1(c),wf.north_ionosphere(indexes_North1(c))],'k','linewidth',2)
end
for c = 1:length(indexes_North2)
plot([indexes_North2(c)/10,indexes_North2(c)/10],[peakValues_North2(c),wf.north_ionosphere(indexes_North2(c))],'r','linewidth',2)
end
for c = 1:length(indexes_South1)
plot([indexes_South1(c)/10,indexes_South1(c)/10],[(-1)*peakValues_South1(c),wf.south_ionosphere(indexes_South1(c))],'k','linewidth',2)
end
for c = 1:length(indexes_South2)
plot([indexes_South2(c)/10,indexes_South2(c)/10],[(-1)*peakValues_South2(c),wf.south_ionosphere(indexes_South2(c))],'r','linewidth',2)
end


%yt=[10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)

xlabel('East Jovigraphic Longitude','fontsize',18) % x-axis label
ylabel('Sys III \theta','fontsize',18) % y-axis label
%h_legend = legend('Ne','O+', 'O++', 'O+Hot', 'Location','best');
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
xlabel('West Jovigraphic Longitude','fontsize',18) % x-axis label
title(['Integer Wave Front Locations when Io is at \phi_{east} =  ' num2str(desired_phi)],'fontweight','bold','fontsize',20)
xlim([0 360])
set(gca,'xtick',xt)
set(gca, 'xdir', 'reverse')
set(gca,'FontSize',16)






%figure 2 is the scatter plot of wavefronts

% 
% figure(2)
% grid on
% plot(wf.list,wf.theta1,'k.','Markersize',10);
% hold on
% plot(wf.list,wf.theta2,'r.','Markersize',10);
% plot(desired_phi,0,'y.','Markersize',40);
% 
% %yt=[10:20:100 200:200:1000 2000 3000];
% %set(gca,'ytick',yt)
% set(gca,'yminorgrid','on')
% %xt=[0:1:6];
% %set(gca,'xtick',xt)
% set(gca,'xminorgrid','on')
% set(gca,'FontSize',16)
% title(['Integer Wave Front Locations when Io is at \phi =  ' num2str(desired_phi)],'fontweight','bold','fontsize',18)
% xlabel('East Jovigraphic Longitude','fontsize',18) % x-axis label
% ylabel('Sys III \theta','fontweight','bold','fontsize',18) % y-axis label
% %h_legend = legend('Ne','O+', 'O++', 'O+Hot', 'Location','best');
% %set(h_legend,'FontSize',20);
% xlim([0 360])
% % ylim([0 5])
% 
% 


%figure 3 is the "magentic frame" of the wavefronts, like Fran's paper in
%1984
figure(3)
grid on
plot(wf.phi1,sind(wf.theta1),'b.','linewidth',2);
hold on
plot(wf.phi2,sind(wf.theta2),'b.','linewidth',2);


[temp_iono_north_phi,order ] = sort(wf.north_ionosphere_phi);
temp_iono_north_theta = wf.north_ionosphere_theta(order,:);

[temp_iono_south_phi,order ] = sort(wf.south_ionosphere_phi);
temp_iono_south_theta = wf.south_ionosphere_theta(order,:);

% plot(temp_iono_north_phi,sind(temp_iono_north_theta),'k','linewidth',2);
% plot(temp_iono_south_phi,sind(temp_iono_south_theta),'k','linewidth',2);

% plot(wf.north_ionosphere_phi,wf.north_ionosphere_theta,'k','linewidth',2);
% plot(wf.south_ionosphere_phi,wf.south_ionosphere_theta,'k','linewidth',2);

%olda JRM09 ionosphere
% load('/Users/pahi9557/Documents/MATLAB/Workspaces/JRM09.mat')
% plot(JRM09.North.field_line,JRM09.North.fp_latitude,'m','linewidth',2);
% plot(JRM09.South.field_line,JRM09.South.fp_latitude,'m','linewidth',2);

% 
% plot(wf.north_ionosphere_phi(indexes_North2),sind(wf.north_ionosphere_theta(indexes_North2)),'*b','Markersize',8);
% plot(wf.south_ionosphere_phi(indexes_South2),sind(wf.south_ionosphere_theta(indexes_South2)),'*b','Markersize',8);
% plot(wf.north_ionosphere_phi(indexes_North1),sind(wf.north_ionosphere_theta(indexes_North1)),'*b','Markersize',8);
% plot(wf.south_ionosphere_phi(indexes_South1),sind(wf.south_ionosphere_theta(indexes_South1)),'*b','Markersize',8);
plot(desired_phi,0,'m.','Markersize',60);
text(desired_phi-1.5,0,'Io','fontname','Kannada MN','fontweight','bold','color','w','fontsize',16)
% 
% for c = 1:length(indexes_North1)
%     
% b = indexes_North1(c);
% 
% if b < 360
% a = characteristic.North.index(b);
% b = characteristic.North.index(b+1)-1;
% end
% 
% if b == 360
%     a = characteristic.North.index(b);
%     b = length(characteristic.North.there.phi);
% end
% 
% phieldr = characteristic.North.there.r(a:b);
% phieldtheta = characteristic.North.there.theta(a:b);
% phieldphi = characteristic.North.there.phi(a:b);
% 
% indices = find(phieldtheta<abs(peakValues_North1(c)));
% phieldr(indices) = [];
% phieldtheta(indices) = [];
% phieldphi(indices) = [];
% 
% plot(phieldphi,sind(phieldtheta),'k.','markersize',2);
% 
% end
% clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices;
% for c = 1:length(indexes_North2)
%     
% b = indexes_North2(c);
% 
% if b < 360
% a = characteristic.North.index(b);
% b = characteristic.North.index(b+1)-1;
% end
% 
% if b == 360
%     a = characteristic.North.index(b);
%     b = length(characteristic.North.there.phi);
% end
% 
% phieldr = characteristic.North.there.r(a:b);
% phieldtheta = characteristic.North.there.theta(a:b);
% phieldphi = characteristic.North.there.phi(a:b);
% 
% indices = find(phieldtheta<abs(peakValues_North2(c)));
% phieldr(indices) = [];
% phieldtheta(indices) = [];
% phieldphi(indices) = [];
% 
% plot(phieldphi,sind(phieldtheta),'r.','markersize',2);
% 
% end
% clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices;
% for c = 1:length(indexes_South1)
%     
% b = indexes_South1(c);
% 
% if b < 360
% a = characteristic.South.index(b);
% b = characteristic.South.index(b+1)-1;
% end
% 
% if b == 360
%     a = characteristic.South.index(b);
%     b = length(characteristic.South.there.phi);
% end
% 
% phieldr = characteristic.South.there.r(a:b);
% phieldtheta = characteristic.South.there.theta(a:b);
% phieldphi = characteristic.South.there.phi(a:b);
% 
% indices = find(abs(phieldtheta)<abs(peakValues_South1(c)));
% phieldr(indices) = [];
% phieldtheta(indices) = [];
% phieldphi(indices) = [];
% 
% plot(phieldphi,sind(phieldtheta),'k.','markersize',2);
% 
% end
% clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices;
% for c = 1:length(indexes_South2)
%     
% b = indexes_South2(c);
% 
% if b < 360
% a = characteristic.South.index(b);
% b = characteristic.South.index(b+1)-1;
% end
% 
% if b == 360
%     a = characteristic.South.index(b);
%     b = length(characteristic.South.there.phi);
% end
% 
% phieldr = characteristic.South.there.r(a:b);
% phieldtheta = characteristic.South.there.theta(a:b);
% phieldphi = characteristic.South.there.phi(a:b);
% 
% indices = find(abs(phieldtheta)<abs(peakValues_South2(c)));
% phieldr(indices) = [];
% phieldtheta(indices) = [];
% phieldphi(indices) = [];
% 
% plot(phieldphi,sind(phieldtheta),'r.','markersize',2);
% 
% end
% clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices;
% 
% for c = 1:length(indexes_North1)
% plot([indexes_North1(c),indexes_North1(c)],[peakValues_North1(c),wf.north_ionosphere(indexes_North1(c))],'k','linewidth',2)
% end
% for c = 1:length(indexes_North2)
% plot([indexes_North2(c),indexes_North2(c)],[peakValues_North2(c),wf.north_ionosphere(indexes_North2(c))],'r','linewidth',2)
% end
% for c = 1:length(indexes_South1)
% plot([indexes_South1(c),indexes_South1(c)],[(-1)*peakValues_South1(c),wf.south_ionosphere(indexes_South1(c))],'k','linewidth',2)
% end
% for c = 1:length(indexes_South2)
% plot([indexes_South2(c),indexes_South2(c)],[(-1)*peakValues_South2(c),wf.south_ionosphere(indexes_South2(c))],'r','linewidth',2)
% end



%%%for plotting field lines on top

% for counter1 = 1:10:360
% 
% if counter1 < 360
% a = Index.Line_Index(counter1);
% b = Index.Line_Index(counter1 +1) - 1;
% end
% 
% if counter1 == 360
% a = Index.Line_Index(counter1);
% b = length(sorted_lines_1_360.phi); %last value in the list
% end
% 
% plot(sorted_lines_1_360.phi(a:b),sorted_lines_1_360.theta(a:b),'b.','linewidth',2);
% %ax1 = gca; % current axes
% end


ylim([sind(-90) sind(90)])
set(gca,'ytick',sind(-90:10:90), 'YTickLabel',{'-90','','','','','', '-30','','','  0','','',' 30','','','','','',' 90' })
%set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)

xlabel('East Jovigraphic Longitude','fontsize',18) % x-axis label
ylabel('Sys III \theta','fontsize',18) % y-axis label
%h_legend = legend('Ne','O+', 'O++', 'O+Hot', 'Location','best');
%set(h_legend,'FontSize',20);
xlim([0 360])


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
xlabel('West Jovigraphic Longitude','fontsize',18) % x-axis label
title(['Integer Wave Front Locations when Io is at \phi_{east} =  ' num2str(desired_phi)],'fontweight','bold','fontsize',20)
xlim([0 360])
set(gca,'xtick',xt)
set(gca, 'xdir', 'reverse')
set(gca,'FontSize',16)


set(gcf, 'Position', [100, 100, 2000, 1200])







% 
% 
% ztheta1 = smooth(wf.theta1,15);
% ztheta2 = smooth(wf.theta2,15);
% zphi1 = smooth(wf.phi1,15);
% zphi2 = smooth(wf.phi2,15);
% 
% %use built in peak fitting function to find which field lines have alfven
% %waves reaching the inopshere
% [peakValues_North1, indexes_North1] = findpeaks(smooth(ztheta1));
% [peakValues_North2, indexes_North2] = findpeaks(smooth(ztheta2));
% [peakValues_South1, indexes_South1] = findpeaks((-1)*smooth(ztheta1));
% [peakValues_South2, indexes_South2] = findpeaks((-1)*smooth(ztheta2));
% 
% %tilt frame mono color
% figure(4)
% grid on
% hold on
% 
% for cnt = 1:length(zphi1)-1
%     diff = zphi1(cnt+1) - zphi1(cnt);
%     if abs(diff) > 3
%         zphi1(cnt) = NaN;
%         ztheta1(cnt) = NaN;
%     end
% end
% for cnt = 1:length(zphi2)-1
%     diff = zphi2(cnt+1) - zphi2(cnt);
%     if abs(diff) > 3
%         zphi2(cnt) = NaN;
%         ztheta2(cnt) = NaN;
%     end
% end
% clear cnt; clear diff;
% 
% plot(zphi1,sind(ztheta1),'k','linewidth',2);
% plot(zphi2,sind(ztheta2),'k','linewidth',2);
% 
% 
% 
% [temp_iono_north_phi,order ] = sort(wf.north_ionosphere_phi);
% temp_iono_north_theta = wf.north_ionosphere_theta(order,:);
% 
% [temp_iono_south_phi,order ] = sort(wf.south_ionosphere_phi);
% temp_iono_south_theta = wf.south_ionosphere_theta(order,:);
% 
% % plot(temp_iono_north_phi,sind(temp_iono_north_theta),'k','linewidth',2);
% % plot(temp_iono_south_phi,sind(temp_iono_south_theta),'k','linewidth',2);
% 
% % plot(wf.north_ionosphere_phi(indexes_North2),sind(wf.north_ionosphere_theta(indexes_North2)),'*b','Markersize',8);
% % plot(wf.south_ionosphere_phi(indexes_South2),sind(wf.south_ionosphere_theta(indexes_South2)),'*b','Markersize',8);
% % plot(wf.north_ionosphere_phi(indexes_North1),sind(wf.north_ionosphere_theta(indexes_North1)),'*b','Markersize',8);
% % plot(wf.south_ionosphere_phi(indexes_South1),sind(wf.south_ionosphere_theta(indexes_South1)),'*b','Markersize',8);
% plot(desired_phi,0,'.','color',1/255*[255 0 127],'Markersize',90);
% text(desired_phi-2,0,'Io','fontname','Kannada MN','fontweight','bold','color','w','fontsize',16)
% 
% for c = 1:length(indexes_North1)
%     
% b = indexes_North1(c);
% 
% if b < 3600
% a = characteristic.North.index(b);
% b = characteristic.North.index(b+1)-1;
% end
% 
% if b == 3600
%     a = characteristic.North.index(b);
%     b = length(characteristic.North.there.phi);
% end
% 
% phieldr = characteristic.North.there.r(a:b);
% phieldtheta = characteristic.North.there.theta(a:b);
% phieldphi = characteristic.North.there.phi(a:b);
% phieldB = characteristic.North.there.B(a:b);
% 
% indices = find(phieldtheta<abs(peakValues_North1(c)));
% phieldr(indices) = [];
% phieldtheta(indices) = [];
% phieldphi(indices) = [];
% phieldB(indices) = [];
% 
% [z,l] = max(phieldphi);
% phieldr = [phieldr(1:l) NaN phieldr(l+1:end)];
% phieldtheta= [phieldtheta(1:l) NaN phieldtheta(l+1:end)];
% phieldphi= [phieldphi(1:l) NaN phieldphi(l+1:end)];
% phieldB= [phieldB(1:l) NaN phieldB(l+1:end)];
% 
% plot(phieldphi,sind(phieldtheta),'k','linewidth',2.8);
% 
% end
% clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices;
% for c = 1:length(indexes_North2)
%     
% b = indexes_North2(c);
% 
% if b < 3600
% a = characteristic.North.index(b);
% b = characteristic.North.index(b+1)-1;
% end
% 
% if b == 3600
%     a = characteristic.North.index(b);
%     b = length(characteristic.North.there.phi);
% end
% 
% phieldr = characteristic.North.there.r(a:b);
% phieldtheta = characteristic.North.there.theta(a:b);
% phieldphi = characteristic.North.there.phi(a:b);
% phieldB = characteristic.North.there.B(a:b);
% 
% indices = find(phieldtheta<abs(peakValues_North2(c)));
% phieldr(indices) = [];
% phieldtheta(indices) = [];
% phieldphi(indices) = [];
% phieldB(indices) = [];
% 
% [z,l] = max(phieldphi);
% phieldr = [phieldr(1:l) NaN phieldr(l+1:end)];
% phieldtheta= [phieldtheta(1:l) NaN phieldtheta(l+1:end)];
% phieldphi= [phieldphi(1:l) NaN phieldphi(l+1:end)];
% phieldB= [phieldB(1:l) NaN phieldB(l+1:end)];
% 
% plot(phieldphi,sind(phieldtheta),'k','linewidth',2.8);
% 
% end
% clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices;
% for c = 1:length(indexes_South1)
%     
% b = indexes_South1(c);
% 
% if b < 3600
% a = characteristic.South.index(b);
% b = characteristic.South.index(b+1)-1;
% end
% 
% if b == 3600
%     a = characteristic.South.index(b);
%     b = length(characteristic.South.there.phi);
% end
% 
% phieldr = characteristic.South.there.r(a:b);
% phieldtheta = characteristic.South.there.theta(a:b);
% phieldphi = characteristic.South.there.phi(a:b);
% 
% indices = find(abs(phieldtheta)<abs(peakValues_South1(c)));
% phieldr(indices) = [];
% phieldtheta(indices) = [];
% phieldphi(indices) = [];
% 
% [z,l] = max(phieldphi);
% phieldr = [phieldr(1:l) NaN phieldr(l+1:end)];
% phieldtheta= [phieldtheta(1:l) NaN phieldtheta(l+1:end)];
% phieldphi= [phieldphi(1:l) NaN phieldphi(l+1:end)];
% 
% 
% plot(phieldphi,sind(phieldtheta),'k','linewidth',2.8);
% 
% end
% clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices;
% for c = 1:length(indexes_South2)
%     
% b = indexes_South2(c);
% 
% if b < 3600
% a = characteristic.South.index(b);
% b = characteristic.South.index(b+1)-1;
% end
% 
% if b == 3600
%     a = characteristic.South.index(b);
%     b = length(characteristic.South.there.phi);
% end
% 
% phieldr = characteristic.South.there.r(a:b);
% phieldtheta = characteristic.South.there.theta(a:b);
% phieldphi = characteristic.South.there.phi(a:b);
% 
% indices = find(abs(phieldtheta)<abs(peakValues_South2(c)));
% phieldr(indices) = [];
% phieldtheta(indices) = [];
% phieldphi(indices) = [];
% 
% [z,l] = max(phieldphi);
% phieldr = [phieldr(1:l) NaN phieldr(l+1:end)];
% phieldtheta= [phieldtheta(1:l) NaN phieldtheta(l+1:end)];
% phieldphi= [phieldphi(1:l) NaN phieldphi(l+1:end)];
% 
% 
% plot(phieldphi,sind(phieldtheta),'k','linewidth',2.8);
% 
% end
% clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices; clear l; clear z;
% 
% 
% set(gca,'ytick',sind(-90:10:90), 'YTickLabel',{'-90','','','','','', '-30','','','  0','','',' 30','','','','','',' 90' })
% %set(gca,'yminorgrid','on')
% %xt=[0:1:6];
% %set(gca,'xtick',xt)
% set(gca,'xminorgrid','on')
% set(gca,'FontSize',16)
% 
% xlabel('East Jovigraphic Longitude','fontsize',18) % x-axis label
% ylabel('Sys III \theta','fontsize',18) % y-axis label
% %h_legend = legend('Ne','O+', 'O++', 'O+Hot', 'Location','best');
% %set(h_legend,'FontSize',20);
% xlim([0 360])
% % ylim([0 5])
% 
% %generating new x tixk values
% xt= sort(360 - xticks);
% %%getting rid of old tick marks at top
%  box off
% ax1 = gca;
% ax3 = axes('Position', get(ax1, 'Position'), 'FontSize', 10,...
%            'Color','None','XColor','k','YColor','k', 'LineWidth', 1,...
%            'XAxisLocation','top', 'XTick', [],... 
%            'YAxisLocation','right', 'YTick', []);
% linkaxes([ax1, ax3])
% 
% %adding new top axis
% ax1_pos = get(gca,'Position');
% ax2 = axes('Position', ax1_pos,...
%            'XAxisLocation', 'top',... 
%            'YAxisLocation', 'right',...
%            'Color', 'none');
% set(ax2,'YColor','none');
% %title('2^{nd} Harmonics');
% xlabel('West Jovigraphic Longitude','fontsize',18) % x-axis label
% title(['Integer Wave Front Locations when Io is at \phi_{east} =  ' num2str(desired_phi)],'fontweight','bold','fontsize',20)
% xlim([0 360])
% set(gca,'xtick',xt)
% set(gca, 'xdir', 'reverse')
% set(gca,'FontSize',16)




%full planet
%%%%
% 
% 
% %figure 5 is the 3D View of the predictions
% figure(5)
% x = wf.south_ionosphere_r(indexes_South).*sind(90 - wf.south_ionosphere_theta(indexes_South)).*cosd(wf.south_ionosphere_phi(indexes_South));
% y = wf.south_ionosphere_r(indexes_South).*sind(90 - wf.south_ionosphere_theta(indexes_South)).*sind(wf.south_ionosphere_phi(indexes_South));
% z = wf.south_ionosphere_r(indexes_South).*cosd(90 - wf.south_ionosphere_theta(indexes_South));
% plot3(x,y,z,'.','color',[0 .75 .75],...
% 'MarkerSize',10)
% hold on
% x = wf.north_ionosphere_r(indexes_North).*sind(90 - wf.north_ionosphere_theta(indexes_North)).*cosd(wf.north_ionosphere_phi(indexes_North));
% y = wf.north_ionosphere_r(indexes_North).*sind(90 - wf.north_ionosphere_theta(indexes_North)).*sind(wf.north_ionosphere_phi(indexes_North));
% z = wf.north_ionosphere_r(indexes_North).*cosd(90 - wf.north_ionosphere_theta(indexes_North));
% plot3(x,y,z,'.','color',[0 .75 .75],...
% 'MarkerSize',10)
% daspect([1 1 1])
% axis tight
% lighting gouraud
% xlim([-2.5 2.5])
% ylim([-2.5 2.5])
% zlim([-2.5 2.5])
% set(gca,'color','white')
% set(gcf,'color','white')
% set(gcf, 'InvertHardCopy', 'off');
% set(figure(4), 'Position', get(0, 'Screensize'));
% set(gca,'xcolor','w','ycolor','w','zcolor','w','xminorgrid','off','yminorgrid','off','zminorgrid','off')
% xlabel('System 3 x (R_{J})','fontweight','bold','fontsize',22) 
% ylabel('System 3 y (R_{J})','fontweight','bold','fontsize',22)
% zlabel('System 3 z (R_{J})','fontweight','bold','fontsize',22)
% view(3);
% [x,y,z] = sphere(100);
% r=0.92;
% xr = x*r;
% yr = y*r;
% zr = z*r;
% xc = 0;
% yc = 0;
% zc = 0;
% img = imread('jupitermap2.jp2'); % credit  James Hastings-Trew
% img = flipud(img  );
% hSurface = warp(xr+xc,yr+yc,zr+zc,img);
% for phi_counter = 90:90:359
% text(1.1*sind(90)*cosd(phi_counter),1.1*sind(90)*sind(phi_counter),1.1*cosd(90),[num2str(phi_counter) '^{\circ}'],'fontweight','bold','fontname','Kannada MN','fontsize',18)
% end
% text(1.1*sind(90)*cosd(0),1.1*sind(90)*sind(0),1.1*cosd(90),['\phi_{east} = ' num2str(0) '^{\circ}'],'fontweight','bold','fontname','Kannada MN','fontsize',18)
% for phi_counter = 90:90:359
% text(1.5*sind(90)*cosd(phi_counter),1.5*sind(90)*sind(phi_counter),1.5*cosd(90),[num2str(360 - phi_counter) '^{\circ}'],'fontweight','bold','color','blue','fontname','Kannada MN','fontsize',18)
% end
% text(1.5*sind(90)*cosd(0),1.5*sind(90)*sind(0),1.5*cosd(90),['\phi_{west}' num2str(360) '^{\circ}'],'fontweight','bold','color','blue','fontname','Kannada MN','fontsize',18)
% %%%%%

% 
% %%%northern hemisphere prediction
% %%%
% figure(5)
% %subplot(1,2,1)
% x = wf.north_ionosphere_r(indexes_North).*sind(90 - wf.north_ionosphere_theta(indexes_North)).*cosd(wf.north_ionosphere_phi(indexes_North));
% y = wf.north_ionosphere_r(indexes_North).*sind(90 - wf.north_ionosphere_theta(indexes_North)).*sind(wf.north_ionosphere_phi(indexes_North));
% plot(x,y,'.','color',[0 .75 .75],...
% 'MarkerSize',20)
% hold on
% 
% for c = 1:length(wf.north_ionosphere_r(indexes_North))
% pheyez = 360 - wf.north_ionosphere_phi(indexes_North);
% s = num2str(round(pheyez(c)));
% text(x(c),y(c),s,'fontname','Kannada MN','fontweight','bold','color','red','fontsize',14)
% end
% text(-0.4,0,'West Longitudes','fontname','Kannada MN','fontweight','bold','color','red','fontsize',18)
% % text(x,y,'\phi_{East} = 270','fontweight','bold','fontname','Kannada MN','color','red','fontsize',18)
% % 
% % x = mean(wf.north_ionosphere_r(indexes_North)).*sind(90 - 70).*cosd(0);
% % y = mean(wf.north_ionosphere_r(indexes_North)).*sind(90 - 70).*sind(0);
% % text(x,y,'\phi_{East} = 0','fontweight','bold','fontname','Kannada MN','color','red','fontsize',18)
% % 
% % x = mean(wf.north_ionosphere_r(indexes_North)).*sind(90 - 70).*cosd(90);
% % y = mean(wf.north_ionosphere_r(indexes_North)).*sind(90 - 70).*sind(90);
% % text(x,y,'\phi_{East} = 90','fontweight','bold','fontname','Kannada MN','color','red','fontsize',18)
% % 
% % x = mean(wf.north_ionosphere_r(indexes_North)).*sind(90 - 70).*cosd(180);
% % y = mean(wf.north_ionosphere_r(indexes_North)).*sind(90 - 70).*sind(180);
% % text(x,y,'\phi_{East} = 180','fontweight','bold','fontname','Kannada MN','color','red','fontsize',18)
% % 
% % text(-0.62,0.2,'\phi_{East} = 270','fontweight','bold','fontname','Kannada MN','fontsize',18)
% % text(-0.1,-0.35,'\phi_{East} = 180','fontweight','bold','fontname','Kannada MN','fontsize',18)
% % text(0.075,0.35,'\phi_{East} = 0','fontweight','bold','fontname','Kannada MN','fontsize',18)
% % text(-0.6,0.225 + .02,'\phi_{West} = 90','fontweight','bold','fontname','Kannada MN','fontsize',18)
% % text(-0.1,-0.375 - .02,'\phi_{West} = 180','fontweight','bold','fontname','Kannada MN','fontsize',18)
% % text(0.075,0.375 + .02,'\phi_{West} = 360','fontweight','bold','fontname','Kannada MN','fontsize',18)
% daspect([1 1 1])
% axis tight
% lighting gouraud
% ylim([-.5 .4])
% xlim([-.7 .2])
% set(gca,'color','white')
% set(gcf,'color','white')
% set(gcf, 'InvertHardCopy', 'off');
% % set(figure(5), 'Position', get(0, 'Screensize'));
% set(gca,'xcolor','w','ycolor','w','zcolor','w','xminorgrid','off','yminorgrid','off','zminorgrid','off')
% title('Northern Hemisphere','fontweight','bold','fontsize',18)
% %%%%%
% 
% % 
% %%%Southern hemisphere
% %%%
% figure(5)
% subplot(1,2,2)
% x = wf.south_ionosphere_r(indexes_South).*sind(90 - wf.south_ionosphere_theta(indexes_South)).*cosd(wf.south_ionosphere_phi(indexes_South));
% y = wf.south_ionosphere_r(indexes_South).*sind(90 - wf.south_ionosphere_theta(indexes_South)).*sind(wf.south_ionosphere_phi(indexes_South));
% plot(x,y,'.','color',[0 .75 .75],...
% 'MarkerSize',20)
% hold on
% text(0.1,0.28,'\phi_{East} = 90','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(-0.18,0,'\phi_{East} = 180','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(0,-0.45,'\phi_{East} = 270','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(0.3,-.1,'\phi_{East} = 0','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(0.1,0.255 - .02,'\phi_{West} = 270','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(-0.18,-0.025 - .02,'\phi_{West} = 180','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(0,-0.425 + .02,'\phi_{West} = 90','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(0.3,-0.075 + .02,'\phi_{West} = 360','fontweight','bold','fontname','Kannada MN','fontsize',18)
% 
% daspect([1 1 1])
% axis tight
% lighting gouraud
% ylim([-.55 .34])
% xlim([-.3 .5])
% set(gca,'color','white')
% set(gcf,'color','white')
% set(gcf, 'InvertHardCopy', 'off');
% %set(figure(5), 'Position', get(0, 'Screensize'));
% set(gca,'xcolor','w','ycolor','w','zcolor','w','xminorgrid','off','yminorgrid','off','zminorgrid','off')
% title('Southern Hemisphere','fontweight','bold','fontsize',18)
% 
% 
% annotation('textbox', [0 0.9 1 0], ...
%     'String', ['IFP when Io is at \phi_{east} = ' num2str(desired_phi) ' , \phi_{west} = ' num2str(360-desired_phi)],'fontweight','bold','fontsize',24,'fontname','Kannada MN', ...
%     'EdgeColor', 'none', ...
%     'HorizontalAlignment', 'center')
% set(figure(5), 'Position', get(0, 'Screensize'));
% %%%%