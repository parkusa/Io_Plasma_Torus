load('/Users/pahi9557/Documents/MATLAB/Alfven_Waves/AW_data_prep/full_field_data_1_360.mat')
a = 1:359;
a = a';
b = Index.Alfven_Travel_Time_Total/60;

% b(68) = (b(67) + b(69))/2;
% b(248) = (b(247) + b(249))/2;
y=b;
x=a;
% M = movmedian(b,1);
figure()
grid on
yy1 = smooth(x,y,0.1,'loess');
[xx,ind] = sort(x);
plot(xx,y(ind),'r.', 'MarkerSize',10)
hold on
plot(xx,yy1(ind),'k-','linewidth',2)

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
%h_legend = legend('Ne','O+', 'O++', 'O+Hot', 'Location','best');
%set(h_legend,'FontSize',20);
% xlim([0 5])
% ylim([0 5])

