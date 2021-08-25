counter10 = 360 - desired_phi;


%sorting all of the wavefronts by longitude, and the associated thetas and
%phis, and r's
[wf.list, I] = sort(wf.list); 
wf.index_list = wf.list;
wf.time_stamp = wf.time_stamp(I,:);
wf.r1 = wf.r1(I,:);
wf.r2 = wf.r2(I,:);
wf.theta1 = wf.theta1(I,:);
wf.theta2 = wf.theta2(I,:);
wf.phi1 = wf.phi1(I,:);
wf.phi2 = wf.phi2(I,:);
clear I;



%%%%filtering out points that Io launched > 350 degrees ago
%%%%
I = [];
for c = 1:length(wf.time_stamp)
    if wf.time_stamp(c) > 761.8
        I = [I c];
    end
end
wf.theta2(I) = NaN;
wf.phi2(I) = NaN;
wf.theta1(I) = NaN;
wf.phi1(I) = NaN;
wf.list(I) = NaN;
clear I; clear c;
%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%filtering out points too high and causing smooth to do weird things for
%%%%
I = [];
for c = 1:length(wf.theta1) 

    if wf.theta1(c) > 5
        if wf.theta1(c) > 25 + interp1(north_filter_phi,north_filter_theta,wf.phi1(c))
            I = [I c];
        end
    end

    if wf.theta1(c) < 5
        if wf.theta1(c) < -25 + interp1(south_filter_phi,south_filter_theta,wf.phi1(c))
            I = [I c];
        end
    end

end
clear c;
V = [];
for c = 1:length(wf.theta2) 

    if wf.theta2(c) > 5
        if wf.theta2(c) > 25 + interp1(north_filter_phi,north_filter_theta,wf.phi2(c))
            V = [V c];
        end
    end

    if wf.theta2(c) < 5
        if wf.theta2(c) < -25 + interp1(south_filter_phi,south_filter_theta,wf.phi2(c))
            V = [V c];
        end
    end

end
I = [I V];

wf.index_theta2 = wf.theta2;
wf.index_phi2 = wf.phi2;
wf.index_theta1 = wf.theta1;
wf.index_phi1 = wf.phi1;


wf.theta2(I) = [];
wf.phi2(I) = [];
wf.theta1(I) = [];
wf.phi1(I) = [];
wf.list(I) = [];
clear I; clear V; clear c;



%use built in peak fitting function to find which field lines have alfven
%waves reaching the inopshere
[peakValues_North1, indexes_North1] = findpeaks(wf.theta1,'MinPeakDistance',20,'MinPeakProminence',5);
[peakValues_North2, indexes_North2] = findpeaks(wf.theta2,'MinPeakDistance',20,'MinPeakProminence',5);

%%%%filtering out points not high enough to reach the ionosphere
I = [];
for c = 1:length(peakValues_North1) 
    if peakValues_North1(c) < interp1(north_filter_phi,north_filter_theta,indexes_North1(c))    
        I = [I c]; 
    end
end
peakValues_North1(I) = [];
indexes_North1(I) = [];
%indiexes_North1(I) = [];
clear I; clear c;
I = [];
for c = 1:length(peakValues_North2) 
    if peakValues_North2(c) < interp1(north_filter_phi,north_filter_theta,indexes_North2(c))    
        I = [I c]; 
    end
end
peakValues_North2(I) = [];
indexes_North2(I) = [];
%indiexes_North2(I) = [];
clear I; clear c;


I = [];
for c = 1:length(peakValues_North1) 
    if peakValues_North1(c) < 9 %I used 6 before, this may be too large
        I = [I c]; 
    end
    if peakValues_North1(c) == 0
        I = [I c];
    end
end
peakValues_North1(I) = [];
indexes_North1(I) = [];
%indiexes_North1(I) = [];
clear I; clear c;
I = [];
for c = 1:length(peakValues_North2) 
    if peakValues_North2(c) < 9 %I used 6 before, this may be too large    
        I = [I c]; 
    end
    if peakValues_North2(c) == 0    
        I = [I c]; 
    end
end
peakValues_North2(I) = [];
indexes_North2(I) = [];
%indiexes_North2(I) = [];
clear I; clear c;


[peakValues_South1, indexes_South1] = findpeaks((-1)*wf.theta1,'MinPeakDistance',40,'MinPeakProminence',5);
[peakValues_South2, indexes_South2] = findpeaks((-1)*wf.theta2,'MinPeakDistance',40,'MinPeakProminence',5);


I = [];
for c = 1:length(peakValues_South1) 
    if (-1)*peakValues_South1(c) > interp1(south_filter_phi,south_filter_theta,indexes_South1(c))    
        I = [I c]; 
    end
end
peakValues_South1(I) = [];
indexes_South1(I) = [];
%indiexes_South1(I) = [];
clear I; clear c;
I = [];
for c = 1:length(peakValues_South2) 
    if (-1)*peakValues_South2(c) > interp1(south_filter_phi,south_filter_theta,indexes_South2(c))   
        I = [I c]; 
    end
end
peakValues_South2(I) = [];
indexes_South2(I) = [];
%indiexes_South2(I) = [];
clear I; clear c;



I = [];
for c = 1:length(peakValues_South1) 
    if (-1)*peakValues_South1(c) > -9 %I used -6 before, this may be too large
        I = [I c]; 
    end
    if (-1)*peakValues_South1(c) == 0
        I = [I c]; 
    end
end
peakValues_South1(I) = [];
indexes_South1(I) = [];
%indiexes_South1(I) = [];
clear I; clear c;
I = [];
for c = 1:length(peakValues_South2) 
    if (-1)*peakValues_South2(c) > -9 %I used -6 before, this may be too large
        I = [I c]; 
    end
    if (-1)*peakValues_South2(c) == 0
        I = [I c]; 
    end
end
peakValues_South2(I) = [];
indexes_South2(I) = [];
%indiexes_South2(I) = [];
clear I; clear c;








%refinding indexes since I've done some deleting

indiexes_North1 = indexes_North1;
for c = 1:length(peakValues_North1)
    k = find(wf.index_theta1==peakValues_North1(c));
    indiexes_North1(c) = k;
end
indiexes_North2 = indexes_North2;
for c = 1:length(peakValues_North2)
    k = find(wf.index_theta2==peakValues_North2(c));
    indiexes_North2(c) = k;
end

indiexes_South1 = indexes_South1;
for c = 1:length(peakValues_South1)
    k = find(wf.index_theta1==(-1)*peakValues_South1(c));
    indiexes_South1(c) = k;
end
indiexes_South2 = indexes_South2;
for c = 1:length(peakValues_South2)
    k = find(wf.index_theta2==(-1)*peakValues_South2(c));
    indiexes_South2(c) = k;
end

clear k;


%condensing indexes
peakValues_North = [peakValues_North1' peakValues_North2'];
peakValues_South = [peakValues_South1' peakValues_South2'];
%condensing indexes
indexes_North = [indexes_North1' indexes_North2']';
indexes_South = [indexes_South1' indexes_South2']';
indiexes_North = [indiexes_North1' indiexes_North2']';
indiexes_South = [indiexes_South1' indiexes_South2']';



%%%%%

figure(1)
subplot(2,2,[1,2])

% ztheta1 = smooth(wf.theta1,5);
% ztheta2 = smooth(wf.theta2,5);
% zphi1 = smooth(wf.phi1,5);
% zphi2 = smooth(wf.phi2,5);
ztheta1 = wf.theta1;
ztheta2 = wf.theta2;
zphi1 = wf.phi1;
zphi2 = wf.phi2;

%tilt frame mono color

grid on
hold on

for cnt = 1:length(zphi1)-1
    diff = zphi1(cnt+1) - zphi1(cnt);
    if abs(diff) > 5
        zphi1(cnt) = NaN;
        ztheta1(cnt) = NaN;
    end
end
for cnt = 1:length(zphi2)-1
    diff = zphi2(cnt+1) - zphi2(cnt);
    if abs(diff) > 5
        zphi2(cnt) = NaN;
        ztheta2(cnt) = NaN;
    end
end
clear cnt; clear diff;

plot(zphi1,sind(ztheta1),'k','linewidth',2);
plot(zphi2,sind(ztheta2),'k','linewidth',2);

load('/Users/pahi9557/Documents/MATLAB/Juno/alfven_boundary.mat')
plot(phi_n,sind(theta_n),'m.','MarkerSize',8)
plot(phi_s,sind(theta_s),'m.','MarkerSize',8)



% 
% Szlay_phi_n = [zphi1(indexes_North1) zphi2(indexes_North2)];
% Szlay_phi_s = [zphi1(indexes_South1) zphi2(indexes_South2)];
% Szlay_theta_n = [ztheta1(indexes_North1) ztheta2(indexes_North2)];
% Szlay_theta_s = [ztheta1(indexes_South1) ztheta2(indexes_South2)];
% 
% Szlay_phi_n = Szlay_phi_n(:);
% Szlay_phi_s = Szlay_phi_s(:);
% Szlay_theta_n = Szlay_theta_n(:);
% Szlay_theta_s = Szlay_theta_s(:);
% 
% [Szlay_phi_n, I] = sort(Szlay_phi_n);
% Szlay_theta_n = Szlay_theta_n(I);
% [Szlay_phi_s, I] = sort(Szlay_phi_s);
% Szlay_theta_s = Szlay_theta_s(I);
% 
% Szlay_theta_n = smooth(Szlay_theta_n,45);
% Szlay_theta_s = smooth(Szlay_theta_s,45);
% Szlay_theta_n = Szlay_theta_n - 5;
% Szlay_theta_s = Szlay_theta_s + 5;
% 
% plot(Szlay_phi_n,sind(Szlay_theta_n),'g','linewidth',2);
% plot(Szlay_phi_s,sind(Szlay_theta_s),'g','linewidth',2);


% plot(zphi1,sind(ztheta1),'g','linewidth',2)
% plot(south_filter_phi,sind(south_filter_theta),'g','linewidth',2)


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

for c = 1:length(indiexes_North1)
    
b = indiexes_North1(c);

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

plot(phieldphi,sind(phieldtheta),'k','linewidth',2.2);

end
clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices;
for c = 1:length(indiexes_North2)
    
b = indiexes_North2(c);

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

plot(phieldphi,sind(phieldtheta),'k','linewidth',2.2);

end
clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices;
for c = 1:length(indiexes_South1)
    
b = indiexes_South1(c);

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


plot(phieldphi,sind(phieldtheta),'k','linewidth',2.2);

end
clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices;
for c = 1:length(indiexes_South2)
    
b = indiexes_South2(c);

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


plot(phieldphi,sind(phieldtheta),'k','linewidth',2.2);

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












if desired_phi == 0
desired_phi = 360;
end


%%%northern hemisphere prediction
%%%
subplot(2,2,3)
%plotting the aurora
x = wf.north_ionosphere_r(indiexes_North).*sind(90 - wf.north_ionosphere_theta(indiexes_North)).*cosd(wf.north_ionosphere_phi(indiexes_North));
y = wf.north_ionosphere_r(indiexes_North).*sind(90 - wf.north_ionosphere_theta(indiexes_North)).*sind(wf.north_ionosphere_phi(indiexes_North));
plot(x,y,'.','color',[0 .75 .75],...
'MarkerSize',20)
hold on

%Io's location
x = wf.north_ionosphere_r(desired_phi*10).*sind(90 - wf.north_ionosphere_theta(desired_phi*10)).*cosd(wf.north_ionosphere_phi(desired_phi*10));
y = wf.north_ionosphere_r(desired_phi*10).*sind(90 - wf.north_ionosphere_theta(desired_phi*10)).*sind(wf.north_ionosphere_phi(desired_phi*10));
plot(x,y,'.','color',1/255*[255 0 127],...
'MarkerSize',30)
%text(x+.02,y,'Io','fontweight','bold','color','m','fontname','Kannada MN','fontsize',18)


%MAW location

time_of_prints = wf.time_stamp(indiexes_North);
[val,MAW] = min(time_of_prints);
x1 = wf.north_ionosphere_r(indiexes_North(MAW)).*sind(90 - wf.north_ionosphere_theta(indiexes_North(MAW))).*cosd(wf.north_ionosphere_phi(indiexes_North(MAW)))-0.1;
y1 = wf.north_ionosphere_r(indiexes_North(MAW)).*sind(90 - wf.north_ionosphere_theta(indiexes_North(MAW))).*sind(wf.north_ionosphere_phi(indiexes_North(MAW)))+0.05;
x2 = wf.north_ionosphere_r(indiexes_North(MAW)).*sind(90 - wf.north_ionosphere_theta(indiexes_North(MAW))).*cosd(wf.north_ionosphere_phi(indiexes_North(MAW)));
y2 = wf.north_ionosphere_r(indiexes_North(MAW)).*sind(90 - wf.north_ionosphere_theta(indiexes_North(MAW))).*sind(wf.north_ionosphere_phi(indiexes_North(MAW)));
x = [x1 x2]; y = [y1 y2];
plot(x2,y2,'k.',...
'MarkerSize',20)

HDMAW.Io_east_long(counter10) = desired_phi;
HDMAW.north.r(counter10) = wf.north_ionosphere_r(indiexes_North(MAW));
HDMAW.north.theta_lat(counter10) = wf.north_ionosphere_theta(indiexes_North(MAW));
HDMAW.north.phi_east(counter10) = wf.north_ionosphere_phi(indiexes_North(MAW));

%TEB

HDTEB.Io_east_long(counter10) = desired_phi;
HDTEB.south.r(counter10) = wf.south_ionosphere_r(indiexes_North(MAW));
HDTEB.south.theta_lat(counter10) = wf.south_ionosphere_theta(indiexes_North(MAW));
HDTEB.south.phi_east(counter10) = wf.south_ionosphere_phi(indiexes_North(MAW));


%line(x,y,'Color','k')
%text(x1-.03,y1+.01,'MAW','fontweight','bold','color',(1/255)*[0 0 0],'fontname','Kannada MN','fontsize',18)
%a = annotation('textarrow',x,y,'String',' MAW ');
clear x1; clear x2; clear y1; clear y2; clear val; clear I; clear time_of_prints;


%RAW location
time_of_prints = wf.time_stamp(indiexes_North);
time_of_prints(MAW) = time_of_prints(MAW) + 1000;
[val,RAW] = min(time_of_prints);
x1 = wf.north_ionosphere_r(indiexes_North(RAW)).*sind(90 - wf.north_ionosphere_theta(indiexes_North(RAW))).*cosd(wf.north_ionosphere_phi(indiexes_North(RAW)))-0.1;
y1 = wf.north_ionosphere_r(indiexes_North(RAW)).*sind(90 - wf.north_ionosphere_theta(indiexes_North(RAW))).*sind(wf.north_ionosphere_phi(indiexes_North(RAW)))+0.05;
x2 = wf.north_ionosphere_r(indiexes_North(RAW)).*sind(90 - wf.north_ionosphere_theta(indiexes_North(RAW))).*cosd(wf.north_ionosphere_phi(indiexes_North(RAW)));
y2 = wf.north_ionosphere_r(indiexes_North(RAW)).*sind(90 - wf.north_ionosphere_theta(indiexes_North(RAW))).*sind(wf.north_ionosphere_phi(indiexes_North(RAW)));
x = [x1 x2]; y = [y1 y2];
plot(x2,y2,'k.',...
'MarkerSize',20)
HDRAW.Io_east_long(counter10) = desired_phi;
HDRAW.north.r(counter10) = wf.north_ionosphere_r(indiexes_North(RAW));
HDRAW.north.theta_lat(counter10) = wf.north_ionosphere_theta(indiexes_North(RAW));
HDRAW.north.phi_east(counter10) = wf.north_ionosphere_phi(indiexes_North(RAW));
clear MAW; clear RAW; clear x1; clear x2; clear y1; clear y2; clear val; clear I; clear time_of_prints;




% %plotting the pole
% x = 0.9458.*sind(90 - 90).*cosd(0);
% y = 0.9458.*sind(90 - 90).*sind(0);
% plot(x,y,'x','color',(1/255)*[0 0 0],...
% 'MarkerSize',60)
%text(x+.02,y,'Pole','fontweight','bold','fontname','Kannada MN','fontsize',18)

%plotting the 0degree line
x2 = 0.7.*sind(90 - 0).*cosd(0); %times cosd(0) which is 1
y2 = 0.7.*sind(90 - 0).*sind(0); %times cosd(0) which is 1
x = [0 0]; y = [-1 1];
plot(x,y,'--','color',(1/255)*[128 128 128],...
'Linewidth',2)
x = [-x2 x2]; y = [-y2 y2];
plot(x,y,'--','color',(1/255)*[128 128 128],...
'Linewidth',2)
text(x2+.02,y2,'0^o','fontweight','bold','fontname','Kannada MN','fontsize',18)



az = 90;
el = 90;
view(az, el);

% 
% for c = 1:length(wf.north_ionosphere_r(indexes_North))
% pheyez = 360 - wf.north_ionosphere_phi(indexes_North);
% s = num2str(round(pheyez(c)));
% text(x(c),y(c),s,'fontname','Kannada MN','fontweight','bold','color','red','fontsize',14)
% end
% text(-0.4,0,'West Longitudes','fontname','Kannada MN','fontweight','bold','color','red','fontsize',18)

% text(-0.72,0.2,'\phi_{East} = 180','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(0.05,-0.25,'\phi_{West} = 90','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(0.27,0.13,'\phi_{East} = 0','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(-0.72,0.225 + .02,'\phi_{West} = 180','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(0.05,-0.275 - .02,'\phi_{East} = 270','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(0.27,0.175,'\phi_{West} = 360','fontweight','bold','fontname','Kannada MN','fontsize',18)
daspect([1 1 1])
axis tight
lighting gouraud
ylim([-.7 .7])
xlim([-.7 .7])
set(gca,'color','white')
set(gcf,'color','white')
set(gcf, 'InvertHardCopy', 'off');
% set(figure(5), 'Position', get(0, 'Screensize'));
set(gca,'xcolor','w','ycolor','w','zcolor','w','xminorgrid','off','yminorgrid','off','zminorgrid','off')
title('Northern Hemisphere','fontweight','bold','fontsize',18)
%%%%%%%%


% 
%%%Southern hemisphere
%%%
subplot(2,2,4)
%plotting the aurora
x = wf.south_ionosphere_r(indiexes_South).*sind(90 - wf.south_ionosphere_theta(indiexes_South)).*cosd(wf.south_ionosphere_phi(indiexes_South));
y = wf.south_ionosphere_r(indiexes_South).*sind(90 - wf.south_ionosphere_theta(indiexes_South)).*sind(wf.south_ionosphere_phi(indiexes_South));
plot(x,y,'.','color',[0 .75 .75],...
'MarkerSize',20)
hold on


%Io's location
x = wf.south_ionosphere_r(desired_phi*10).*sind(90 - wf.south_ionosphere_theta(desired_phi*10)).*cosd(wf.south_ionosphere_phi(desired_phi*10));
y = wf.south_ionosphere_r(desired_phi*10).*sind(90 - wf.south_ionosphere_theta(desired_phi*10)).*sind(wf.south_ionosphere_phi(desired_phi*10));
plot(x,y,'.','color',1/255*[255 0 127],...
'MarkerSize',30)
%text(x+.02,y,'Io','fontweight','bold','color',(1/255)*[255 128 0],'fontname','Kannada MN','fontsize',18)


%MAW location
time_of_prints = wf.time_stamp(indiexes_South);
[val,MAW] = min(time_of_prints);
x1 = wf.south_ionosphere_r(indiexes_South(MAW)).*sind(90 - wf.south_ionosphere_theta(indiexes_South(MAW))).*cosd(wf.south_ionosphere_phi(indiexes_South(MAW)))+0.05;
y1 = wf.south_ionosphere_r(indiexes_South(MAW)).*sind(90 - wf.south_ionosphere_theta(indiexes_South(MAW))).*sind(wf.south_ionosphere_phi(indiexes_South(MAW)))+0.05;
x2 = wf.south_ionosphere_r(indiexes_South(MAW)).*sind(90 - wf.south_ionosphere_theta(indiexes_South(MAW))).*cosd(wf.south_ionosphere_phi(indiexes_South(MAW)));
y2 = wf.south_ionosphere_r(indiexes_South(MAW)).*sind(90 - wf.south_ionosphere_theta(indiexes_South(MAW))).*sind(wf.south_ionosphere_phi(indiexes_South(MAW)));
x = [x1 x2]; y = [y1 y2];
plot(x2,y2,'k.',...
'MarkerSize',20)
HDMAW.south.r(counter10) = wf.south_ionosphere_r(indiexes_South(MAW));
HDMAW.south.theta_lat(counter10) = wf.south_ionosphere_theta(indiexes_South(MAW));
HDMAW.south.phi_east(counter10) = wf.south_ionosphere_phi(indiexes_South(MAW));

%TEB

HDTEB.north.r(counter10) = wf.north_ionosphere_r(indiexes_South(MAW));
HDTEB.north.theta_lat(counter10) = wf.north_ionosphere_theta(indiexes_South(MAW));
HDTEB.north.phi_east(counter10) = wf.north_ionosphere_phi(indiexes_South(MAW));


clear x1; clear x2; clear y1; clear y2; clear val; clear I; clear time_of_prints;


%RAW location
time_of_prints = wf.time_stamp(indiexes_South);
time_of_prints(MAW) = time_of_prints(MAW) + 1000;
[val,RAW] = min(time_of_prints);
x1 = wf.south_ionosphere_r(indiexes_South(RAW)).*sind(90 - wf.south_ionosphere_theta(indiexes_South(RAW))).*cosd(wf.south_ionosphere_phi(indiexes_South(RAW)))+0.05;
y1 = wf.south_ionosphere_r(indiexes_South(RAW)).*sind(90 - wf.south_ionosphere_theta(indiexes_South(RAW))).*sind(wf.south_ionosphere_phi(indiexes_South(RAW)))+0.05;
x2 = wf.south_ionosphere_r(indiexes_South(RAW)).*sind(90 - wf.south_ionosphere_theta(indiexes_South(RAW))).*cosd(wf.south_ionosphere_phi(indiexes_South(RAW)));
y2 = wf.south_ionosphere_r(indiexes_South(RAW)).*sind(90 - wf.south_ionosphere_theta(indiexes_South(RAW))).*sind(wf.south_ionosphere_phi(indiexes_South(RAW)));
x = [x1 x2]; y = [y1 y2];
plot(x2,y2,'k.',...
'MarkerSize',20)
HDRAW.south.r(counter10) = wf.south_ionosphere_r(indiexes_South(RAW));
HDRAW.south.theta_lat(counter10) = wf.south_ionosphere_theta(indiexes_South(RAW));
HDRAW.south.phi_east(counter10) = wf.south_ionosphere_phi(indiexes_South(RAW));
clear MAW; clear RAW; clear x1; clear x2; clear y1; clear y2; clear val; clear I; clear time_of_prints;





% %plotting the pole
% x = 0.941.*sind(90 + 90).*cosd(0);
% y = 0.941.*sind(90 + 90).*sind(0);
% plot(x,y,'x','color',(1/255)*[0 0 0],...
% 'MarkerSize',60)
%text(x+.02,y,'Pole','fontweight','bold','fontname','Kannada MN','fontsize',18)


%plotting the 0degree line
x2 = 0.7.*sind(90 - 0).*cosd(0); 
y2 = 0.7.*sind(90 - 0).*sind(0); 
x = [0 0]; y = [-1 1];
plot(x,y,'--','color',(1/255)*[128 128 128],...
'Linewidth',2)
x = [-x2 x2]; y = [-y2 y2];
plot(x,y,'--','color',(1/255)*[128 128 128],...
'Linewidth',2)
text(x2-.02,y2+.02,'0^o','fontweight','bold','fontname','Kannada MN','fontsize',18)


az = 90;
el = -90;
view(az, el);

% text(0.1,0.28,'\phi_{East} = 90','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(-0.18,0,'\phi_{East} = 180','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(0,-0.45,'\phi_{East} = 270','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(0.3,-.1,'\phi_{East} = 0','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(0.1,0.255 - .02,'\phi_{West} = 270','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(-0.18,-0.025 - .02,'\phi_{West} = 180','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(0,-0.425 + .02,'\phi_{West} = 90','fontweight','bold','fontname','Kannada MN','fontsize',18)
% text(0.3,-0.075 + .02,'\phi_{West} = 360','fontweight','bold','fontname','Kannada MN','fontsize',18)

daspect([1 1 1])
axis tight
lighting gouraud
ylim([-.7 .7])
xlim([-.7 .7])
% ylim([-.55 .34])
% xlim([-.3 .5])
set(gca,'color','white')
set(gcf,'color','white')
set(gcf, 'InvertHardCopy', 'off');
%set(figure(5), 'Position', get(0, 'Screensize'));
set(gca,'xcolor','w','ycolor','w','zcolor','w','xminorgrid','off','yminorgrid','off','zminorgrid','off')
title('Southern Hemisphere','fontweight','bold','fontsize',18)




set(gcf, 'Position', [100, 100, 2000, 1200])






