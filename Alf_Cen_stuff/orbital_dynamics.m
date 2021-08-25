%_____________________________________________________________________

%the real elements of an orbit are...

% P : the revolution period in years; alternativley the mean motion
% T : the time passage through periastron
% e : the numerical eccentricity of the orbit, the auxilary angle phi is arcsin(e)
% a : the semi-major axis in arseconds

%The apparent orbit results from a projection of the true orbit onto the
%celestial sphere, three more elements arise in this projection

% Omega (uppercase) : the position angle of the ascending node

% i : the orbital inclination, this is the angle between the plane of
% projection and the true orbital plane

% omega (lowercase) : the arguement of periastron. This is the angle
% between the node and the periastron.

%These 7 elements are called the Campbell elements.
%Thiele_Innes elements use Campbell's to to calculate rectangular
%coordinates:

% A = a(cos(omega)cos(Omega) - sin(omega)sin(Omega)cos(i)
% B = a(cos(omega)sin(Omega) + sin(omega)cos(Omega)cos(i)

% F = a(-sin(omega)cos(Omega) - cos(omega)sin(Omega)cos(i)
% G = a(-sin(omega)sin(Omega) + cos(omega)cos(Omega)cos(i)

%_____________________________________________________________________


% mkdir temporary
% fname = 'temporary';


P = 79.91;
T = 1955.66;
e = 0.524;
a = 17.66;
Omega = 204.75;
i = 79.32;
omega = 232.3;


A = a*(cosd(omega)*cosd(Omega) - sind(omega)*sind(Omega)*cosd(i));
B = a*(cosd(omega)*sind(Omega) + sind(omega)*cosd(Omega)*cosd(i));

F = a*(-sind(omega)*cosd(Omega) - cosd(omega)*sind(Omega)*cosd(i));
G = a*(-sind(omega)*sind(Omega) + cosd(omega)*cosd(Omega)*cosd(i));


mu = 2*pi/P; % https://en.wikipedia.org/wiki/Mean_motion
% %_________________
% %alternative mu
% parallax = 742;
% distance = parallax/1000; %in parsecs
% distance = distance*(3.086*10^16); % parsecs to meters
% semi_major = distance*(sin(8.5618*10^(-5))); %meters
% Masses = 4.186*10^30 ; % sum of the stellar masses in kg
% NewtonsG = 6.674*10^(-11); %meters cubed per (kilogram*second^2)
% mu = (NewtonsG*Masses/semi_major^3)^(0.5);
% %_________________

figure()
mov(166) = struct('cdata',[],'colormap',[]);
z=1;
for t = 1956:0.5:2036
%t = 2019.5; % year of interest
M = mu*(t-T);
M_i = M;
E_i = M + e*sin(M) + e^2/M*sin(2*M);

E_list = [];
M_list = [];
iteration_list = [];

subplot(1,2,1)
grid on
plot(1,E_i,'k:','linewidth',2);
hold on

for iteration = 1:10
M_j = E_i - e*sin(E_i);
E_j = E_i + (M - M_j)/(1 - e*cos(E_i));

E_i = E_j;
E_list = [E_list E_j];
M_list = [M_list M_j];
iteration_list = [iteration_list iteration];

plot(iteration+1,E_i,'k.','linewidth',2);
drawnow

end




%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
%title(['Number Density of O+ Along Field Line L = ' num2str(L)],'fontweight','bold','fontsize',18)
title('Mean Anomaly','fontweight','bold','fontsize',18)
%xlabel('Time (hours)','fontweight','bold','fontsize',18) % x-axis label
%ylabel('Number density (#/cm^3)','fontweight','bold','fontsize',18) % y-axis label
%h_legend = legend('Ne','O+', 'O++', 'O+Hot', 'Location','best');
%set(h_legend,'FontSize',20);
% xlim([0 5])
% ylim([0 5])



X = cos(E_i) - e; Y = (1 - e^2)^(0.5)*sin(E_i);
x = A*X + F*Y; y = B*X + G*Y;




subplot(1,2,2)

grid on
plot(x,y,'k.','Markersize',5);
hold on


%yt=[ 10:20:100 200:200:1000 2000 3000];
%set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=[0:1:6];
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
title(['Alf Cen B, year = ' num2str(t)],'fontweight','bold','fontsize',18)
xlabel('x','fontweight','bold','fontsize',18) % x-axis label
ylabel('y','fontweight','bold','fontsize',18) % y-axis label
%h_legend = legend('Ne','O+', 'O++', 'O+Hot', 'Location','best');
%set(h_legend,'FontSize',20);
% xlim([0 5])
% ylim([0 5])



drawnow
mov(z) = getframe;

% 
%  if z < 9
%         saveas(gca,fullfile(fname,['fig000' num2str(z)]),'jpeg');
%     end
%     
%     if z < 99
%         if z > 9
%             saveas(gca,fullfile(fname,['fig00' num2str(z)]),'jpeg');
%         end
%     end
%     
%     if z < 999
%         if z > 99
%             saveas(gca,fullfile(fname,['fig0' num2str(z)]),'jpeg');
%         end
%     end
%     if z == 9
%         saveas(gca,fullfile(fname,['fig000' num2str(z)]),'jpeg');
%     end
%     if z == 99
%         saveas(gca,fullfile(fname,['fig00' num2str(z)]),'jpeg');
%     end
% 


z=z+1;
end











