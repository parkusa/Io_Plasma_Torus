MRT_unc_mod
load('/Users/pahi9557/Documents/MATLAB/Thesis_and_paper/paper_figs/GRL2018/new_Bonfond_11_18.mat')
load('/Users/pahi9557/Documents/MATLAB/HDAlfven_JRM09/MAW_RAW_11_2.mat')
clear HST_2009;


[HST_north.Io_sysIII, order] = sort(HST_north.Io_sysIII);
HST_north.maw_lon = HST_north.maw_lon(order);
HST_north.maw_neg = HST_north.maw_neg(order);
HST_north.maw_pos = HST_north.maw_pos(order);
HST_north.raw_lon = HST_north.raw_lon(order);
HST_north.raw_neg = HST_north.raw_neg(order);
HST_north.raw_pos = HST_north.raw_pos(order);
HST_north.teb_lon = HST_north.teb_lon(order);
HST_north.teb_pos = HST_north.teb_pos(order);
HST_north.teb_neg = HST_north.teb_neg(order);
clear order;
[HST_south.Io_sysIII, order] = sort(HST_south.Io_sysIII);
HST_south.maw_lon = HST_south.maw_lon(order);
HST_south.maw_neg = HST_south.maw_neg(order);
HST_south.maw_pos = HST_south.maw_pos(order);
HST_south.raw_lon = HST_south.raw_lon(order);
HST_south.raw_neg = HST_south.raw_neg(order);
HST_south.raw_pos = HST_south.raw_pos(order);
HST_south.teb_lon = HST_south.teb_lon(order);
HST_south.teb_pos = HST_south.teb_pos(order);
HST_south.teb_neg = HST_south.teb_neg(order);
clear order;

HST_north.maw_lon(1:14) = HST_north.maw_lon(1:14) - 360;
HST_north.maw_lon(352) = HST_north.maw_lon(352) + 360;
HST_north.maw_neg(1:14) = HST_north.maw_neg(1:14) - 360;
HST_north.maw_neg(352) = HST_north.maw_neg(352) + 360;
HST_north.maw_pos(1:14) = HST_north.maw_pos(1:14) - 360;
HST_north.maw_pos(352) = HST_north.maw_pos(352) + 360;

HST_north.raw_lon(3) = HST_north.raw_lon(3) - 360;
HST_north.raw_lon(4) = HST_north.raw_lon(4) - 360;
HST_north.raw_neg(3) = HST_north.raw_neg(3) - 360;
HST_north.raw_neg(4) = HST_north.raw_neg(4) - 360;
HST_north.raw_pos(3) = HST_north.raw_pos(3) - 360;
HST_north.raw_pos(4) = HST_north.raw_pos(4) - 360;

HST_north.teb_lon(3) = HST_north.teb_lon(3) - 360;
HST_north.teb_lon(4) = HST_north.teb_lon(4) - 360;
HST_north.teb_neg(3) = HST_north.teb_neg(3) - 360;
HST_north.teb_neg(4) = HST_north.teb_neg(4) - 360;
HST_north.teb_pos(3) = HST_north.teb_pos(3) - 360;
HST_north.teb_pos(4) = HST_north.teb_pos(4) - 360;


for c = 1:40
   if HST_south.maw_lon(c) > 300
    HST_south.maw_lon(c) = HST_south.maw_lon(c) -360;
HST_south.maw_neg(c) = HST_south.maw_neg(c) -360;
HST_south.maw_pos(c) = HST_south.maw_pos(c) -360;
   end  
end


for c = 150:length(HST_south.maw_lon)
   if HST_south.maw_lon(c) < 20
    HST_south.maw_lon(c) = HST_south.maw_lon(c) +360;
HST_south.maw_neg(c) = HST_south.maw_neg(c) +360;
HST_south.maw_pos(c) = HST_south.maw_pos(c) +360;
   end  
end

for c = 1:40
   if HST_south.teb_lon(c) > 300
    HST_south.teb_lon(c) = HST_south.teb_lon(c) -360;
HST_south.teb_neg(c) = HST_south.teb_neg(c) -360;
HST_south.teb_pos(c) = HST_south.teb_pos(c) -360;
   end  
end


for c = 150:length(HST_south.teb_lon)
   if HST_south.teb_lon(c) < 20
    HST_south.teb_lon(c) = HST_south.teb_lon(c) +360;
HST_south.teb_neg(c) = HST_south.teb_neg(c) +360;
HST_south.teb_pos(c) = HST_south.teb_pos(c) +360;
   end  
end
    HST_south.teb_lon(246) = HST_south.teb_lon(246) +360;
HST_south.teb_neg(246) = HST_south.teb_neg(246) +360;
HST_south.teb_pos(246) = HST_south.teb_pos(246) +360;
    HST_south.teb_lon(247) = HST_south.teb_lon(247) +360;
HST_south.teb_neg(247) = HST_south.teb_neg(247) +360;
HST_south.teb_pos(247) = HST_south.teb_pos(247) +360;

for c = 150:length(HST_south.raw_lon)
   if HST_south.raw_lon(c) < 20
    HST_south.raw_lon(c) = HST_south.raw_lon(c) +360;
HST_south.raw_neg(c) = HST_south.raw_neg(c) +360;
HST_south.raw_pos(c) = HST_south.raw_pos(c) +360;
   end  
end

for c = 150:length(HST_south.teb_lon)
   if HST_south.teb_lon(c) > 700
    HST_south.teb_lon(c) = HST_south.teb_lon(c) -360;
HST_south.teb_neg(c) = HST_south.teb_neg(c) -360;
HST_south.teb_pos(c) = HST_south.teb_pos(c) -360;
   end  
end



HDMAW.Io_east_long(360) = 0;
HDMAW.Io_west_long = 360 - HDMAW.Io_east_long;
HDMAW.north.phi_west = 360 - HDMAW.north.phi_east
HDMAW.south.phi_west = 360 - HDMAW.south.phi_east;
HDRAW.north.phi_west = 360 - HDRAW.north.phi_east
HDRAW.south.phi_west = 360 - HDRAW.south.phi_east;
HDTEB.north.phi_west = 360 - HDTEB.north.phi_east
HDTEB.south.phi_west = 360 - HDTEB.south.phi_east;

I = [];
for c = 1:length(HDMAW.north.phi_west)
if HDMAW.north.phi_west(c) > 3.281967766255028e+02
    I = [I c];
end
end
HDMAW.north.phi_west(I) = HDMAW.north.phi_west(I) - 360;
clear I; clear c;
HDMAW.south.phi_west(355:360) = HDMAW.south.phi_west(355:360) + 360;
HDRAW.north.phi_west(1:18) = HDRAW.north.phi_west(1:18) - 360;
HDRAW.south.phi_west(1:4) = HDRAW.south.phi_west(1:4)- 360;
HDTEB.north.phi_west(1:12) = HDTEB.north.phi_west(1:12) - 360;
HDTEB.south.phi_west(358:360) = HDTEB.south.phi_west(358:360) + 360;




figure()
grid on

plot(HDMAW.Io_west_long,HDMAW.north.phi_west - HDMAW.Io_west_long,'color',1/255*[0 153 0],'linewidth',2);
hold on
plot(HDMAW.Io_west_long,HDRAW.north.phi_west - HDMAW.Io_west_long,'color',1/255*[51 51 255],'linewidth',2,'linestyle','--');
plot(HDMAW.Io_west_long,HDTEB.north.phi_west - HDMAW.Io_west_long,'color',1/255*[255 51 51],'linewidth',2,'linestyle',':');

e = errorbar(HST_north.Io_sysIII,HST_north.maw_lon - HST_north.Io_sysIII,abs(HST_north.maw_lon - HST_north.maw_neg),abs(HST_north.maw_lon - HST_north.maw_pos),'.')
%e = errorbar(HST_2009.Io,HST_2009.NorthLon,HST_2009.NorthErr,'.')
%e.Marker = '*';
e.MarkerSize = 15;
e.Color = 1/255*[0 153 0];
%e.CapSize = 15;

for c = 1:length(HST_north.raw_lon)
if abs(HST_north.raw_lon(c)) > 1000
    HST_north.raw_lon(c) = NaN;
end
end
clear c;

e = errorbar(HST_north.Io_sysIII,HST_north.raw_lon - HST_north.Io_sysIII,abs(HST_north.raw_lon - HST_north.raw_neg),abs(HST_north.raw_lon - HST_north.raw_pos),'.')
%e = errorbar(HST_2009.Io,HST_2009.NorthLon,HST_2009.NorthErr,'.')
%e.Marker = '*';
e.MarkerSize = 15;
e.Color = 1/255*[51 51 255];
%e.CapSize = 15;

for c = 1:length(HST_north.teb_lon)
if abs(HST_north.teb_lon(c)) > 1000
    HST_north.teb_lon(c) = NaN;
end
end
clear c;

e = errorbar(HST_north.Io_sysIII,HST_north.teb_lon - HST_north.Io_sysIII,abs(HST_north.teb_lon - HST_north.teb_neg),abs(HST_north.teb_lon - HST_north.teb_pos),'.')
%e = errorbar(HST_2009.Io,HST_2009.NorthLon,HST_2009.NorthErr,'.')
%e.Marker = '*';
e.MarkerSize = 15;
e.Color = 1/255*[255 51 51];
%e.CapSize = 15;





%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for c = 1:length(HST_south.maw_lon)
if abs(HST_south.maw_lon(c)) > 1000
    HST_south.maw_lon(c) = NaN;
end
end
clear c;

e = errorbar(HST_south.Io_sysIII,HST_south.maw_lon - HST_south.Io_sysIII,abs(HST_south.maw_lon - HST_south.maw_neg),abs(HST_south.maw_lon - HST_south.maw_pos),'.')
%e = errorbar(HST_2009.Io,HST_2009.southLon,HST_2009.southErr,'.')
%e.Marker = '*';
e.MarkerSize = 15;
e.Color = 1/255*[0 153 0];
%e.CapSize = 15;

for c = 1:length(HST_south.raw_lon)
if abs(HST_south.raw_lon(c)) > 1000
    HST_south.raw_lon(c) = NaN;
end
end
clear c;

e = errorbar(HST_south.Io_sysIII,HST_south.raw_lon - HST_south.Io_sysIII,abs(HST_south.raw_lon - HST_south.raw_neg),abs(HST_south.raw_lon - HST_south.raw_pos),'.')
%e = errorbar(HST_2009.Io,HST_2009.southLon,HST_2009.southErr,'.')
%e.Marker = '*';
e.MarkerSize = 15;
e.Color = 1/255*[51 51 255];
%e.CapSize = 15;

for c = 1:length(HST_south.teb_lon)
if abs(HST_south.teb_lon(c)) > 1000
    HST_south.teb_lon(c) = NaN;
end
end
clear c;

e = errorbar(HST_south.Io_sysIII,HST_south.teb_lon - HST_south.Io_sysIII,abs(HST_south.teb_lon - HST_south.teb_neg),abs(HST_south.teb_lon - HST_south.teb_pos),'.')
%e = errorbar(HST_2009.Io,HST_2009.southLon,HST_2009.southErr,'.')
%e.Marker = '*';
e.MarkerSize = 15;
e.Color = 1/255*[255 51 51];
%e.CapSize = 15;








plot(HDMAW.Io_west_long,HDMAW.south.phi_west - HDMAW.Io_west_long,'color',1/255*[0 153 0],'linewidth',2);
plot(HDMAW.Io_west_long,HDRAW.south.phi_west - HDMAW.Io_west_long,'color',1/255*[51 51 255],'linewidth',2,'linestyle','--');
plot(HDMAW.Io_west_long,HDTEB.south.phi_west - HDMAW.Io_west_long,'color',1/255*[255 51 51],'linewidth',2,'linestyle',':');



text(361,0,'South','fontweight','bold','fontname','Kannada MN','fontsize',18)
text(361,-33,'North','fontweight','bold','fontname','Kannada MN','fontsize',18)


x1 = 360 - HDMRT_unc.Io_east_long;
y1 = 360 - (HDMRT_unc.actual.north_MAW_phi_east + HDMRT_unc.north_MAW_phi_east) - x1;
y2 = 360 - (HDMRT_unc.actual.north_MAW_phi_east - HDMRT_unc.north_MAW_phi_east) - x1;
y1(1) = y1(1) - 360;
y2(1) = y2(1) - 360;
y1(2) = y1(2) - 360;
y2(2) = y2(2) - 360;
jbfill(x1,y1,y2,'g','none','none',0.35);


x1 = 360 - HDMRT_unc.Io_east_long;
y1 = 360 - (HDMRT_unc.actual.south_MAW_phi_east + HDMRT_unc.south_MAW_phi_east) - x1;
y2 = 360 - (HDMRT_unc.actual.south_MAW_phi_east - HDMRT_unc.south_MAW_phi_east) - x1;
jbfill(x1,y1,y2,'g','none','none',0.35);


x1 = 360 - HDMRT_unc.Io_east_long;
y1 = 360 - (HDMRT_unc.actual.north_RAW_phi_east + HDMRT_unc.north_RAW_phi_east) - x1;
y2 = 360 - (HDMRT_unc.actual.north_RAW_phi_east - HDMRT_unc.north_RAW_phi_east) - x1;
y1(1) = y1(1) - 360;
y2(1) = y2(1) - 360;
y1(2) = y1(2) - 360;
y2(2) = y2(2) - 360;
jbfill(x1,y1,y2,'b','none','none',0.1);


x1 = 360 - HDMRT_unc.Io_east_long;
y1 = 360 - (HDMRT_unc.actual.south_RAW_phi_east + HDMRT_unc.south_RAW_phi_east) - x1;
y2 = 360 - (HDMRT_unc.actual.south_RAW_phi_east - HDMRT_unc.south_RAW_phi_east) - x1;
y1(1) = y1(1) - 360;
y2(1) = y2(1) - 360;
jbfill(x1,y1,y2,'b','none','none',0.1);


x1 = 360 - HDMRT_unc.Io_east_long;
y1 = 360 - (HDMRT_unc.actual.north_TEB_phi_east + HDMRT_unc.north_TEB_phi_east) - x1;
y2 = 360 - (HDMRT_unc.actual.north_TEB_phi_east - HDMRT_unc.north_TEB_phi_east) - x1;
y1(5) = y1(5) +1;
y2(5) = y2(5) +1;
y1(6) = y1(6) +.7;
y2(6) = y2(6) +.7;
y1(1) = y1(1) - 360;
y2(1) = y2(1) - 360;
y1(2) = y1(2) - 360;
y2(2) = y2(2) - 360;
jbfill(x1,y1,y2,'r','none','none',0.25);


x1 = 360 - HDMRT_unc.Io_east_long;
y1 = 360 - (HDMRT_unc.actual.south_TEB_phi_east + HDMRT_unc.south_TEB_phi_east) - x1;
y2 = 360 - (HDMRT_unc.actual.south_TEB_phi_east - HDMRT_unc.south_TEB_phi_east) - x1;
jbfill(x1,y1,y2,'r','none','none',0.25);


%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title(['Number Density of O+ Along Field Line L = ' num2str(L)],'fontweight','bold','fontsize',18)
title('(\phi_{IFP} - \phi_{Io}) vs \phi of Io','fontweight','bold','fontsize',18)
xlabel('\phi_{west} of Io','fontweight','bold','fontsize',18) % x-axis label
ylabel('\phi_{IFP} - \phi_{Io}','fontweight','bold','fontsize',18) % y-axis label
h_legend = legend('MAW (Prediction)','RAW (Prediction)','TEB (Prediction)',' MAW (HST ACS, Bonfond 2017)','RAW (HST ACS, Bonfond 2017)','TEB (HST ACS, Bonfond 2017)','Location','best');
set(h_legend,'FontSize',20);
%  xlim([0 395])
%  ylim([0 395])

HDMAW.Io_west_long  = HDMAW.Io_west_long';

HDMAW.north.phi_west = HDMAW.north.phi_west'
HDRAW.north.phi_west= HDRAW.north.phi_west'
HDTEB.north.phi_west = HDTEB.north.phi_west'

HDMAW.south.phi_west = HDMAW.south.phi_west'
HDRAW.south.phi_west =  HDRAW.south.phi_west'
HDTEB.south.phi_west = HDTEB.south.phi_west'

%csvwrite_with_headers('MAW_RAW_TEB_predictionsN.csv',[HDMAW.Io_west_long HDMAW.north.phi_west HDRAW.north.phi_west HDTEB.north.phi_west],{'Io_West_Long', 'MAW_north', 'RAW_north', 'TEB_north'})
%csvwrite_with_headers('MAW_RAW_TEB_predictionsS.csv',[HDMAW.Io_west_long HDMAW.south.phi_west HDRAW.south.phi_west HDTEB.south.phi_west],{'Io_West_Long', 'MAW_south', 'RAW_south', 'TEB_south'})

