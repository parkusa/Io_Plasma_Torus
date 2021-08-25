% I used the following search tool: 

%https://irsa.ipac.caltech.edu/frontpage/

%I searched Alf Cen A and used manually what I needed from:

%2MASSS All-Sky Point Source Catalogue (PSC)
%Gaia Catalogue (DR2)

Alf_Cen_A = struct()

Alf_Cen_A.y2000.RA = (14 + 39/60 + 36.3/3600)*15;
Alf_Cen_A.y2000.DEC = -(60 + 50/60 + 3.9/3600);

Alf_Cen_A.y2015.RA = (14 + 39/60 + 36.45/3600)*15;
Alf_Cen_A.y2015.DEC = -(60 + 50/60 + 3.7/3600);



Alf_Cen_B.y2000.RA = (14 + 39/60 + 35.07/3600)*15;
Alf_Cen_B.y2000.DEC = -(60 + 50/60 + 14/3600);

Alf_Cen_B.y2015.RA = (14 + 39/60 + 35.13/3600)*15;
Alf_Cen_B.y2015.DEC = -(60 + 50/60 + 13.3/3600);


Alf_Cen_A.propogated.RA = Alf_Cen_A.y2000.RA;
Alf_Cen_A.propogated.DEC = Alf_Cen_A.y2000.DEC;
Alf_Cen_B.propogated.RA = Alf_Cen_B.y2000.RA;
Alf_Cen_B.propogated.DEC = Alf_Cen_B.y2000.DEC;


figure(1)
for year = 1:19
year

grid on
plot(Alf_Cen_A.y2000.RA,Alf_Cen_A.y2000.DEC,'bo','Markersize',30);
hold on
plot(Alf_Cen_A.y2015.RA,Alf_Cen_A.y2015.DEC,'ro','Markersize',30);
plot(Alf_Cen_B.y2000.RA,Alf_Cen_B.y2000.DEC,'bo','Markersize',30);
plot(Alf_Cen_B.y2015.RA,Alf_Cen_B.y2015.DEC,'ro','Markersize',30);


plot(Alf_Cen_A.propogated.RA,Alf_Cen_A.propogated.DEC,'k.')
plot(Alf_Cen_B.propogated.RA,Alf_Cen_B.propogated.DEC,'k.')

%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
title(['Alf Cen A & B, year: ' num2str(1999 + year)],'fontweight','bold','fontsize',18)
%title('Alf Cen A & B','fontweight','bold','fontsize',18)
xlabel('RA (deg)','fontweight','bold','fontsize',18) % x-axis label
ylabel('Dec (deg)','fontweight','bold','fontsize',18) % y-axis label
h_legend = legend('2MASS 2000','Gaia DR2 2015','Location','best');
%set(h_legend,'FontSize',20);
% xlim([0 5])
% ylim([0 5])


Alf_Cen_A.propogated.RA = Alf_Cen_A.propogated.RA - 0.00102201*year;
Alf_Cen_A.propogated.DEC = Alf_Cen_A.propogated.DEC + 0.00013157*year;

Alf_Cen_B.propogated.RA = Alf_Cen_B.propogated.RA - 0.001004*year;
Alf_Cen_B.propogated.DEC = Alf_Cen_B.propogated.DEC + 0.00022305*year;


pause(1)
end

