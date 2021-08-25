%load('/Users/pahi9557/Documents/MATLAB/Alfven_Waves/Power_generated/power_generated.mat')
load('/Users/pahi9557/Documents/MATLAB/Alfven_JRM09/data_prep_VIP4/VIP4_Alfven_Model.mat')
load('/Users/pahi9557/Documents/MATLAB/Alfven_Waves/Power_generated/power_generated_JRM09.mat')


a = linspace(0,359,360);
a = a';
b = Index.Alfven_Travel_Time_Total/60;
b2 =  Index_JRM09.Alfven_Travel_Time_Total/60;

y=b;
x=a;
y2=b2;


xx = 360 - x;
xx = xx*(pi/180);


a0 = 7.215;
a1 = 4.733;
b1 = 0.9179;
a2 = -0.3325;
b2 = 0.1188;
a3 = -0.117;
b3 = -0.07673;
w  = 0.9907;
north_fourier = a0 + a1*cos(xx*w) + b1*sin(xx*w) + a2*cos(2*xx*w) + b2*sin(2*xx*w) + a3*cos(3*xx*w) + b3*sin(3*xx*w);
a0 = 6.678;
a1 = -4.021;
b1 = -1.646;
a2 = 0.3213;
b2 = -0.04016;
a3 = 0.09229;
b3 = 0.1502;
w  = 0.9931;
south_fourier = a0 + a1*cos(xx*w) + b1*sin(xx*w) + a2*cos(2*xx*w) + b2*sin(2*xx*w) + a3*cos(3*xx*w) + b3*sin(3*xx*w);



% M = movmedian(b,1);
figure()
subplot(2,1,1);
plot(x,north_fourier+south_fourier, 'g', 'Linewidth',2)
grid on
hold on

%hax1 = axes();

yy1 = smooth(x,y,0.1,'loess');
yy2 = smooth(x,y2,0.1,'loess');


[xx,ind] = sort(x);
%plot(xx,yy2(ind),'b','linewidth',2);


%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title('Period of Complete Travel Time vs East Longitude','fontweight','bold','fontsize',18)
%xlabel('North and South (One Way) Travel Time vs East Longitude','fontweight','bold','fontsize',18) % x-axis label
ylabel('Travel Time (min)','fontsize',18) % y-axis label
hi_legend = legend('Fourier fit','JRM09','Location','best');
set(hi_legend,'FontSize',20);
% xlim([0 5])
ylim([12 15])




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
ylim([12 15])
%adding new top axis
ax1_pos = get(gca,'Position');
ax2 = axes('Position', ax1_pos,...
           'XAxisLocation', 'top',... 
           'YAxisLocation', 'right',...
           'Color', 'none');
set(ax2,'YColor','none');
%linkaxes([ax1, ax2])
title('North + South Travel Time (One Way)','fontweight','bold','fontsize',18)
xlabel('West Jovigraphic Longitude','fontsize',16) % x-axis label
%title(['Integer Wave Front Locations when Io is at \phi =  ' num2str(desired_phi)],'fontweight','bold','fontsize',20)
xlim([0 360])
ylim([12 15])
set(gca,'xtick',xt)
set(gca, 'xdir', 'reverse')
set(gca,'FontSize',16)









% y = Index_JRM09.Alfven_Travel_Time_North/60;
% yu = max(y);
% yl = min(y);
% yr = (yu-yl);
% A = yr/2; 
% C = yu - A;
% yy = A*cosd(xx-13)+C;
% 
% 
% y = Index_JRM09.Alfven_Travel_Time_South/60;
% yu = max(y);
% yl = min(y);
% yr = (yu-yl);
% A = yr/2; 
% C = yu - A;
% 
% yyy = A*cosd(xx+155)+C;


% y = Index_JRM09.Alfven_Travel_Time_North/60;
%xx_rad = xx*(pi/180);


% [xData, yData] = prepareCurveData( xx, y );
% % Set up fittype and options.
% ft = fittype( 'fourier3' );
% opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
% opts.Display = 'Off';
% opts.StartPoint = [0 0 0 0 0 0 0 1.00278551532033];
% % Fit model to data.
% [fitresult, gof] = fit( xData, yData, ft, opts );
% 
% y = Index_JRM09.Alfven_Travel_Time_South/60;
%xx_rad = xx*(pi/180);
% [xData, yData] = prepareCurveData( xx, y );
% % Set up fittype and options.
% ft = fittype( 'fourier3' );
% opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
% opts.Display = 'Off';
% opts.StartPoint = [0 0 0 0 0 0 0 1.00278551532033];
% % Fit model to data.
% [fitresult, gof] = fit( xData, yData, ft, opts );

% x = x*(pi/180);



subplot(2,1,2);



grid on
plot(x,Index_JRM09.Alfven_Travel_Time_North/60,'b', 'Linewidth',5)
%plot(xx,y, 'm', 'Linewidth',2)
hold on;
%plot(x,Index_JRM09.Alfven_Travel_Time_South/60,'b', 'Linewidth',4);
% plot(x,yy, 'm', 'Linewidth',2)
% plot(x,yyy, 'm', 'Linewidth',2)
plot(x,north_fourier, 'g', 'Linewidth',2)
plot(x,Index_JRM09.Alfven_Travel_Time_South/60,'b', 'Linewidth',5)
plot(x,south_fourier, 'g', 'Linewidth',2)
%plot(fitresult,'g');



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
%title('North and South (One Way) Travel Time vs East Longitude','fontweight','bold','fontsize',18)
xlabel('East Jovigraphic Longitude','fontsize',18) % x-axis label
ylabel('Travel Time (min)','fontsize',18) % y-axis label
h_legend = legend('JRM09','Fourier fit','Location','best');
set(h_legend,'FontSize',20);
%ylim([0 15])



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
%linkaxes([ax1, ax2])
%title('2^{nd} Harmonics');
%xlabel('WEST JOVIGRAPHIC LONGITUDE','fontweight','bold','fontsize',16) % x-axis label
title('Io to Jupiter Travel Time','fontweight','bold','fontsize',20)
xlim([0 360])
set(gca,'xtick',xt)
set(gca, 'xdir', 'reverse')
set(gca,'FontSize',16)

% subplot(2,1,1);
% plot(x,north_fourier+south_fourier, 'g', 'Linewidth',2)
% %plot(x,Index_JRM09.Alfven_Travel_Time_North/60+Index_JRM09.Alfven_Travel_Time_South/60,'y', 'Linewidth',2)
% hi_legend = legend('JRM09','Fourier Fit', 'Location','best');