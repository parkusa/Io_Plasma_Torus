
% first run HDWave_fronts_model at desired_phi = 224




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
[peakValues_North1, indexes_North1] = findpeaks(smooth(wf.theta1,10),'MinPeakDistance',20,'MinPeakProminence',5);
[peakValues_North2, indexes_North2] = findpeaks(smooth(wf.theta2,10),'MinPeakDistance',20,'MinPeakProminence',5);

%%%%filtering out points not high enough to reach the ionosphere
I = [];
for c = 1:length(peakValues_North1) 
    if peakValues_North1(c) < 6    
        I = [I c]; 
    end
end
peakValues_North1(I) = [];
indexes_North1(I) = [];
clear I; clear c;

I = [];
for c = 1:length(peakValues_North2) 
    if peakValues_North2(c) < 6    
        I = [I c]; 
    end
end
peakValues_North2(I) = [];
indexes_North2(I) = [];
clear I; clear c;

[peakValues_South1, indexes_South1] = findpeaks((-1)*smooth(wf.theta1,10),'MinPeakDistance',40,'MinPeakProminence',5);
[peakValues_South2, indexes_South2] = findpeaks((-1)*smooth(wf.theta2,10),'MinPeakDistance',40,'MinPeakProminence',5);


I = [];
for c = 1:length(peakValues_South1) 
    if (-1)*peakValues_South1(c) > -6    
        I = [I c]; 
    end
end
peakValues_South1(I) = [];
indexes_South1(I) = [];
clear I; clear c;


I = [];
for c = 1:length(peakValues_South2) 
    if (-1)*peakValues_South2(c) > -6    
        I = [I c]; 
    end
end
peakValues_South2(I) = [];
indexes_South2(I) = [];
clear I; clear c;

%condensing indexes
peakValues_North = [peakValues_North1' peakValues_North2'];
peakValues_South = [peakValues_South1' peakValues_South2'];
%condensing indexes
indexes_North = [indexes_North1' indexes_North2']';
indexes_South = [indexes_South1' indexes_South2']';












figure(2)
grid on
plot(wf.list,smooth(wf.theta1),'k','linewidth',2);
hold on
plot(wf.list,smooth(wf.theta2),'r','linewidth',2);


[x, I] = sort(indexes_North); 
north_filter_phi = indexes_North(I)/10;
north_filter_theta = (peakValues_North(I)-12);
north_filter_phi = [0 north_filter_phi' 360]';
north_filter_theta = [north_filter_theta(1) north_filter_theta north_filter_theta(end)];
north_filter_theta = smooth(north_filter_theta,30);
plot(north_filter_phi,north_filter_theta,'g','linewidth',4);

[x, I] = sort(indexes_South); 
south_filter_phi = indexes_South(I)/10;
south_filter_theta = ((-1)*peakValues_South(I)+12);
south_filter_phi = [0 south_filter_phi' 360]';
south_filter_theta = [south_filter_theta(1) south_filter_theta south_filter_theta(end)];
south_filter_theta = smooth(south_filter_theta,30);
plot(south_filter_phi,south_filter_theta,'g','linewidth',4);



% plot(wf.list,smooth(wf.north_ionosphere,60),'k','linewidth',2);
% plot(wf.list,smooth(wf.south_ionosphere),'k','linewidth',2);

% 
% plot(wf.list(indexes_North2),wf.north_ionosphere(indexes_North2),'*b','Markersize',8);
% plot(wf.list(indexes_South2),wf.south_ionosphere(indexes_South2),'*b','Markersize',8);
% plot(wf.list(indexes_North1),wf.north_ionosphere(indexes_North1),'*b','Markersize',8);
% plot(wf.list(indexes_South1),wf.south_ionosphere(indexes_South1),'*b','Markersize',8);

plot(desired_phi,0,'y.','Markersize',50);
% 
% for c = 1:length(indexes_North1)
% plot([indexes_North1(c)/10,indexes_North1(c)/10],[peakValues_North1(c),wf.north_ionosphere(indexes_North1(c))],'k','linewidth',2)
% end
% for c = 1:length(indexes_North2)
% plot([indexes_North2(c)/10,indexes_North2(c)/10],[peakValues_North2(c),wf.north_ionosphere(indexes_North2(c))],'r','linewidth',2)
% end
% for c = 1:length(indexes_South1)
% plot([indexes_South1(c)/10,indexes_South1(c)/10],[(-1)*peakValues_South1(c),wf.south_ionosphere(indexes_South1(c))],'k','linewidth',2)
% end
% for c = 1:length(indexes_South2)
% plot([indexes_South2(c)/10,indexes_South2(c)/10],[(-1)*peakValues_South2(c),wf.south_ionosphere(indexes_South2(c))],'r','linewidth',2)
% end


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











%%%%figure 1 is the original tracking the wavefronts plot

figure(1)
subplot(2,2,[1,2])

ztheta1 = wf.theta1;
ztheta2 = wf.theta2;
zphi1 = wf.phi1;
zphi2 = wf.phi2;
% 
% [peakValues_North1, indexes_North1] = findpeaks(smooth(ztheta1));
% [peakValues_North2, indexes_North2] = findpeaks(smooth(ztheta2));
% [peakValues_South1, indexes_South1] = findpeaks((-1)*smooth(ztheta1));
% [peakValues_South2, indexes_South2] = findpeaks((-1)*smooth(ztheta2));

%tilt frame mono color

grid on
hold on

for cnt = 1:length(zphi1)-1
    diff = zphi1(cnt+1) - zphi1(cnt);
    if abs(diff) > 3
        zphi1(cnt) = NaN;
        ztheta1(cnt) = NaN;
    end
end
for cnt = 1:length(zphi2)-1
    diff = zphi2(cnt+1) - zphi2(cnt);
    if abs(diff) > 3
        zphi2(cnt) = NaN;
        ztheta2(cnt) = NaN;
    end
end
clear cnt; clear diff;

plot(zphi1,sind(ztheta1),'k','linewidth',2);
plot(zphi2,sind(ztheta2),'k','linewidth',2);



[temp_iono_north_phi,order ] = sort(wf.north_ionosphere_phi);
temp_iono_north_theta = wf.north_ionosphere_theta(order,:);

[temp_iono_south_phi,order ] = sort(wf.south_ionosphere_phi);
temp_iono_south_theta = wf.south_ionosphere_theta(order,:);

% plot(temp_iono_north_phi,sind(temp_iono_north_theta),'k','linewidth',2);
% plot(temp_iono_south_phi,sind(temp_iono_south_theta),'k','linewidth',2);

% plot(wf.north_ionosphere_phi(indexes_North2),sind(wf.north_ionosphere_theta(indexes_North2)),'*b','Markersize',8);
% plot(wf.south_ionosphere_phi(indexes_South2),sind(wf.south_ionosphere_theta(indexes_South2)),'*b','Markersize',8);
% plot(wf.north_ionosphere_phi(indexes_North1),sind(wf.north_ionosphere_theta(indexes_North1)),'*b','Markersize',8);
% plot(wf.south_ionosphere_phi(indexes_South1),sind(wf.south_ionosphere_theta(indexes_South1)),'*b','Markersize',8);
plot(desired_phi,0,'.','color',1/255*[255 0 127],'Markersize',90);
text(desired_phi-2,0,'Io','fontname','Kannada MN','fontweight','bold','color','w','fontsize',16)

for c = 1:length(indexes_North1)
    
b = indexes_North1(c);

if b < 3600
a = characteristic.North.index(b);
b = characteristic.North.index(b+1)-1;
end

if b == 3600
    a = characteristic.North.index(b);
    b = length(characteristic.North.there.phi);
end

phieldr = characteristic.North.there.r(a:b);
phieldtheta = characteristic.North.there.theta(a:b);
phieldphi = characteristic.North.there.phi(a:b);
phieldB = characteristic.North.there.B(a:b);

indices = find(phieldtheta<abs(peakValues_North1(c)));
phieldr(indices) = [];
phieldtheta(indices) = [];
phieldphi(indices) = [];
phieldB(indices) = [];

[z,l] = max(phieldphi);
phieldr = [phieldr(1:l) NaN phieldr(l+1:end)];
phieldtheta= [phieldtheta(1:l) NaN phieldtheta(l+1:end)];
phieldphi= [phieldphi(1:l) NaN phieldphi(l+1:end)];
phieldB= [phieldB(1:l) NaN phieldB(l+1:end)];

%plot(phieldphi,sind(phieldtheta),'k','linewidth',2.4);

end
clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices;
for c = 1:length(indexes_North2)
    
b = indexes_North2(c);

if b < 3600
a = characteristic.North.index(b);
b = characteristic.North.index(b+1)-1;
end

if b == 3600
    a = characteristic.North.index(b);
    b = length(characteristic.North.there.phi);
end

phieldr = characteristic.North.there.r(a:b);
phieldtheta = characteristic.North.there.theta(a:b);
phieldphi = characteristic.North.there.phi(a:b);
phieldB = characteristic.North.there.B(a:b);

indices = find(phieldtheta<abs(peakValues_North2(c)));
phieldr(indices) = [];
phieldtheta(indices) = [];
phieldphi(indices) = [];
phieldB(indices) = [];

[z,l] = max(phieldphi);
phieldr = [phieldr(1:l) NaN phieldr(l+1:end)];
phieldtheta= [phieldtheta(1:l) NaN phieldtheta(l+1:end)];
phieldphi= [phieldphi(1:l) NaN phieldphi(l+1:end)];
phieldB= [phieldB(1:l) NaN phieldB(l+1:end)];

%plot(phieldphi,sind(phieldtheta),'k','linewidth',2.4);

end
clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices;
for c = 1:length(indexes_South1)
    
b = indexes_South1(c);

if b < 3600
a = characteristic.South.index(b);
b = characteristic.South.index(b+1)-1;
end

if b == 3600
    a = characteristic.South.index(b);
    b = length(characteristic.South.there.phi);
end

phieldr = characteristic.South.there.r(a:b);
phieldtheta = characteristic.South.there.theta(a:b);
phieldphi = characteristic.South.there.phi(a:b);

indices = find(abs(phieldtheta)<abs(peakValues_South1(c)));
phieldr(indices) = [];
phieldtheta(indices) = [];
phieldphi(indices) = [];

[z,l] = max(phieldphi);
phieldr = [phieldr(1:l) NaN phieldr(l+1:end)];
phieldtheta= [phieldtheta(1:l) NaN phieldtheta(l+1:end)];
phieldphi= [phieldphi(1:l) NaN phieldphi(l+1:end)];


%plot(phieldphi,sind(phieldtheta),'k','linewidth',2.4);

end
clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices;
for c = 1:length(indexes_South2)
    
b = indexes_South2(c);

if b < 3600
a = characteristic.South.index(b);
b = characteristic.South.index(b+1)-1;
end

if b == 3600
    a = characteristic.South.index(b);
    b = length(characteristic.South.there.phi);
end

phieldr = characteristic.South.there.r(a:b);
phieldtheta = characteristic.South.there.theta(a:b);
phieldphi = characteristic.South.there.phi(a:b);

indices = find(abs(phieldtheta)<abs(peakValues_South2(c)));
phieldr(indices) = [];
phieldtheta(indices) = [];
phieldphi(indices) = [];

[z,l] = max(phieldphi);
phieldr = [phieldr(1:l) NaN phieldr(l+1:end)];
phieldtheta= [phieldtheta(1:l) NaN phieldtheta(l+1:end)];
phieldphi= [phieldphi(1:l) NaN phieldphi(l+1:end)];


%plot(phieldphi,sind(phieldtheta),'k','linewidth',2.4);

end
clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices; clear l; clear z;


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
% ylim([0 5])

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



