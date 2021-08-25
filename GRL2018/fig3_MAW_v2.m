%load('/Users/pahi9557/Documents/MATLAB/HDAlfven_JRM09/MAW_data_10_9.mat')
%load('/Users/pahi9557/Documents/MATLAB/HDAlfven_JRM09/MAW_RAW_10_15.mat')
load('/Users/pahi9557/Documents/MATLAB/HDAlfven_JRM09/MAW_RAW_11_2.mat')
load('/Users/pahi9557/Documents/MATLAB/HDAlfven_JRM09/HST_MAW_RAW.mat')


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

Lon_South(182) = Lon_South(182) +360;
Lon_South(190)= Lon_South(190) +360;
Lon_South(186) = Lon_South(186) +360;
Lon_South(210:223)= Lon_South(210:223) +360;
Lon_South(225) = Lon_South(225) +360;
Lon_South(227)= Lon_South(227) +360;
Lon_South(229) = Lon_South(229) +360;
Lon_South(231) = Lon_South(231) +360;
Lon_South(243:248)= Lon_South(243:248) +360;
Lon_South(239) = Lon_South(239) +360;
Lon_South(241) = Lon_South(241) +360;


Lon_South(17) = Lon_South(17) -360;
Lon_South(20) = Lon_South(20) -360;
Lon_South(22) = Lon_South(22) -360;
Lon_South(24) = Lon_South(24) -360;
Lon_South(26) = Lon_South(26) -360;
Lon_South(28) = Lon_South(28) -360;
Lon_South(30) = Lon_South(30) -360;
Lon_South(32) = Lon_South(32) -360;
Lon_South(34) = Lon_South(34) -360;







HDRAW.north.phi_west(1:18) = HDRAW.north.phi_west(1:18) - 360;
HDRAW.south.phi_west(1:4) = HDRAW.south.phi_west(1:4)- 360;
HDTEB.north.phi_west(1:12) = HDTEB.north.phi_west(1:12) - 360;
HDTEB.south.phi_west(358:360) = HDTEB.south.phi_west(358:360) + 360;

figure()
grid on

plot(HDMAW.Io_west_long,HDMAW.south.phi_west - HDMAW.Io_west_long,'k','linewidth',2);
hold on
plot(HDMAW.Io_west_long,HDRAW.north.phi_west - HDMAW.Io_west_long,'k--','linewidth',2);
plot(HDMAW.Io_west_long,HDTEB.north.phi_west - HDMAW.Io_west_long,'k:','linewidth',2);

e = errorbar(HST_2009.Io,HST_2009.NorthLon - HST_2009.Io,HST_2009.NorthErr,'.')
%e = errorbar(HST_2009.Io,HST_2009.NorthLon,HST_2009.NorthErr,'.')
%e.Marker = '*';
e.MarkerSize = 15;
e.Color = 1/255*[0 153 0];
%e.CapSize = 15;


for c = 1:length(Lon_North_RAW)
if abs(Lon_North_RAW(c)) > 1000
    Lon_North_RAW(c) = NaN;
end
end
clear c;
for c = 1:length(Lon_North_TEB)
if abs(Lon_North_TEB(c)) > 1000
    Lon_North_TEB(c) = NaN;
end
end
clear c;
[Io_sysIII_North, order] = sort(Io_sysIII_North);
Lon_North_RAW = Lon_North_RAW(order);
Lon_North_TEB = Lon_North_TEB(order);

clear order;
plot(Io_sysIII_North,Lon_North_RAW - Io_sysIII_North,'*','color',1/255*[51 51 255],'Markersize',3);
plot(Io_sysIII_North,Lon_North_TEB - Io_sysIII_North,'*','color',1/255*[255 51 51],'Markersize',3);

for c = 1:length(Lon_South_RAW)
if abs(Lon_South_RAW(c)) > 1000
    Lon_South_RAW(c) = NaN;
end
end
for c = 1:length(Lon_South_TEB)
if abs(Lon_South_TEB(c)) > 1000
    Lon_South_TEB(c) = NaN;
end
end
clear c;
[Io_sysIII_South, order] = sort(Io_sysIII_South);
Lon_South_RAW = Lon_South_RAW(order);
Lon_South_TEB = Lon_South_TEB(order);
clear order;

Lon_South_RAW(212:221) = Lon_South_RAW(212:221) + 360;
Lon_South_RAW(225) = Lon_South_RAW(225) + 360;
Lon_South_RAW(227) = Lon_South_RAW(227) + 360;
Lon_South_RAW(231) = Lon_South_RAW(231) + 360;
Lon_South_RAW(239) = Lon_South_RAW(239) + 360;
Lon_South_RAW(244) = Lon_South_RAW(244) + 360;
Lon_South_RAW(247) = Lon_South_RAW(247) + 360;

Lon_South_TEB(17) = Lon_South_TEB(17) - 360;
Lon_South_TEB(20) = Lon_South_TEB(20) - 360;
Lon_South_TEB(22) = Lon_South_TEB(22) - 360;
Lon_South_TEB(24) = Lon_South_TEB(24) - 360;
Lon_South_TEB(26) = Lon_South_TEB(26) - 360;
Lon_South_TEB(28) = Lon_South_TEB(28) - 360;
Lon_South_TEB(30) = Lon_South_TEB(30) - 360;
Lon_South_TEB(32) = Lon_South_TEB(32) - 360;
Lon_South_TEB(34) = Lon_South_TEB(34) - 360;
Lon_South_TEB(212) = Lon_South_TEB(212) + 360;
Lon_South_TEB(216) = Lon_South_TEB(216) + 360;
Lon_South_TEB(218) = Lon_South_TEB(218) + 360;
Lon_South_TEB(225) = Lon_South_TEB(225) + 360;
Lon_South_TEB(239) = Lon_South_TEB(239) + 360;
Lon_South_TEB(246) = Lon_South_TEB(246) + 360;
Lon_South_TEB(244) = Lon_South_TEB(244) + 360;



plot(Io_sysIII_South,Lon_South_RAW - Io_sysIII_South,'*','color',1/255*[51 51 255],'Markersize',3);
plot(Io_sysIII_South,Lon_South_TEB - Io_sysIII_South,'*','color',1/255*[255 51 51],'Markersize',3);

%plot(Io_sysIII_South,Lon_South_RAW,'g*','Markersize',3);
%plot(HDMAW.Io_west_long,HDRAW.south.phi_west,'k','linewidth',2);
%plot(Io_sysIII_South,Lon_South_TEB,'y*','Markersize',3);
% plot(Io_sysIII_North,Lon_North,'r*','Markersize',3);

e = errorbar(HST_2009.Io,HST_2009.SouthLon - HST_2009.Io,HST_2009.SouthErr,'.')
e.MarkerSize = 15;
e.Color =  1/255*[0 153 0];;

plot(HDMAW.Io_west_long,HDMAW.north.phi_west - HDMAW.Io_west_long,'k','linewidth',2);
plot(HDMAW.Io_west_long,HDRAW.south.phi_west - HDMAW.Io_west_long,'k--','linewidth',2);
plot(HDMAW.Io_west_long,HDTEB.south.phi_west - HDMAW.Io_west_long,'k:','linewidth',2);
%plot(Io_sysIII_North,Lon_North_RAW,'g*','Markersize',3);
%plot(Io_sysIII_North,Lon_North_TEB,'y*','Markersize',3);


text(361,0,'South','fontweight','bold','fontname','Kannada MN','fontsize',18)
text(361,-33,'North','fontweight','bold','fontname','Kannada MN','fontsize',18)







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
h_legend = legend('MAW (Prediction)','RAW (Prediction)','TEB (Prediction)',' MAW (HST ACS, Bonfond 2009)','RAW (Bonfond)','TEB (Bonfond)','Location','best');
set(h_legend,'FontSize',20);
%  xlim([0 395])
%  ylim([0 395])



