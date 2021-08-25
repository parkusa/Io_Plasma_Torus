%load('/Users/pahi9557/Documents/MATLAB/Alfven_Waves/Power_generated/power_generated.mat')
load('/Users/pahi9557/Documents/MATLAB/Alfven_JRM09/data_prep_jrm09/JRM09_Alfven_Model.mat')
%load('/Users/pahi9557/Documents/MATLAB/Alfven_Waves/Power_generated/power_generated_JRM09.mat')


Index_JRM09 = Index;

a = linspace(0,359,360);
a = a';
b = Index.Alfven_Travel_Time_Total/60;
b2 =  Index_JRM09.Alfven_Travel_Time_Total/60;

y=b;
x=a;
y2=b2;


% xx = 360 - x;
% xx = xx*(pi/180);

       %Value  | coefficient  | confidence inetrval

       a0 =       7.215  ;%(7.162, 7.269)
       a1 =       4.671  ;%(4.639, 4.704)
       b1 =      -1.193 ;% (-1.368, -1.018)
       a2 =     -0.3442;%  (-0.3956, -0.2927)
       b2 =    -0.07916;%  (-0.1302, -0.02815)
       a3 =     -0.1018;%  (-0.114, -0.08955)
       b3 =       0.096 ;
       w =      0.9907  ;
north_fourier = a0 + a1*cosd(x*w) + b1*sind(x*w) + a2*cosd(2*x*w) + b2*sind(2*x*w) + a3*cosd(3*x*w) + b3*sind(3*x*w);
      a0 =       6.678 ;% (6.651, 6.704)
       a1 =      -3.946  ;%(-3.98, -3.911)
       b1 =        1.82  ;%(1.737, 1.902)
       a2 =      0.3235 ;% (0.3001, 0.347)
       b2 =       0.012  ;%(-0.02392, 0.04792)
       a3 =     0.07189;%  (0.06026, 0.08351)
       b3 =      -0.161  ;%(-0.1775, -0.1444)
       w =      0.9931  ;%(0.9859, 1)
south_fourier = a0 + a1*cosd(x*w) + b1*sind(x*w) + a2*cosd(2*x*w) + b2*sind(2*x*w) + a3*cosd(3*x*w) + b3*sind(3*x*w);




figure(1)







grid on
plot(x,Index_JRM09.Alfven_Travel_Time_North/60,'b', 'Linewidth',5)
%plot(xx,y, 'm', 'Linewidth',2)
hold on;


plot(x,north_fourier, 'g', 'Linewidth',2)
plot(x,Index_JRM09.Alfven_Travel_Time_South/60,'b', 'Linewidth',5)
plot(x,south_fourier, 'g', 'Linewidth',2)
%plot(fitresult,'g');

hold on
%plot(x,Index.Alfven_Travel_Time_North/60,'b', 'Linewidth',2)
hold on;
%p3 = plot(x,Index.Alfven_Travel_Time_South/60,'r', 'Linewidth',2);


x1 = x';
y1 = (Index_JRM09.Alfven_Travel_Time_North_upper/60)';
y2 = (Index_JRM09.Alfven_Travel_Time_North/60)';
jbfill(x1,y1,y2,'b','none','none',0.25)

x1 = x';
y1 = (Index_JRM09.Alfven_Travel_Time_South_upper/60)';
y2 = (Index_JRM09.Alfven_Travel_Time_South/60)';
jbfill(x1,y1,y2,'b','none','none',0.25)
hold on
plot(x,north_fourier, 'g', 'Linewidth',2)
plot(x,south_fourier, 'g', 'Linewidth',2)

text(297,27,'2(North + South)','fontweight','bold','fontname','Kannada MN','fontsize',22)
text(331,11,'North','fontweight','bold','fontname','Kannada MN','fontsize',22)
text(331,3.8,'South','fontweight','bold','fontname','Kannada MN','fontsize',22)
%listfonts to see all fonts
%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title('North and South (One Way) Travel Time vs East Longitude','fontweight','bold','fontsize',18)
xlabel('East Jovigraphic Longitude','fontsize',18) % x-axis label
ylabel('Travel Time (min)','fontsize',18) % y-axis label
h_legend = legend('JRM09','Fourier fit','Location','best','AutoUpdate','off');
set(h_legend,'fontsize',22);
%ylim([0 15])
xlim([0 360])

% 
% %generating new x tixk values
% xt= sort(360 - xticks);
% %%getting rid of old tick marks at top
%   box off
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
% %linkaxes([ax1, ax2])
% %title('2^{nd} Harmonics');
% xlabel('West Jovigraphic Longitude','fontsize',16) % x-axis label
% title('Io to Jupiter Travel Time','fontweight','bold','fontsize',22)
% xlim([0 360])
% set(gca,'xtick',xt)
% set(gca, 'xdir', 'reverse')
% set(gca,'FontSize',16)
% 
% 
% 
% 
% 
% 
% subplot(2,1,1);
fourierx = x;
grid on


%hax1 = axes();

yy1 = smooth(x,y,0.1,'loess');
yy2 = smooth(x,y2,0.1,'loess');
[xx,ind] = sort(x);
%plot(xx,yy2(ind),'b','linewidth',2);



%load('/Users/pahi9557/Documents/MATLAB/Alfven_JRM09/data_prep_jrm09/JRM09_Alfven_Model.mat')
a = linspace(1,360,360);
a = a';
b = Index_JRM09.Alfven_Travel_Time_Total/60;
b2 = Index_JRM09.Alfven_Travel_Time_Total_upper/60;
b3 = Index_JRM09.Alfven_Travel_Time_Total_lower/60;
y=b;
x=a;
y2=b2;
y3=b3;
grid on
%hax1 = axes();
yy1 = smooth(x,y,0.1,'loess');
yy2 = smooth(x,y2,0.1,'loess');
yy3 = smooth(x,y3,0.1,'loess');
[xx,ind] = sort(x);
plot(xx,2*yy1(ind),'b','linewidth',4)
hold on
% curve1 = plot(xx,yy2(ind),'b--','linewidth',1);
% curve2 = plot(xx,yy3(ind),'b--','linewidth',1);
x1 = x';
y1 = 2*(yy1)';
y2 = 2*(yy2)';
jbfill(x1,y1,y2,'b','none','none',0.25)

hold on

plot(x,2*(north_fourier+south_fourier), 'g', 'Linewidth',2)


Hemisphere = {'North';'South'};
a0 = 7.215;
a1 = 4.671;
b1 = -1.193;
a2 = -0.3442;
b2 = -0.07916;
a3 = -0.1018;
b3 = 0.096;
w  = 0.9907;
a0 = [a0; 6.678];
a1 = [a1; -3.946];
b1 = [b1; 1.82];
a2 = [a2; 0.3235];
b2 = [b2; 0.012];
a3 = [a3; 0.07189];
b3 = [b3; -0.161];
w  = [w; 0.9931];
Age = [38;43;38;40;49];
Height = [71;69;64;67;64];
Weight = [176;163;131;133;119];
T = table(a0,a1,b1,a2,b2,a3,b3,w,'RowNames',Hemisphere);


% Get the table in string form.
TString = evalc('disp(T)');

% Use TeX Markup for bold formatting and underscores.
TString = strrep(TString,'<strong>','');
TString = strrep(TString,'</strong>','');
%TString = strrep(TString,'_','\_');

% Get a fixed-width font.
FixedWidth = get(0,'FixedWidthFontName');

% Output the table using the annotation command.
annotation(gcf,'Textbox','String',TString,'Interpreter','Tex',...
    'FontName',FixedWidth,'FontSize',16,'Fontweight','bold','Units','Normalized','Position',[.15 0.41 .75 .15]);




%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title('Period of Complete Travel Time vs East Longitude','fontweight','bold','fontsize',18)
xlabel('East Jovigraphic Longitude','fontsize',18) % x-axis label
ylabel('Travel Time (min)','fontsize',18) % y-axis label
% hi_legend = legend('Fourier fit','JRM09','Location','best');
% set(hi_legend,'fontsize',22);
xlim([0 360])
ylim([0 38])
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
ylim([0 38])
%adding new top axis
ax1_pos = get(gca,'Position');
ax2 = axes('Position', ax1_pos,...
           'XAxisLocation', 'top',... 
           'YAxisLocation', 'right',...
           'Color', 'none');
set(ax2,'YColor','none');
%linkaxes([ax1, ax2])
title('Travel Times','fontweight','bold','fontsize',18)
xlabel('West Jovigraphic Longitude','fontsize',16) % x-axis label
%title(['Integer Wave Front Locations when Io is at \phi =  ' num2str(desired_phi)],'fontweight','bold','fontsize',22)
xlim([0 360])
ylim([0 38])
set(gca,'xtick',xt)
set(gca, 'xdir', 'reverse')
set(gca,'FontSize',16)



