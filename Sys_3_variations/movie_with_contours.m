
load('contour_1.mat')
figure()
subplot(1,2,1);
c = contourf(Rho_grid,Z_grid,S2_grid,cvals2,'k');
%clabel(c,'FontSize',17,'FontWeight','bold','Color','magenta')
%h = colorbar;
colormap('default')
temp1 = colormap;
temp1 = temp1(end:-1:1,:);
colormap(temp1);
h = colorbar;
caxis([0 50])
set(h,'color','w');
% ylabel(h, 'colorbar label here')
title(['n_{S+++}  \phi = ' num2str(phi1)],'fontweight','bold','color', 'w','fontsize',28)
xlabel('\rho_{cent}','fontweight','bold','fontsize',20) 
ylabel('z (R_{J})','fontweight','bold','fontsize',20)
set(gca,'FontSize',16)
set(gca,'yminorgrid','on')
set(gca,'xminorgrid','on')
set(gca,'color','black')
set(gca,'xcolor','w','ycolor','w','zcolor','w','xminorgrid','off','yminorgrid','off','zminorgrid','off')
set(gcf,'color','black')
daspect([1 1 1])

load('contour_2.mat')
subplot(1,2,2);
c = contourf(Rho_grid,Z_grid,S2_grid,cvals2,'k');
%clabel(c,'FontSize',17,'FontWeight','bold','Color','magenta')
%h = colorbar;
colormap('default')
temp1 = colormap;
temp1 = temp1(end:-1:1,:);
colormap(temp1);
h = colorbar;
caxis([0 50])
set(h,'color','w');
% ylabel(h, 'colorbar label here')
title(['n_{S+++}  \phi = ' num2str(phi1) ' w/ UVIS'],'fontweight','bold','color', 'w','fontsize',28)
xlabel('\rho_{cent}','fontweight','bold','fontsize',20) 
ylabel('z (R_{J})','fontweight','bold','fontsize',20)
set(gca,'FontSize',16)
set(gca,'yminorgrid','on')
set(gca,'xminorgrid','on')
set(gca,'color','black')
set(gca,'xcolor','w','ycolor','w','zcolor','w','xminorgrid','off','yminorgrid','off','zminorgrid','off')
set(gcf,'color','black')
daspect([1 1 1])