x = linspace(0,782.61,782);
y = x*0.46;

figure()
grid on
plot(x,y,'k','linewidth',2);
hold on


%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title(['Number Density of O+ Along Field Line L = ' num2str(L)],'fontweight','bold','fontsize',18)
title('Io sys 3 long vs Time','fontweight','bold','fontsize',18)
xlabel('Time (hours)','fontweight','bold','fontsize',18) % x-axis label
ylabel('Longitude','fontweight','bold','fontsize',18) % y-axis label
%h_legend = legend('Ne','O+', 'O++', 'O+Hot', 'Location','best');
%set(h_legend,'FontSize',20);
% xlim([0 5])
% ylim([0 5])