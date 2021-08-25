
%All this code does is visualize the plots for me so that i know I
%generated them correctly. All I ultimately need to get out of this is the
%relative variation of the two species with respect to sys_3 longitude.
%Now, using the model as the background, I should be able to apply these
%relative variations and analyze the impact on the electron densities

%useful result of this code:

% -----------------------
% c = 1 ;  % constant offest
% lambda = linspace(1,360,360); %system 3 longitude
% lambda = lambda'; % change from column vector to row vector (transpose)
% A = 0.19; %Amplitude of variation
% phi = 150; %phase of the variation
% 
% S_variation = mixing_ratio(A,lambda,phi,c); %generating sinusoid
% 
% A = 0.28; %Amplitude of variation
% phi = 330; %phase of the variation
% 
% S2_variation = mixing_ratio(A,lambda,phi,c); %generating sinusoid
% 
% clear A; clear phi; clear c;
% -------------------------






lambda = linspace(1,360,360); %system 3 longitude
lambda = lambda'; % change from column vector to row vector (transpose)
c = 1; % constant offest


A = 0.19; %Amplitude of variation
phi = 210; %phase of the variation

S_variation = mixing_ratio(A,lambda,phi,c); %generating sinusoid

A = 0.28; %Amplitude of variation
phi = 30; %phase of the variation

S2_variation = mixing_ratio(A,lambda,phi,c); %generating sinusoid

figure()
subplot(2,1,1)
grid on
plot(lambda,S_variation, 'linewidth',3) %plotting sinusoid
hold on

plot(lambda,S2_variation, 'linewidth',3) %plotting sinusoid



%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title(['Number Density of O+ Along Field Line L = ' num2str(L)],'fontweight','bold','fontsize',18)
title('Relative Variation of S+ and S+++, West longitude','fontweight','bold','fontsize',18)
xlabel('\lambda_3','fontweight','bold','fontsize',18) % x-axis label
ylabel('Relative Variation','fontweight','bold','fontsize',18) % y-axis label
h_legend = legend('S+','S+++','Location','best');
set(h_legend,'FontSize',20);
% xlim([0 5])
 ylim([0.6 1.4])




A = 0.19; %Amplitude of variation
phi = 150; %phase of the variation

S_variation = mixing_ratio(A,lambda,phi,c); %generating sinusoid

A = 0.28; %Amplitude of variation
phi = 330; %phase of the variation

S2_variation = mixing_ratio(A,lambda,phi,c); %generating sinusoid

subplot(2,1,2)
grid on
plot(lambda,S_variation, 'linewidth',3) %plotting sinusoid
hold on

plot(lambda,S2_variation, 'linewidth',3) %plotting sinusoid





%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title(['Number Density of O+ Along Field Line L = ' num2str(L)],'fontweight','bold','fontsize',18)
title('Relative Variation of S+ and S+++, East Longitude','fontweight','bold','fontsize',18)
xlabel('\lambda_3','fontweight','bold','fontsize',18) % x-axis label
ylabel('Relative Variation','fontweight','bold','fontsize',18) % y-axis label
h_legend = legend('S+','S+++','Location','best');
set(h_legend,'FontSize',20);
% xlim([0 5])
 ylim([0.6 1.4])