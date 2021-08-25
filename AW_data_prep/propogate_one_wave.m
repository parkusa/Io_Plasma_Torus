%propogates one alfven North&South wave all the way around the circle for a
%given longitude

longitude = 68; %pick the sys 3 longitude which Io twangs. The stationary observer
%considers the initial point of Io, this longitude, to be the zero point in
%their own FIXED reference frame

if characteristic.North_distance(longitude) < characteristic.South_distance   
    d1 = characteristic.North_distance(longitude);
    d2 = characteristic.South_distance(longitude);
else
    d2 = characteristic.North_distance(longitude);
    d1 = characteristic.South_distance(longitude);
end
d3 = d1+d2;

Alfven_Model = struct();
Alfven_Model.Equatorial_Crossings = 0;

for step = 1:100000000000
c = step*d3 - d3;
new_crossings = [(c+d1) (c+d2) (c+d3)];

if new_crossings(3) > 360
new_crossings(3) = [];
end
if new_crossings(2) > 360
new_crossings(2) = [];
end
if new_crossings(1) > 360
        break
    end
Alfven_Model.Equatorial_Crossings = [Alfven_Model.Equatorial_Crossings new_crossings];
end

Alfven_Model.r = linspace(6,6,length(Alfven_Model.Equatorial_Crossings));
Alfven_Model.theta = linspace(90,90,length(Alfven_Model.Equatorial_Crossings));

Alfven_Model.x = Alfven_Model.r.*sind(Alfven_Model.theta).*cosd(Alfven_Model.Equatorial_Crossings);
Alfven_Model.y = Alfven_Model.r.*sind(Alfven_Model.theta).*sind(Alfven_Model.Equatorial_Crossings);
Alfven_Model.z = Alfven_Model.r.*cosd(Alfven_Model.theta);

figure()
scatter3(Alfven_Model.x,Alfven_Model.y,Alfven_Model.z,1000,'b.')
hold on

%plotting jup
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

%plotting Io
[x2,y2,z2] = sphere(100);
r2=.35;
xr2 = x2*r2;
yr2 = y2*r2;
zr2 = z2*r2;
xc2 = 6*sind(90).*cosd(longitude);
yc2 = 6*sind(90).*sind(longitude);
zc2 = 6*cosd(90);
img2 = imread('io_map.jpg'); %credit Steve Albers
img2 = flipud(img2  );
hSurface2 = warp(xr2+xc2,yr2+yc2,zr2+zc2,img2);


%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
title(['Io at \phi_{sys3} = ' num2str(longitude)],'fontweight','bold','fontsize',18)
%title('\theta (normal latitude) vs Time','fontweight','bold','fontsize',18)
% xlabel('Time (hours)','fontweight','bold','fontsize',18) % x-axis label
% ylabel('Number density (#/cm^3)','fontweight','bold','fontsize',18) % y-axis label
%h_legend = legend('Ne','O+', 'O++', 'O+Hot', 'Location','best');
%set(h_legend,'FontSize',20);
% xlim([0 5])
% ylim([0 5])
daspect([1 1 1])
view(-37.5,10);     