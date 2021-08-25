% A potential search tool: 
%https://irsa.ipac.caltech.edu/frontpage/
%All of my data comes form the Chandra catalogue, observations by Thomas
%Ayres








% mkdir temporary
% fname = 'temporary';







Alf_Cen_B = struct();
Alf_Cen_A = struct();

%Painfully hardcoding now, will learn how to use fitz files soon!
%Just opening in DS9 right now and manually recording Date, RA & Dec :/
Alf_Cen_B.Year = 2005.8;
Alf_Cen_B.RA = (14 + 39/60 + 32.3247/3600)*15;
Alf_Cen_B.DEC = -(60 + 50/60 + 06.447/3600);
Alf_Cen_A.RA = (14 + 39/60 + 33.3866/3600)*15;
Alf_Cen_A.DEC = -(60 + 50/60 + 0.277/3600);


Alf_Cen_B.Year = [Alf_Cen_B.Year 2006.36];
Alf_Cen_B.RA = [Alf_Cen_B.RA (14 + 39/60 + 32.1624/3600)*15];
Alf_Cen_B.DEC = [Alf_Cen_B.DEC -(60 + 50/60 + 06.709/3600)];
Alf_Cen_A.RA = [Alf_Cen_A.RA (14 + 39/60 + 33.1856/3600)*15];
Alf_Cen_A.DEC = [Alf_Cen_A.DEC -(60 + 50/60 + 00.916/3600)];

Alf_Cen_B.Year = [Alf_Cen_B.Year 2006.95];
Alf_Cen_B.RA = [Alf_Cen_B.RA (14 + 39/60 + 31.8932/3600)*15];
Alf_Cen_B.DEC = [Alf_Cen_B.DEC -(60 + 50/60 + 05.272/3600)];
Alf_Cen_A.RA = [Alf_Cen_A.RA (14 + 39/60 + 32.8836/3600)*15];
Alf_Cen_A.DEC = [Alf_Cen_A.DEC -(60 + 50/60 + 00.063/3600)];

Alf_Cen_B.Year = [Alf_Cen_B.Year 2007.42];
Alf_Cen_B.RA = [Alf_Cen_B.RA (14 + 39/60 + 31.5171/3600)*15];
Alf_Cen_B.DEC = [Alf_Cen_B.DEC -(60 + 50/60 + 04.970/3600)];
Alf_Cen_A.RA = [Alf_Cen_A.RA (14 + 39/60 + 32.4938/3600)*15];
Alf_Cen_A.DEC = [Alf_Cen_A.DEC -(60 + 50/60 + 0.028/3600)];

Alf_Cen_B.Year = [Alf_Cen_B.Year 2008.39];
Alf_Cen_B.RA = [Alf_Cen_B.RA (14 + 39/60 + 31.1856/3600)*15];
Alf_Cen_B.DEC = [Alf_Cen_B.DEC -(60 + 50/60 + 04.285/3600)];
Alf_Cen_A.RA = [Alf_Cen_A.RA (14 + 39/60 + 32.1165/3600)*15];
Alf_Cen_A.DEC = [Alf_Cen_A.DEC -(60 + 50/60 + 0.093/3600)];

Alf_Cen_B.Year = [Alf_Cen_B.Year 2008.95];
Alf_Cen_B.RA = [Alf_Cen_B.RA (14 + 39/60 + 30.948/3600)*15];
Alf_Cen_B.DEC = [Alf_Cen_B.DEC -(60 + 50/60 + 03.106/3600)];
Alf_Cen_A.RA = [Alf_Cen_A.RA (14 + 39/60 + 31.8290/3600)*15];
Alf_Cen_A.DEC = [Alf_Cen_A.DEC -(60 + 49/60 + 59.452/3600)];

Alf_Cen_B.Year = [Alf_Cen_B.Year 2009.41];
Alf_Cen_B.RA = [Alf_Cen_B.RA (14 + 39/60 + 30.6972/3600)*15];
Alf_Cen_B.DEC = [Alf_Cen_B.DEC -(60 + 50/60 + 02.950/3600)];
Alf_Cen_A.RA = [Alf_Cen_A.RA (14 + 39/60 + 31.5708/3600)*15];
Alf_Cen_A.DEC = [Alf_Cen_A.DEC -(60 + 49/60 + 59.619/3600)];

Alf_Cen_B.Year = [Alf_Cen_B.Year 2009.94];
Alf_Cen_B.RA = [Alf_Cen_B.RA (14 + 39/60 + 30.4766/3600)*15];
Alf_Cen_B.DEC = [Alf_Cen_B.DEC -(60 + 50/60 + 01.917/3600)];
Alf_Cen_A.RA = [Alf_Cen_A.RA (14 + 39/60 + 31.3093/3600)*15];
Alf_Cen_A.DEC = [Alf_Cen_A.DEC -(60 + 49/60 + 59.019/3600)];

Alf_Cen_B.Year = [Alf_Cen_B.Year 2010.33];
Alf_Cen_B.RA = [Alf_Cen_B.RA (14 + 39/60 + 30.2569/3600)*15];
Alf_Cen_B.DEC = [Alf_Cen_B.DEC -(60 + 50/60 + 01.983/3600)];
Alf_Cen_A.RA = [Alf_Cen_A.RA (14 + 39/60 + 31.0755/3600)*15];
Alf_Cen_A.DEC = [Alf_Cen_A.DEC -(60 + 49/60 + 59.427/3600)];

Alf_Cen_B.Year = [Alf_Cen_B.Year 2010.8];
Alf_Cen_B.RA = [Alf_Cen_B.RA (14 + 39/60 + 30.0044/3600)*15];
Alf_Cen_B.DEC = [Alf_Cen_B.DEC -(60 + 50/60 + 0.986/3600)];
Alf_Cen_A.RA = [Alf_Cen_A.RA (14 + 39/60 + 30.7930/3600)*15];
Alf_Cen_A.DEC = [Alf_Cen_A.DEC -(60 + 49/60 + 58.828/3600)];

Alf_Cen_B.Year = [Alf_Cen_B.Year 2011.43];
Alf_Cen_B.RA = [Alf_Cen_B.RA (14 + 39/60 + 29.6324/3600)*15];
Alf_Cen_B.DEC = [Alf_Cen_B.DEC -(60 + 50/60 + 0.544/3600)];
Alf_Cen_A.RA = [Alf_Cen_A.RA (14 + 39/60 + 30.3872/3600)*15];
Alf_Cen_A.DEC = [Alf_Cen_A.DEC -(60 + 49/60 + 58.780/3600)];

Alf_Cen_B.Year = [Alf_Cen_B.Year 2011.98];
Alf_Cen_B.RA = [Alf_Cen_B.RA (14 + 39/60 + 29.5721/3600)*15];
Alf_Cen_B.DEC = [Alf_Cen_B.DEC -(60 + 50/60 + 0.011/3600)];
Alf_Cen_A.RA = [Alf_Cen_A.RA (14 + 39/60 + 30.2929/3600)*15];
Alf_Cen_A.DEC = [Alf_Cen_A.DEC -(60 + 49/60 + 58.814/3600)];

Alf_Cen_B.Year = [Alf_Cen_B.Year 2018.38];
Alf_Cen_B.RA = [Alf_Cen_B.RA (14 + 39/60 + 26.5623/3600)*15];
Alf_Cen_B.DEC = [Alf_Cen_B.DEC -(60 + 49/60 + 52.723/3600)];
Alf_Cen_A.RA = [Alf_Cen_A.RA (14 + 39/60 + 26.8558/3600)*15];
Alf_Cen_A.DEC = [Alf_Cen_A.DEC -(60 + 49/60 + 56.838/3600)];


Alf_Cen_A.Year = Alf_Cen_B.Year;

Alf_Cen_B.propagated.RA = Alf_Cen_B.RA(1);
Alf_Cen_B.propagated.DEC = Alf_Cen_B.DEC(1);

Alf_Cen_A.propagated.RA = Alf_Cen_A.RA(1);
Alf_Cen_A.propagated.DEC = Alf_Cen_A.DEC(1);

Alf_Cen_B.delta_Year = diff(Alf_Cen_B.Year);
Alf_Cen_B.delta_RA = diff(Alf_Cen_B.RA);
Alf_Cen_B.delta_DEC = diff(Alf_Cen_B.DEC);

Alf_Cen_A.delta_Year = diff(Alf_Cen_A.Year);
Alf_Cen_A.delta_RA = diff(Alf_Cen_A.RA);
Alf_Cen_A.delta_DEC = diff(Alf_Cen_A.DEC);

Alf_Cen_B.proper_motion_RA = mean(Alf_Cen_B.delta_RA./Alf_Cen_B.delta_Year);
Alf_Cen_B.proper_motion_DEC = mean(Alf_Cen_B.delta_DEC./Alf_Cen_B.delta_Year);

Alf_Cen_A.proper_motion_RA = mean(Alf_Cen_A.delta_RA./Alf_Cen_A.delta_Year);
Alf_Cen_A.proper_motion_DEC = mean(Alf_Cen_A.delta_DEC./Alf_Cen_A.delta_Year);

figure(1)
for year = 1:32
timestamp = 2006 + .5*year - .5;
grid on
plot(Alf_Cen_A.RA,Alf_Cen_A.DEC,'bo','Markersize',20);
hold on
plot(Alf_Cen_B.RA,Alf_Cen_B.DEC,'ro','Markersize',20);

plot(Alf_Cen_B.propagated.RA,Alf_Cen_B.propagated.DEC,'k.','Markersize',10)

%uses orbital dynamics to calculate the position of B from A
orbital_dynamics_module
plot(orb_dy_B_RA,orb_dy_B_DEC,'m.','Markersize',10)

plot(Alf_Cen_A.propagated.RA,Alf_Cen_A.propagated.DEC,'k.','Markersize',10)





text(219.897,-60.8305,'Alf Cen B Prediction:','fontsize',15);
text(219.897,-60.8315,'Alf Cen A Prediction:','fontsize',15);
 


    
h1 = text(219.88,-60.8305,['(' num2str(Alf_Cen_B.propagated.RA) ',' num2str(Alf_Cen_B.propagated.DEC) ')'],'fontsize',15);
h2 =text(219.88,-60.8315,['(' num2str(Alf_Cen_A.propagated.RA) ',' num2str(Alf_Cen_A.propagated.DEC) ')'],'fontsize',15);


%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
ax = gca;
ax.XDir = 'reverse';
title(['Alf Cen A & B, year: ' num2str(timestamp)],'fontweight','bold','fontsize',18)
%title('Alf Cen A & B','fontweight','bold','fontsize',18)
xlabel('RA (deg)','fontweight','bold','fontsize',18) % x-axis label
ylabel('Dec (deg)','fontweight','bold','fontsize',18) % y-axis label
h_legend = legend('Chandra Alf Cen A','Chandra Alf Cen B','Proper Motion Prediction','Ellipse Prediction','Location','SouthEast','AutoUpdate','off');
set(h_legend,'FontSize',16);
%daspect([1 1 1])
 xlim([219.85 219.90])
 ylim([-60.836 -60.83])
pause(.5)



Alf_Cen_B.propagated.RA = Alf_Cen_B.propagated.RA + .5*Alf_Cen_B.proper_motion_RA;
Alf_Cen_B.propagated.DEC = Alf_Cen_B.propagated.DEC + .5*Alf_Cen_B.proper_motion_DEC;

Alf_Cen_A.propagated.RA = Alf_Cen_A.propagated.RA + .5*Alf_Cen_A.proper_motion_RA;
Alf_Cen_A.propagated.DEC = Alf_Cen_A.propagated.DEC + .5*Alf_Cen_A.proper_motion_DEC;


%         x = year;
%     if x < 9
%         saveas(gca,fullfile(fname,['fig000' num2str(x)]),'jpeg');
%     end
%     
%     if x < 99
%         if x > 9
%             saveas(gca,fullfile(fname,['fig00' num2str(x)]),'jpeg');
%         end
%     end
%     
%     if x < 999
%         if x > 99
%             saveas(gca,fullfile(fname,['fig0' num2str(x)]),'jpeg');
%         end
%     end
%     if x == 9
%         saveas(gca,fullfile(fname,['fig000' num2str(x)]),'jpeg');
%     end
%     if x == 99
%         saveas(gca,fullfile(fname,['fig00' num2str(x)]),'jpeg');
%     end

if timestamp ~= 2021.5
    delete(h1);
    delete(h2);
end


end