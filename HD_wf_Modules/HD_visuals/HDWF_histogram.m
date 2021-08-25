for c=1:18
B_n{c} = [];
end
clear c;

for c=1:18
B_s{c} = [];
end
clear c;

HDMAW = struct();
HDMAW.Io_east_long = [];
HDMAW.north.r = [];
HDMAW.north.theta_lat = [];
HDMAW.north.phi_east = [];
HDMAW.south.r = [];
HDMAW.south.theta_lat = [];
HDMAW.south.phi_east = [];

HDMAW.north.spotcount = [];
HDMAW.south.spotcount = [];
for counter10 = 0:10:360 % for Histogram
desired_phi = 360 - counter10;





% Start out by inputing your desired phi, this is the location that you
% place Io. This is the location that your are interested in knowing where
% the wavefronts are, when Io is at desired phi. The code then breaks Io's
% orbit into 3600 discrete points. At each point, wf_time_stamp calcualtes
% how much time has passed since Io was at the longitude to launch a
% wavefront.

%wf_location_finder uses this time stamp, the 3 characteristic
% distances, and the discrete field lines to find out where along the field
% line each wavefront is. The three uniqure distances are T1: from io to
% Jupiter (North), T2: from io to Jupiter (South), and T3: T1 + T2. 
% T3 is actually a non unique distance, but is useful to define.
% wf_location_finder then divides each time_stamp by the T3 associated with
% it, this is because after a T3, a wavefront has returned to Io as if it
% had just been launched. We use the time remaining to narrow down where on
% the field line that wavefront is. wf_location_finder does this, and
% computes and saves the location of each wavefront.

%wf_ionosphere calculates where the terminus of each field line is on the
%ionosphere of Jupiter
%desired_phi = 304;
load('/Users/pahi9557/Documents/MATLAB/HDAlfven_JRM09/HDJRM09_Alfven_Model.mat')
HDJRM09_wf_time_stamp % creating the wavefronts and the time stamp that each one is launched at
HDJRM09_wf_location_finder
HDJRM09_wf_ionosphere

%this filter will be used to help decide whether or not a peak is
%actualy reaching the ionosphere
load('/Users/pahi9557/Documents/MATLAB/HDAlfven_JRM09/HD_wf_Modules/wf_filter.mat')



counter10 = 360 - desired_phi;

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



% %%%%filtering out points that Io launched > 350 degrees ago
% %%%%
% I = [];
% for c = 1:length(wf.time_stamp)
%     if wf.time_stamp(c) > 761.8
%         I = [I c];
%     end
% end
% wf.theta2(I) = NaN;
% wf.phi2(I) = NaN;
% wf.theta1(I) = NaN;
% wf.phi1(I) = NaN;
% wf.list(I) = NaN;
% clear I; clear c;
% %%%%%%%%%%%%%%%%%%%%%%%%%%

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


% %%%%%
% figure()
% % ztheta1 = smooth(wf.theta1,5);
% % ztheta2 = smooth(wf.theta2,5);
% % zphi1 = smooth(wf.phi1,5);
% % zphi2 = smooth(wf.phi2,5);
% ztheta1 = wf.theta1;
% ztheta2 = wf.theta2;
% zphi1 = wf.phi1;
% zphi2 = wf.phi2;
% %tilt frame mono color
% grid on
% hold on
% for cnt = 1:length(zphi1)-1
%     diff = zphi1(cnt+1) - zphi1(cnt);
%     if abs(diff) > 5
%         zphi1(cnt) = NaN;
%         ztheta1(cnt) = NaN;
%     end
% end
% for cnt = 1:length(zphi2)-1
%     diff = zphi2(cnt+1) - zphi2(cnt);
%     if abs(diff) > 5
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
% for c = 1:length(indiexes_North1)
%     
% b = indiexes_North1(c);
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
% plot(phieldphi,sind(phieldtheta),'k','linewidth',2.2);
% 
% end
% clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices;
% for c = 1:length(indiexes_North2)
%     
% b = indiexes_North2(c);
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
% plot(phieldphi,sind(phieldtheta),'k','linewidth',2.2);
% 
% end
% clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices;
% for c = 1:length(indiexes_South1)   
% b = indiexes_South1(c);
% if b < 3600
% a = characteristic.South.index(b);
% b = characteristic.South.index(b+1)-1;
% end
% if b == 3600
%     a = characteristic.South.index(b);
%     b = length(characteristic.South.there.phi);
% end
% phieldr = characteristic.South.there.r(a:b);
% phieldtheta = characteristic.South.there.theta(a:b);
% phieldphi = characteristic.South.there.phi(a:b);
% indices = find(abs(phieldtheta)<abs(peakValues_South1(c)));
% phieldr(indices) = [];
% phieldtheta(indices) = [];
% phieldphi(indices) = [];
% [z,l] = max(phieldphi);
% phieldr = [phieldr(1:l) NaN phieldr(l+1:end)];
% phieldtheta= [phieldtheta(1:l) NaN phieldtheta(l+1:end)];
% phieldphi= [phieldphi(1:l) NaN phieldphi(l+1:end)];
% plot(phieldphi,sind(phieldtheta),'k','linewidth',2.2);
% end
% clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices;
% for c = 1:length(indiexes_South2)  
% b = indiexes_South2(c);
% if b < 3600
% a = characteristic.South.index(b);
% b = characteristic.South.index(b+1)-1;
% end
% if b == 3600
%     a = characteristic.South.index(b);
%     b = length(characteristic.South.there.phi);
% end
% phieldr = characteristic.South.there.r(a:b);
% phieldtheta = characteristic.South.there.theta(a:b);
% phieldphi = characteristic.South.there.phi(a:b);
% indices = find(abs(phieldtheta)<abs(peakValues_South2(c)));
% phieldr(indices) = [];
% phieldtheta(indices) = [];
% phieldphi(indices) = [];
% [z,l] = max(phieldphi);
% phieldr = [phieldr(1:l) NaN phieldr(l+1:end)];
% phieldtheta= [phieldtheta(1:l) NaN phieldtheta(l+1:end)];
% phieldphi= [phieldphi(1:l) NaN phieldphi(l+1:end)];
% 
% 
% plot(phieldphi,sind(phieldtheta),'k','linewidth',2.2);
% 
% end
% clear a; clear b; clear c; clear phieldr; clear phieldtheta; clear phieldphi; clear indices; clear l; clear z;
% set(gca,'ytick',sind(-90:10:90), 'YTickLabel',{'-90','','','','','', '-30','','','  0','','',' 30','','','','','',' 90' })
% %set(gca,'yminorgrid','on')
% %xt=[0:1:6];
% %set(gca,'xtick',xt)
% set(gca,'xminorgrid','on')
% set(gca,'FontSize',16)
% xlabel('East Jovigraphic Longitude','fontsize',18) % x-axis label
% ylabel('Sys III \theta','fontsize',18) % y-axis label
% %h_legend = legend('Ne','O+', 'O++', 'O+Hot', 'Location','best');
% %set(h_legend,'FontSize',20);
% xlim([0 360])
% % ylim([0 5])
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
% if desired_phi == 0
% desired_phi = 360;
% end
% %%%%%%%%%%%%


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

% list_of_prints = wf.north_ionosphere_phi(indiexes_North);
% if max(list_of_prints) < wf.north_ionosphere_phi(desired_phi*10)
% [phi_MAW,MAW] = min(list_of_prints);
% end
% if max(list_of_prints) > wf.north_ionosphere_phi(desired_phi*10)
% list_of_prints = list_of_prints - wf.north_ionosphere_phi(desired_phi*10);
% I = find(list_of_prints < 0);
% list_of_prints(I) = [];
% phi_MAW = min(list_of_prints);
% MAW = find(wf.north_ionosphere_phi(indiexes_North) - wf.north_ionosphere_phi(desired_phi*10) == phi_MAW);
% end



time_of_prints = wf.time_stamp(indiexes_North);
[val,MAW] = min(time_of_prints);
x1 = wf.north_ionosphere_r(indiexes_North(MAW)).*sind(90 - wf.north_ionosphere_theta(indiexes_North(MAW))).*cosd(wf.north_ionosphere_phi(indiexes_North(MAW)))-0.1;
y1 = wf.north_ionosphere_r(indiexes_North(MAW)).*sind(90 - wf.north_ionosphere_theta(indiexes_North(MAW))).*sind(wf.north_ionosphere_phi(indiexes_North(MAW)))+0.05;
x2 = wf.north_ionosphere_r(indiexes_North(MAW)).*sind(90 - wf.north_ionosphere_theta(indiexes_North(MAW))).*cosd(wf.north_ionosphere_phi(indiexes_North(MAW)));
y2 = wf.north_ionosphere_r(indiexes_North(MAW)).*sind(90 - wf.north_ionosphere_theta(indiexes_North(MAW))).*sind(wf.north_ionosphere_phi(indiexes_North(MAW)));
x = [x1 x2]; y = [y1 y2];
plot(x2,y2,'.','color',(1/255)*[0 0 0],...
'MarkerSize',20)

HDMAW.Io_east_long(counter10) = desired_phi;

HDMAW.north.r(counter10) = wf.north_ionosphere_r(indiexes_North(MAW));
HDMAW.north.theta_lat(counter10) = wf.north_ionosphere_theta(indiexes_North(MAW));
HDMAW.north.phi_east(counter10) = wf.north_ionosphere_phi(indiexes_North(MAW));
%line(x,y,'Color','k')
%text(x1-.03,y1+.01,'MAW','fontweight','bold','color',(1/255)*[0 0 0],'fontname','Kannada MN','fontsize',18)
%a = annotation('textarrow',x,y,'String',' MAW ');



% list_of_prints = wf.north_ionosphere_phi(indiexes_North);
spotcounter = 0;
for temp_counter = 1:length(indiexes_North)
    if abs(wf.north_ionosphere_phi(indiexes_North(temp_counter))-wf.north_ionosphere_phi(indiexes_North(MAW))) <= 15
        spotcounter = spotcounter + 1;
    end
    if abs(wf.north_ionosphere_phi(indiexes_North(temp_counter))-wf.north_ionosphere_phi(indiexes_North(MAW))) >= 345
        spotcounter = spotcounter + 1;
    end        
end
HDMAW.north.spotcount = [HDMAW.north.spotcount spotcounter];

clear temp_counter; clear spotcounter;
clear x1; clear x2; clear y1; clear y2; clear MAW; clear val; clear I; clear time_of_prints;



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

% list_of_prints = wf.south_ionosphere_phi(indiexes_South);
% if max(list_of_prints) < wf.south_ionosphere_phi(desired_phi*10)
% [phi_MAW,MAW] = min(list_of_prints);
% end
% if max(list_of_prints) > wf.south_ionosphere_phi(desired_phi*10)
% list_of_prints = list_of_prints - wf.south_ionosphere_phi(desired_phi*10);
% I = find(list_of_prints < 0);
% list_of_prints(I) = [];
% phi_MAW = min(list_of_prints);
% MAW = find(wf.south_ionosphere_phi(indiexes_South) - wf.south_ionosphere_phi(desired_phi*10) == phi_MAW);
% end

time_of_prints = wf.time_stamp(indiexes_South);
[val,MAW] = min(time_of_prints);

x1 = wf.south_ionosphere_r(indiexes_South(MAW)).*sind(90 - wf.south_ionosphere_theta(indiexes_South(MAW))).*cosd(wf.south_ionosphere_phi(indiexes_South(MAW)))+0.05;
y1 = wf.south_ionosphere_r(indiexes_South(MAW)).*sind(90 - wf.south_ionosphere_theta(indiexes_South(MAW))).*sind(wf.south_ionosphere_phi(indiexes_South(MAW)))+0.05;
x2 = wf.south_ionosphere_r(indiexes_South(MAW)).*sind(90 - wf.south_ionosphere_theta(indiexes_South(MAW))).*cosd(wf.south_ionosphere_phi(indiexes_South(MAW)));
y2 = wf.south_ionosphere_r(indiexes_South(MAW)).*sind(90 - wf.south_ionosphere_theta(indiexes_South(MAW))).*sind(wf.south_ionosphere_phi(indiexes_South(MAW)));
x = [x1 x2]; y = [y1 y2];
plot(x2,y2,'.','color',(1/255)*[0 0 0],...
'MarkerSize',20)


HDMAW.south.r(counter10) = wf.south_ionosphere_r(indiexes_South(MAW));
HDMAW.south.theta_lat(counter10) = wf.south_ionosphere_theta(indiexes_South(MAW));
HDMAW.south.phi_east(counter10) = wf.south_ionosphere_phi(indiexes_South(MAW));

spotcounter = 0;
for temp_counter = 1:length(indiexes_South)
    if abs(wf.south_ionosphere_phi(indiexes_South(temp_counter))-wf.south_ionosphere_phi(indiexes_South(MAW))) <= 15
        spotcounter = spotcounter + 1;
    end
    if abs(wf.south_ionosphere_phi(indiexes_South(temp_counter))-wf.south_ionosphere_phi(indiexes_South(MAW))) >= 345
        spotcounter = spotcounter + 1;
    end        
end
HDMAW.south.spotcount = [HDMAW.south.spotcount spotcounter];

clear temp_counter; clear spotcounter;
clear x1; clear x2; clear y1; clear y2; clear MAW; clear val; clear I; clear time_of_prints;



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




figure()
h = histogram(wf.north_ionosphere_phi(indiexes_North),18)
hold on
plot(desired_phi,0,'.','color',1/255*[255 0 127],'Markersize',90);


xlabel('East Jovigraphic Longitude','fontsize',18) % x-axis label
ylabel('Number of Spots','fontsize',18) % x-axis label
set(gca,'FontSize',16)
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
set(gcf, 'Position', [100, 100, 2000, 1200])




%binning for the north
b_n(1:18) = 0;
for c = 1:length(wf.north_ionosphere_phi(indiexes_North))  
temp_phi = wf.north_ionosphere_phi(indiexes_North(c));
if temp_phi < 20
    b_n(1) = b_n(1) + 1;
end
if temp_phi < 40
   if temp_phi >= 20
    b_n(2) = b_n(2) + 1;
   end
end
if temp_phi < 60
   if temp_phi >= 40
    b_n(3) = b_n(3) + 1;
   end
end
if temp_phi < 80
   if temp_phi >= 60
    b_n(4) = b_n(4) + 1;
   end
end
if temp_phi < 100
   if temp_phi >= 80
    b_n(5) = b_n(5) + 1;
   end
end
if temp_phi < 120
   if temp_phi >= 100
    b_n(6) = b_n(6) + 1;
   end
end
if temp_phi < 140
   if temp_phi >= 120
    b_n(7) = b_n(7) + 1;
   end
end
if temp_phi < 160
   if temp_phi >= 140
    b_n(8) = b_n(8) + 1;
   end
end
if temp_phi < 180
   if temp_phi >= 160
    b_n(9) = b_n(9) + 1;
   end
end
if temp_phi < 200
   if temp_phi >= 180
    b_n(10) = b_n(10) + 1;
   end
end
if temp_phi < 220
   if temp_phi >= 200
    b_n(11) = b_n(11) + 1;
   end
end
if temp_phi < 240
   if temp_phi >= 220
    b_n(12) = b_n(2) + 1;
   end
end
if temp_phi < 260
   if temp_phi >= 240
    b_n(13) = b_n(13) + 1;
   end
end
if temp_phi < 280
   if temp_phi >= 260
    b_n(14) = b_n(14) + 1;
   end
end
if temp_phi < 300
   if temp_phi >= 280
    b_n(15) = b_n(15) + 1;
   end
end
if temp_phi < 320
   if temp_phi >= 300
    b_n(16) = b_n(16) + 1;
   end
end
if temp_phi < 340
   if temp_phi >= 320
    b_n(17) = b_n(17) + 1;
   end
end
if temp_phi < 360
   if temp_phi >= 340
    b_n(18) = b_n(18) + 1;
   end
end
end
%binning for the south
b_s(1:18) = 0;
for c = 1:length(wf.south_ionosphere_phi(indiexes_South))  
temp_phi = wf.south_ionosphere_phi(indiexes_South(c));
if temp_phi < 20
    b_s(1) = b_s(1) + 1;
end
if temp_phi < 40
   if temp_phi >= 20
    b_s(2) = b_s(2) + 1;
   end
end
if temp_phi < 60
   if temp_phi >= 40
    b_s(3) = b_s(3) + 1;
   end
end
if temp_phi < 80
   if temp_phi >= 60
    b_s(4) = b_s(4) + 1;
   end
end
if temp_phi < 100
   if temp_phi >= 80
    b_s(5) = b_s(5) + 1;
   end
end
if temp_phi < 120
   if temp_phi >= 100
    b_s(6) = b_s(6) + 1;
   end
end
if temp_phi < 140
   if temp_phi >= 120
    b_s(7) = b_s(7) + 1;
   end
end
if temp_phi < 160
   if temp_phi >= 140
    b_s(8) = b_s(8) + 1;
   end
end
if temp_phi < 180
   if temp_phi >= 160
    b_s(9) = b_s(9) + 1;
   end
end
if temp_phi < 200
   if temp_phi >= 180
    b_s(10) = b_s(10) + 1;
   end
end
if temp_phi < 220
   if temp_phi >= 200
    b_s(11) = b_s(11) + 1;
   end
end
if temp_phi < 240
   if temp_phi >= 220
    b_s(12) = b_s(2) + 1;
   end
end
if temp_phi < 260
   if temp_phi >= 240
    b_s(13) = b_s(13) + 1;
   end
end
if temp_phi < 280
   if temp_phi >= 260
    b_s(14) = b_s(14) + 1;
   end
end
if temp_phi < 300
   if temp_phi >= 280
    b_s(15) = b_s(15) + 1;
   end
end
if temp_phi < 320
   if temp_phi >= 300
    b_s(16) = b_s(16) + 1;
   end
end
if temp_phi < 340
   if temp_phi >= 320
    b_s(17) = b_s(17) + 1;
   end
end
if temp_phi < 360
   if temp_phi >= 340
    b_s(18) = b_s(18) + 1;
   end
end
end

%adding to master lists for statistics
B_n{1} = [B_n{1} b_n(1)];
B_n{2} = [B_n{2} b_n(2)];
B_n{3} = [B_n{3} b_n(3)];
B_n{4} = [B_n{4} b_n(4)];
B_n{5} = [B_n{5} b_n(5)];
B_n{6} = [B_n{6} b_n(6)];
B_n{7} = [B_n{7} b_n(7)];
B_n{8} = [B_n{8} b_n(8)];
B_n{9} = [B_n{9} b_n(9)];
B_n{10} = [B_n{10} b_n(10)];
B_n{11} = [B_n{11} b_n(11)];
B_n{12} = [B_n{12} b_n(12)];
B_n{13} = [B_n{13} b_n(13)];
B_n{14} = [B_n{14} b_n(14)];
B_n{15} = [B_n{15} b_n(15)];
B_n{16} = [B_n{16} b_n(16)];
B_n{17} = [B_n{17} b_n(17)];
B_n{18} = [B_n{18} b_n(18)];

B_s{1} = [B_s{1} b_s(1)];
B_s{2} = [B_s{2} b_s(2)];
B_s{3} = [B_s{3} b_s(3)];
B_s{4} = [B_s{4} b_s(4)];
B_s{5} = [B_s{5} b_s(5)];
B_s{6} = [B_s{6} b_s(6)];
B_s{7} = [B_s{7} b_s(7)];
B_s{8} = [B_s{8} b_s(8)];
B_s{9} = [B_s{9} b_s(9)];
B_s{10} = [B_s{10} b_s(10)];
B_s{11} = [B_s{11} b_s(11)];
B_s{12} = [B_s{12} b_s(12)];
B_s{13} = [B_s{13} b_s(13)];
B_s{14} = [B_s{14} b_s(14)];
B_s{15} = [B_s{15} b_s(15)];
B_s{16} = [B_s{16} b_s(16)];
B_s{17} = [B_s{17} b_s(17)];
B_s{18} = [B_s{18} b_s(18)];
close all
end