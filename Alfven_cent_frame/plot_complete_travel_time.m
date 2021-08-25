
a = linspace(1,360,360);
a = a';
b = Index.Alfven_Travel_Time_Total/60;
b2 = Index.Alfven_Travel_Time_Total_terminate_35/60;
b3 = Index.Alfven_Travel_Time_Total_speed_of_light/60;
b4 = Index.Alfven_Travel_Time_Total_model/60;



b(68) = (b(67) + b(69))/2;
b(248) = (b(247) + b(249))/2;
b2(68) = (b2(67) + b2(69))/2;
b2(248) = (b2(247) + b2(249))/2;
b3(68) = (b3(67) + b3(69))/2;
b3(248) = (b3(247) + b3(249))/2;
b4(248) = (b4(247) + b4(249))/2;


y=b;
x=a;
y2=b2;
y3=b3;
y4=b4;

% M = movmedian(b,1);
figure()
subplot(2,1,1);
grid on
yy1 = smooth(x,y,0.1,'loess');
yy2 = smooth(x,y2,0.1,'loess');
yy3 = smooth(x,y3,0.1,'loess');
yy4 = smooth(x,y4,0.1,'loess');
[xx,ind] = sort(x);
% plot(xx,yy1(ind),'b-','linewidth',5)
% hold on
% plot(xx,yy2(ind),'m','linewidth',5)
% plot(xx,yy3(ind),'k--','linewidth',5)
% plot(xx,yy4(ind),'g','linewidth',3)


%plot(xx,y(ind),'r.', 'MarkerSize',1000)
% plot(xx,y2(ind),'r.', 'MarkerSize',2)
% plot(xx,y3(ind),'r.', 'MarkerSize',2)


% text(361,14,'w/o \theta > 35','fontweight','bold','fontname','Kannada MN','fontsize',16)
% text(361,15.5,'inc \theta > 35','fontweight','bold','fontname','Kannada MN','fontsize',16)
%listfonts to see all fonts


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
h_legend = legend('To Planet: V_A = V_{35}','To Planet: V_A = c', 'To +/- 35^\circ_{cent}','model','location','best');
set(h_legend,'FontSize',20);
% xlim([0 5])
 ylim([0 15])

subplot(2,1,2);
grid on
plot(x,Index.Alfven_Travel_Time_North/60,'b', 'Linewidth',2)
hold on
plot(x,Index.Alfven_Travel_Time_North_speed_of_light/60,'color','m', 'Linewidth',5)
p1 = plot(x,Index.Alfven_Travel_Time_North_terminate_35/60,'k', 'Linewidth',2);
plot(x,Index.Alfven_Travel_Time_North_model/60,'g', 'Linewidth',2);
plot(x,Index.Alfven_Travel_Time_South/60,'b', 'Linewidth',2)
plot(x,Index.Alfven_Travel_Time_South_speed_of_light/60,'color','m', 'Linewidth',5)
p2 = plot(x,Index.Alfven_Travel_Time_South_terminate_35/60,'k', 'Linewidth',2);
plot(x,Index.Alfven_Travel_Time_South_model/60,'g', 'Linewidth',2);

% Changing Opacities
 p1.Color(4) = 0.75;
 p2.Color(4) = 0.75;
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
title('North and South Travel Time vs East Longitude','fontweight','bold','fontsize',18)
xlabel('East Longitude','fontweight','bold','fontsize',18) % x-axis label
ylabel('Travel Time (min)','fontweight','bold','fontsize',18) % y-axis label
h_legend = legend('To Planet: V_A = V_{35}','To Planet: V_A = c', 'To +/- 35^\circ_{cent}','model','location','best');
set(h_legend,'FontSize',20);
ylim([0 15])



Field_line1 = 68;
Field_line2 = 158;
a1 = Index.Line_Index(Field_line1);
b1 = Index.Line_Index(Field_line1 +1) - 1;
a2 = Index.Line_Index(Field_line2);
b2 = Index.Line_Index(Field_line2 +1) - 1;

figure()
grid on
semilogy(sorted_lines_1_360.theta(a1:b1),sorted_lines_1_360.Alfven_speed(a1:b1),'k','linewidth',6);
hold on
semilogy(sorted_lines_1_360.theta(a2:b2),sorted_lines_1_360.Alfven_speed(a2:b2),'c','linewidth',5);

semilogy(sorted_lines_1_360.theta(a1:b1),sorted_lines_1_360.Alfven_speed_of_light(a1:b1),'g','linewidth',4);
semilogy(sorted_lines_1_360.theta(a2:b2),sorted_lines_1_360.Alfven_speed_of_light(a2:b2),'r','linewidth',2);

semilogy(sorted_lines_1_360.theta(a1:b1),sorted_lines_1_360.Alfven_speed_model(a1:b1),'b','linewidth',1);
semilogy(sorted_lines_1_360.theta(a2:b2),sorted_lines_1_360.Alfven_speed_model(a2:b2),'b','linewidth',1);



%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
title('Alfven Wave Speed at M = 6','fontweight','bold','fontsize',18)
xlabel('\theta_{spin}','fontweight','bold','fontsize',18) % x-axis label
ylabel('Alfven Speed Km/s','fontweight','bold','fontsize',18) % y-axis label
h_legend = legend('\phi =  68  V = V_{35}','\phi = 158 V = V_{35}','\phi =  68  V = c','\phi = 158 V = c','model','Location','best');
set(h_legend,'FontSize',20);
%xlim([-35 35])
%ylim([0 5])

figure()
grid on
semilogy(sorted_lines_1_360.theta(a1:b1),sorted_lines_1_360.Alfven_speed(a1:b1),'k','linewidth',2);
hold on
semilogy(sorted_lines_1_360.theta(a2:b2),sorted_lines_1_360.Alfven_speed(a2:b2),'m','linewidth',2);


%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
title('Alfven Wave Speed at M = 6','fontweight','bold','fontsize',18)
xlabel('\theta_{spin}','fontweight','bold','fontsize',18) % x-axis label
ylabel('Alfven Speed Km/s','fontweight','bold','fontsize',18) % y-axis label
h_legend = legend('\phi = 68','\phi = 158','Location','best');
set(h_legend,'FontSize',20);
%xlim([-35 35])
%ylim([0 5])