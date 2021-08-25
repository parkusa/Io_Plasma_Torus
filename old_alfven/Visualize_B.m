VIP_grid_maker% making the gird and loading the centrifugal locations generated 
%at each grid point using Parker's version of Kaleb's produce field line
%code.
load('/Users/pahi9557/Documents/MATLAB/Alfven_Waves/AW_data_prep/B_field_grid.mat')

x_sys3 = VIP_Grid.x_sys3;
y_sys3 = VIP_Grid.y_sys3;
z_sys3 = VIP_Grid.z_sys3;
x = x_sys3;
y = y_sys3;
z = z_sys3;
e_grid = B_field_grid.magnitude;
v = e_grid;

load('/Users/pahi9557/Documents/MATLAB/VIP4CAN/VIP_data_prep/low_res_field.mat')

figure(1)
 p1 = patch(isosurface(x,y,z,v,2000));
 set(p1,'FaceColor','red','EdgeColor','none','FaceAlpha',.5); % set the color,
%mesh and transparency level of the surface
hold on
% p2 = patch(isosurface(x,y,z,v,1500));
% set(p2,'FaceColor',1/255*[255 128 0],'EdgeColor','none','FaceAlpha',.3);
  p3 = patch(isosurface(x,y,z,v,500));
   set(p3,'FaceColor',1/255*[255 204 229],'EdgeColor','none','FaceAlpha',0.3);
% hold on


%p.FaceColor = 'red';
%p.EdgeColor = 'none';
daspect([1 1 1])

axis tight
lighting gouraud
xlim([-15 15])
ylim([-15 15])
zlim([-5 5])
set(gca,'color','black')
set(gcf,'color','black')
set(gcf, 'InvertHardCopy', 'off');
set(figure(1), 'Position', get(0, 'Screensize'));


%use this set for all black backgrounds etc, image mode

set(gca,'xcolor','k','ycolor','k','zcolor','k','xminorgrid','off','yminorgrid','off','zminorgrid','off')

%use this setting for grids etc, science mode

% set(gca,'xcolor','w','ycolor','w','zcolor','w','xminorgrid','on','yminorgrid','on','zminorgrid','on',...
% 'FontSize',16)

xlabel('System 3 x (R_{J})','fontweight','bold','fontsize',22) 
ylabel('System 3 y (R_{J})','fontweight','bold','fontsize',22)
zlabel('System 3 z (R_{J})','fontweight','bold','fontsize',22)
view(3);

theta_mag1= linspace(1,180,180);

figure(1)
[x,y,z] = sphere(100);

r=1;
xr = x*r;
yr = y*r;
zr = z*r;

xc = 0;
yc = 0;
zc = 0;

img = imread('jupitermap2.jp2'); % credit  James Hastings-Trew
img = flipud(img  );
hSurface = warp(xr+xc,yr+yc,zr+zc,img) ;
hold on

[x2,y2,z2] = sphere(100);

r2=.35;
xr2 = x2*r2;
yr2 = y2*r2;
zr2 = z2*r2;



xc2 = 6*sind(90).*cosd(158);
yc2 = 6*sind(90).*sind(158);
zc2 = 6*cosd(90);


img2 = imread('io_map.jpg'); %credit Steve Albers
img2 = flipud(img2  );
hSurface2 = warp(xr2+xc2,yr2+yc2,zr2+zc2,img2);


[x3,y3,z3] = sphere(100);

r3=.25;
xr3 = x3*r3;
yr3 = y3*r3;
zr3 = z3*r3;



xc3 = 9.6*sind(90).*cosd(158);
yc3 = 9.6*sind(90).*sind(158);
zc3 = 9.6*cosd(90);


img3 = imread('europa_map.jpg'); %credit US Geo-Survey
img3 = flipud(img3  );
hSurface3 = warp(xr3+xc3,yr3+yc3,zr3+zc3,img3);





%Use this code for Simple Dipole Filed lines, if VIP4, comment this out
% philosphersstone = 1;
% A = zeros(1,30);  
% for phi1 = 0:90:360
%     alpha1 = asind(sind(9.6)*sind(phi1-68));
%     theta_sys3 = theta_mag1+alpha1;
%     
%     for L_shell = 1:2:10
%         r=rmagneticfieldline(L_shell,theta_mag1);
%         
%         
%         x_fieldline_sys3 = r.*sind(theta_sys3).*cosd(phi1);
%         y_fieldline_sys3 = r.*sind(theta_sys3).*sind(phi1);
%         z_fieldline_sys3 = r.*cosd(theta_sys3);
%         
%         h = plot3(x_fieldline_sys3,y_fieldline_sys3,z_fieldline_sys3);
%         set(h,'Color',1/255*[0 255 255],'LineWidth', 1);
%         A(philosphersstone) = h;
%         philosphersstone = philosphersstone+1;
%         
%         
%         drawnow
%     end
% end
% philosphersstone = 1;


%Use this code for VIP4 field lines

Radius = VIP4CANphi(69).Radius;
Theta = VIP4CANphi(69).Theta;
Phi = VIP4CANphi(69).Phi;
x_sys3 = Radius.*sind(Theta).*cosd(Phi);
y_sys3 = Radius.*sind(Theta).*sind(Phi);
z_sys3 = Radius.*cosd(Theta);
h1 = plot3(x_sys3,y_sys3,z_sys3,'.','MarkerSize',0.0001);
set(h1,'Color',1/255*[0 102 0]);

Radius = VIP4CANphi(159).Radius;
Theta = VIP4CANphi(159).Theta;
Phi = VIP4CANphi(159).Phi;
x_sys3 = Radius.*sind(Theta).*cosd(Phi);
y_sys3 = Radius.*sind(Theta).*sind(Phi);
z_sys3 = Radius.*cosd(Theta);
h2 = plot3(x_sys3,y_sys3,z_sys3,'.','MarkerSize',0.0001);
set(h2,'Color',1/255*[0 102 0]);


Radius = VIP4CANphi(249).Radius;
Theta = VIP4CANphi(249).Theta;
Phi = VIP4CANphi(249).Phi;
x_sys3 = Radius.*sind(Theta).*cosd(Phi);
y_sys3 = Radius.*sind(Theta).*sind(Phi);
z_sys3 = Radius.*cosd(Theta);
h3 = plot3(x_sys3,y_sys3,z_sys3,'.','MarkerSize',0.0001);
set(h3,'Color',1/255*[0 102 0]);


Radius = VIP4CANphi(339).Radius;
Theta = VIP4CANphi(339).Theta;
Phi = VIP4CANphi(339).Phi;
x_sys3 = Radius.*sind(Theta).*cosd(Phi);
y_sys3 = Radius.*sind(Theta).*sind(Phi);
z_sys3 = Radius.*cosd(Theta);
h4 = plot3(x_sys3,y_sys3,z_sys3,'.','MarkerSize',0.0001);
set(h4,'Color',1/255*[0 102 0]);









direction = [0 0 -1];