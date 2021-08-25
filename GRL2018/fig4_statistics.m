load('/Users/pahi9557/Documents/MATLAB/HDAlfven_JRM09/HD_wf_Modules/HD_visuals/HD_histogram_data.mat')


%I double counted because 0 = 360, I don't want to sway the statistics by
%double counting
B_n{1}(1) = [];
B_n{2}(1) = [];
B_n{3}(1) = [];
B_n{4}(1) = [];
B_n{5}(1) = [];
B_n{6}(1) = [];
B_n{7}(1) = [];
B_n{8}(1) = [];
B_n{9}(1) = [];
B_n{10}(1) = [];
B_n{11}(1) = [];
B_n{12}(1) = [];
B_n{13}(1) = [];
B_n{14}(1) = [];
B_n{15}(1) = [];
B_n{16}(1) = [];
B_n{17}(1) = [];
B_n{18}(1) = [];
B_s{1}(1) = [];
B_s{2}(1) = [];
B_s{3}(1) = [];
B_s{4}(1) = [];
B_s{5}(1) = [];
B_s{6}(1) = [];
B_s{7}(1) = [];
B_s{8}(1) = [];
B_s{9}(1) = [];
B_s{10}(1) = [];
B_s{11}(1) = [];
B_s{12}(1) = [];
B_s{13}(1) = [];
B_s{14}(1) = [];
B_s{15}(1) = [];
B_s{16}(1) = [];
B_s{17}(1) = [];
B_s{18}(1) = [];

figure()
subplot(2,1,1)
c = {'','330','290','250','210','170','130','90','50','10',};
y = [mean(B_n{1}) mean(B_n{2})  mean(B_n{3})  mean(B_n{4})  mean(B_n{5})  mean(B_n{6})  mean(B_n{7})  mean(B_n{8})  mean(B_n{9})  mean(B_n{10})  mean(B_n{11})  mean(B_n{12})  mean(B_n{13})  mean(B_n{14})  mean(B_n{15})  mean(B_n{16})  mean(B_n{17})   mean(B_n{18})];
S = [std(B_n{1}) std(B_n{2})  std(B_n{3})  std(B_n{4})  std(B_n{5})  std(B_n{6})  std(B_n{7})  std(B_n{8})  std(B_n{9})  std(B_n{10})  std(B_n{11})  std(B_n{12})  std(B_n{13})  std(B_n{14})  std(B_n{15})  std(B_n{16})  std(B_n{17})   std(B_n{18})];
bar(y,1,'EdgeColor',[0 .9 .9])
hold on

for counter = 1:length(y)
e = errorbar(counter,y(counter),S(counter),'CapSize',24)
e.Color = 'red';
end
clear counter;

set(gca,'xticklabel',c);
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title(['Number Density of O+ Along Field Line L = ' num2str(L)],'fontweight','bold','fontsize',18)
title('Spot Statistics (North)','fontweight','bold','fontsize',18)
xlabel('West Jovigraphic Longitude','fontsize',18) % x-axis label
ylabel('mean # of Spots','fontsize',18) % y-axis label
ylim([0 10])




subplot(2,1,2)
S = [std(B_s{1}) std(B_s{2})  std(B_s{3})  std(B_s{4})  std(B_s{5})  std(B_s{6})  std(B_s{7})  std(B_s{8})  std(B_s{9})  std(B_s{10})  std(B_s{11})  std(B_s{12})  std(B_s{13})  std(B_s{14})  std(B_s{15})  std(B_s{16})  std(B_s{17})   std(B_s{18})];
y = [mean(B_s{1}) mean(B_s{2})  mean(B_s{3})  mean(B_s{4})  mean(B_s{5})  mean(B_s{6})  mean(B_s{7})  mean(B_s{8})  mean(B_s{9})  mean(B_s{10})  mean(B_s{11})  mean(B_s{12})  mean(B_s{13})  mean(B_s{14})  mean(B_s{15})  mean(B_s{16})  mean(B_s{17})   mean(B_s{18})];
bar(y,1,'EdgeColor',[0 .9 .9])
hold on

for counter = 1:length(y)
e = errorbar(counter,y(counter),S(counter),'CapSize',24)
e.Color = 'red';
end
clear counter;

set(gca,'xticklabel',c);
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title(['Number Density of O+ Along Field Line L = ' num2str(L)],'fontweight','bold','fontsize',18)
title('Spot Statistics (South)','fontweight','bold','fontsize',18)
xlabel('West Jovigraphic Longitude','fontsize',18) % x-axis label
ylabel('mean # of Spots','fontsize',18) % y-axis label
ylim([0 10])