
a = 0:0.1:359.9;
a = a';
b = Index.Alfven_Travel_Time_Total/60;
b2 = Index.Alfven_Travel_Time_Total_upper/60;
b3 = Index.Alfven_Travel_Time_Total_lower/60;




% b(68) = (b(67) + b(69))/2;
% b(248) = (b(247) + b(249))/2;
% b2(68) = (b2(67) + b2(69))/2;
% b2(248) = (b2(247) + b2(249))/2;
% b3(68) = (b3(67) + b3(69))/2;
% b3(248) = (b3(247) + b3(249))/2;



y=b;
x=a;
y2=b2;
y3=b3;


% M = movmedian(b,1);
figure()
subplot(2,1,1);
grid on

%hax1 = axes();

yy1 = smooth(x,y,0.1,'loess');
yy2 = smooth(x,y2,0.1,'loess');
yy3 = smooth(x,y3,0.1,'loess');

[xx,ind] = sort(x);
plot(xx,yy1(ind),'b','linewidth',2)
hold on
curve1 = plot(xx,yy2(ind),'b--','linewidth',1);
curve2 = plot(xx,yy3(ind),'b--','linewidth',1);

x1 = x';
y1 = (yy2)';
y2 = (yy3)';
jbfill(x1,y1,y2,'b','none','none',0.5)


% 
% hax2 = axes('Position', get(hax1, 'Position'), ...  % Copy position
%             'XAxisLocation', 'top');                % Put the x axis on to

% Plot data with a different x-range here
%hplot2 = plot((360 - x), y3(ind),'LineStyle','--','Color','b','linewidth',1);


% X=[xx,fliplr(xx)];                %#create continuous x value array for plotting
% Y=[yy2,fliplr(yy3)];              %#create y values for out and then back
% fill(X,Y,'b'); 



%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
title('Period of Complete Travel Time vs East Longitude','fontweight','bold','fontsize',18)
xlabel('East Longitude','fontweight','bold','fontsize',18) % x-axis label
ylabel('Travel Time (min)','fontweight','bold','fontsize',18) % y-axis label
%h_legend = legend('To Planet: V_A = V_{35}','To Planet: V_A = c', 'To +/- 35^\circ_{cent}','model','location','best');
%set(h_legend,'FontSize',20);
% xlim([0 5])
% ylim([0 15])

subplot(2,1,2);
grid on
plot(x,Index.Alfven_Travel_Time_North/60,'b', 'Linewidth',2)
hold on;
p1 = plot(x,Index.Alfven_Travel_Time_North_upper/60,'b--', 'Linewidth',1);
p2 = plot(x,Index.Alfven_Travel_Time_North_lower/60,'b--', 'Linewidth',1);
p3 = plot(x,Index.Alfven_Travel_Time_South/60,'r', 'Linewidth',2);
p4 = plot(x,Index.Alfven_Travel_Time_South_upper/60,'r--', 'Linewidth',1);
p5 = plot(x,Index.Alfven_Travel_Time_South_lower/60,'r--', 'Linewidth',1);

x1 = x';
y1 = (Index.Alfven_Travel_Time_North_upper/60)';
y2 = (Index.Alfven_Travel_Time_North_lower/60)';
jbfill(x1,y1,y2,'b','none','none',0.5)

x1 = x';
y1 = (Index.Alfven_Travel_Time_South_upper/60)';
y2 = (Index.Alfven_Travel_Time_South_lower/60)';
jbfill(x1,y1,y2,'r','none','none',0.5)




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


% 
% Field_line1 = 68;
% Field_line2 = 158;
% a1 = Index.Line_Index(Field_line1);
% b1 = Index.Line_Index(Field_line1 +1) - 1;
% a2 = Index.Line_Index(Field_line2);
% b2 = Index.Line_Index(Field_line2 +1) - 1;
% 
% figure()
% grid on
% semilogy(sorted_lines_1_360.theta(a1:b1),sorted_lines_1_360.Alfven_speed(a1:b1),'k','linewidth',2);
% hold on
% semilogy(sorted_lines_1_360.theta(a2:b2),sorted_lines_1_360.Alfven_speed(a2:b2),'m','linewidth',2);
% 
% semilogy(sorted_lines_1_360.theta(a1:b1),sorted_lines_1_360.Alfven_speed_relativistic(a1:b1),'r','linewidth',3);
% semilogy(sorted_lines_1_360.theta(a2:b2),sorted_lines_1_360.Alfven_speed_relativistic(a2:b2),'r','linewidth',3);
% 
% semilogy(sorted_lines_1_360.theta(a1:b1),sorted_lines_1_360.Alfven_speed_upper(a1:b1),'k--','linewidth',1);
% semilogy(sorted_lines_1_360.theta(a2:b2),sorted_lines_1_360.Alfven_speed_upper(a2:b2),'m--','linewidth',1);
% 
% semilogy(sorted_lines_1_360.theta(a1:b1),sorted_lines_1_360.Alfven_speed_lower(a1:b1),'k--','linewidth',1);
% semilogy(sorted_lines_1_360.theta(a2:b2),sorted_lines_1_360.Alfven_speed_lower(a2:b2),'m--','linewidth',1);
% 
% 
% x1 = sorted_lines_1_360.theta(a1:b1)';
% y1 = sorted_lines_1_360.Alfven_speed_lower(a1:b1)';
% y2 = sorted_lines_1_360.Alfven_speed_upper(a1:b1)';
% 
% jbfill(x1,y1,y2,'k','none','none',0.5)
% 
% x1 = sorted_lines_1_360.theta(a2:b2)';
% y1 = sorted_lines_1_360.Alfven_speed_lower(a2:b2)';
% y2 = sorted_lines_1_360.Alfven_speed_upper(a2:b2)';
% 
% jbfill(x1,y1,y2,'m','none','none',0.25)
% 
% 
% %yt=[ 10:20:100 200:200:1000 2000 3000];
% %set(gca,'ytick',yt)
% set(gca,'yminorgrid','on')
% %xt=[0:1:6];
% %set(gca,'xtick',xt)
% set(gca,'xminorgrid','on')
% set(gca,'FontSize',16)
% title('Alfven Wave Speed at M = 6','fontweight','bold','fontsize',18)
% xlabel('\theta_{spin}','fontweight','bold','fontsize',18) % x-axis label
% ylabel('Alfven Speed Km/s','fontweight','bold','fontsize',18) % y-axis label
% h_legend = legend('\phi =  68','\phi = 158','Location','best');
% set(h_legend,'FontSize',20);
% %xlim([-35 35])
% %ylim([0 5])
% 
% 
% Field_line1 = 67;
% Field_line2 = 68;
% Field_line3 = 69;
% a1 = Index.Line_Index(Field_line1);
% b1 = Index.Line_Index(Field_line1 +1) - 1;
% a2 = Index.Line_Index(Field_line2);
% b2 = Index.Line_Index(Field_line2 +1) - 1;
% a3 = Index.Line_Index(Field_line3);
% b3 = Index.Line_Index(Field_line3 +1) - 1;
% 
% 
% 
% figure()
% grid on
% semilogy(sorted_lines_1_360.theta(a1:b1),sorted_lines_1_360.Alfven_speed(a1:b1),'k','linewidth',5);
% hold on
% semilogy(sorted_lines_1_360.theta(a2:b2),sorted_lines_1_360.Alfven_speed(a2:b2),'m','linewidth',5);
% semilogy(sorted_lines_1_360.theta(a3:b3),sorted_lines_1_360.Alfven_speed(a3:b3),'b','linewidth',5);
% 
% 
% %yt=[ 10:20:100 200:200:1000 2000 3000];
% %set(gca,'ytick',yt)
% set(gca,'yminorgrid','on')
% %xt=[0:1:6];
% %set(gca,'xtick',xt)
% set(gca,'xminorgrid','on')
% set(gca,'FontSize',16)
% title('Alfven Wave Speed at M = 6','fontweight','bold','fontsize',18)
% xlabel('\theta_{spin}','fontweight','bold','fontsize',18) % x-axis label
% ylabel('Alfven Speed Km/s','fontweight','bold','fontsize',18) % y-axis label
% h_legend = legend('\phi =  67','\phi = 68','\phi = 69','Location','best');
% set(h_legend,'FontSize',20);
% %xlim([-35 35])
% %ylim([0 5])
% 
% 
% Field_line1 = 68;
% 
% a1 = Index.Line_Index(Field_line1);
% b1 = Index.Line_Index(Field_line1 +1) - 1;
% 
% 
% figure()
% grid on
% semilogy(sorted_lines_1_360.theta(a1:b1),mass_density.mass_density(a1:b1),'k','linewidth',5);
% hold on
% %yt=[ 10:20:100 200:200:1000 2000 3000];
% %set(gca,'ytick',yt)
% set(gca,'yminorgrid','on')
% %xt=[0:1:6];
% %set(gca,'xtick',xt)
% set(gca,'xminorgrid','on')
% set(gca,'FontSize',16)
% title('Flux Tube Content M = 6','fontweight','bold','fontsize',18)
% xlabel('\theta_{spin}','fontweight','bold','fontsize',18) % x-axis label
% ylabel('kg/cm^3','fontweight','bold','fontsize',18) % y-axis label
% h_legend = legend('\phi =  68','\phi = 68','\phi = 69','Location','best');
% set(h_legend,'FontSize',20);
% %xlim([-35 35])
% %ylim([0 5])
% 
% figure()
% grid on
% semilogy(sorted_lines_1_360.theta(a1:b1),sorted_lines_1_360.B_Mag(a1:b1),'k','linewidth',5);
% hold on
% %yt=[ 10:20:100 200:200:1000 2000 3000];
% %set(gca,'ytick',yt)
% set(gca,'yminorgrid','on')
% %xt=[0:1:6];
% %set(gca,'xtick',xt)
% set(gca,'xminorgrid','on')
% set(gca,'FontSize',16)
% title('B field M = 6','fontweight','bold','fontsize',18)
% xlabel('\theta_{spin}','fontweight','bold','fontsize',18) % x-axis label
% ylabel('T','fontweight','bold','fontsize',18) % y-axis label
% h_legend = legend('\phi =  68','\phi = 68','\phi = 69','Location','best');
% set(h_legend,'FontSize',20);
% %xlim([-35 35])
% %ylim([0 5])


