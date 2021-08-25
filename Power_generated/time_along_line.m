load('/Users/pahi9557/Documents/MATLAB/Alfven_JRM09/data_prep_jrm09/JRM09_Alfven_Model.mat')
%North Alfven Travel Time
counter1 = 276;

if counter1 < 360
    a = characteristic.North.index(counter1);
    b = characteristic.North.index(counter1 +1) - 1;
end
if counter1 == 360
    a = characteristic.North.index(counter1);
    b = length(characteristic.North.there.time); %last value in the list
end

figure()
grid on
semilogy(characteristic.North.there.theta(a:b),characteristic.North.there.time(a:b),'k','linewidth',2);
hold on


%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
title(['Travel Time Along Field Line \Phi ' num2str(counter1 - 1)],'fontweight','bold','fontsize',18)
%title('\theta (normal latitude) vs Time','fontweight','bold','fontsize',18)
xlabel('\theta_{spin}','fontweight','bold','fontsize',18) % x-axis label
ylabel('time (s)','fontweight','bold','fontsize',18) % y-axis label
%h_legend = legend('Ne','O+', 'O++', 'O+Hot', 'Location','best');
%set(h_legend,'FontSize',20);
% xlim([0 5])
% ylim([0 5])



