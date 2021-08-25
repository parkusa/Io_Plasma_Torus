load('/Users/pahi9557/Documents/MATLAB/Alfven_JRM09/data_prep_VIP4/VIP4_Alfven_Model.mat')
load('/Users/pahi9557/Documents/MATLAB/Alfven_Waves/Power_generated/power_generated_JRM09.mat')



philosphersstone = 1;
mkdir temporary
fname = 'temporary';



for counter = 1:360
close all

% counter = 250;
figure(1)


if counter < 360
a = Index_JRM09.Line_Index(counter);
b = Index_JRM09.Line_Index(counter +1) - 1;
end

if counter == 360
a = Index_JRM09.Line_Index(counter);
b = length(sorted_lines_1_360_JRM09.phi);
end

if counter == 1
a1 = Index.Line_Index(360);
b1 = length(sorted_lines_1_360.phi);
end

if counter > 1
a1 = Index.Line_Index(counter-1);
b1 = Index.Line_Index(counter) - 1;
end

subplot(3,1,1);
grid on
semilogy(sorted_lines_1_360_JRM09.theta(a:b),sorted_lines_1_360_JRM09.Alfven_speed(a:b),'b','linewidth',0.5);
hold on
semilogy(sorted_lines_1_360.theta(a1:b1),sorted_lines_1_360.Alfven_speed(a1:b1),'r','linewidth',0.5);
%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
title(['Alfven Speed at East \Phi = ' num2str(counter -1)],'fontweight','bold','fontsize',18)
%title('\theta (normal latitude) vs Time','fontweight','bold','fontsize',18)
%xlabel('\theta_{spin}','fontweight','bold','fontsize',18) % x-axis label
ylabel('Km/s','fontweight','bold','fontsize',18) % y-axis label
h_legend = legend('JRM09','VIP4', 'O++', 'O+Hot', 'Location','best');
set(h_legend,'FontSize',16);
xlim([-90 90])
% ylim([0 5])



subplot(3,1,2);
grid on
semilogy(sorted_lines_1_360_JRM09.theta(a:b),sorted_lines_1_360_JRM09.B_Mag(a:b),'b','linewidth',0.5);
hold on
semilogy(sorted_lines_1_360.theta(a1:b1),sorted_lines_1_360.B_Mag(a1:b1),'r','linewidth',0.5);
%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title(['Alfven Speed at East \Phi = ' num2str(counter -1)],'fontweight','bold','fontsize',18)
%title('\theta (normal latitude) vs Time','fontweight','bold','fontsize',18)
%xlabel('\theta_{spin}','fontweight','bold','fontsize',18) % x-axis label
ylabel('T','fontweight','bold','fontsize',18) % y-axis label
%h_legend = legend('Ne','O+', 'O++', 'O+Hot', 'Location','best');
%set(h_legend,'FontSize',20);
xlim([-90 90])
% ylim([0 5])


subplot(3,1,3);
grid on
semilogy(sorted_lines_1_360_JRM09.theta(a:b),mass_density_JRM09.mass_density(a:b),'b','linewidth',0.5);
hold on
semilogy(sorted_lines_1_360.theta(a1:b1),mass_density.mass_density(a1:b1),'r','linewidth',0.5);
%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title(['Alfven Speed at East \Phi = ' num2str(counter -1)],'fontweight','bold','fontsize',18)
%title('\theta (normal latitude) vs Time','fontweight','bold','fontsize',18)
xlabel('\theta_{spin}','fontweight','bold','fontsize',18) % x-axis label
ylabel('kg/cm^3','fontweight','bold','fontsize',18) % y-axis label
%h_legend = legend('Ne','O+', 'O++', 'O+Hot', 'Location','best');
%set(h_legend,'FontSize',20);
xlim([-90 90])
% ylim([0 5])




%set(figure(1), 'Position', get(0, 'Screensize'));
pause(.35)

     
     if philosphersstone < 9
         saveas(gca,fullfile(fname,['fig000' num2str(philosphersstone)]),'jpeg');
     end
     
     if philosphersstone < 99
         if philosphersstone > 9
             saveas(gca,fullfile(fname,['fig00' num2str(philosphersstone)]),'jpeg');
         end
     end
     
     if philosphersstone < 999
         if philosphersstone > 99
             saveas(gca,fullfile(fname,['fig0' num2str(philosphersstone)]),'jpeg');
         end
     end
     if philosphersstone < 9999
         if philosphersstone > 999
             saveas(gca,fullfile(fname,['fig0' num2str(philosphersstone)]),'jpeg');
         end
     end
     
     
     if philosphersstone == 9
         saveas(gca,fullfile(fname,['fig000' num2str(philosphersstone)]),'jpeg');
     end
     if philosphersstone == 99
         saveas(gca,fullfile(fname,['fig00' num2str(philosphersstone)]),'jpeg');
     end
     if philosphersstone == 999
         saveas(gca,fullfile(fname,['fig0' num2str(philosphersstone)]),'jpeg');
     end
     
     
     
     philosphersstone = philosphersstone+1;

end
