load('/Users/pahi9557/Documents/MATLAB/Workspaces/PLS_Master.mat')



%This module loads all of the data from the PLS_Master, and modifies it to
%suit our torus needs. It'ds like the list_size_4_10 code but specific for
%this purpose. This version elimates duplicates in the data set


%Set Time to one variable in seconds
o_Year = Year(600:770);
o_Day = Day(600:770);
o_Hour = Hour(600:770);
o_Minute = Minute(600:770);
o_Second = Second(600:770);
o_Hour = 3600*(o_Hour);
o_Minute = 60*(o_Minute);
o_Time = o_Hour+o_Minute+o_Second;
o_Time = o_Time/3600; %Time in Hours

o_Rad=Rad(600:770);
o_SIII_Phi=SIII_Phi(600:770);
o_Phi=o_SIII_Phi;


o_SIII_Rho=SIII_Rho(600:770);
o_SIII_Theta=SIII_Theta(600:770);
o_SIII_Z=SIII_Z(600:770);

o_rho_mag=rho_mag(600:770);
o_theta_mag=theta_mag(600:770);
o_z_mag=z_mag(600:770);

o_rho_ceq=rho_ceq(600:770);
o_theta_ceq=theta_ceq(600:770);
o_z_ceq=z_ceq(600:770);


o_HDensity = HDensity(600:770);
o_HotODensity= HotODensity(600:770);
o_NaDensity= NaDensity(600:770);
o_ODensity= ODensity(600:770);
o_ODensity1= ODensity1(600:770);
o_SDensity= SDensity(600:770);
o_SDensity1= SDensity1(600:770);
o_SDensity2= SDensity2(600:770);
m=zeros(size(o_HDensity,1),size(o_HDensity,2));
m=str2double(o_HDensity);
o_HDensity = m; clear m; 

o_HotOTemperature = HotOTemperature(600:770);
o_HTemperature = HTemperature(600:770);
o_NaTemperature = NaTemperature(600:770);
o_OTemperature = OTemperature(600:770);
o_OTemperature1 = OTemperature1(600:770);
o_SO2Density= SO2Density(600:770);
o_SO2Temperature = SO2Temperature(600:770);
o_STemperature = STemperature(600:770);
o_STemperature1 = STemperature1(600:770);
o_STemperature2 = STemperature2(600:770);


o_Charge_Densitycc = Charge_Densitycc(600:770);


L_outbound = Lmagneticfieldline(o_Rad,o_theta_mag);

o_V_Phi = V_Phi(600:770);
o_V_R = V_R(600:770);
o_V_Z = V_Z(600:770);
o_Fractional_Corotation = Fractional_Corotation(600:770);

alpha_outbound = asind(sind(9.6)*sind(o_Phi-68)); %the term required to switch theta across coordinate systems

% repeat the above but for the in bound variables
% all variable base names now represent inbound values





%Set Time to one variable in seconds
Year = Year(241:599);
Day = Day(241:599);
Hour = Hour(241:599);
Minute = Minute(241:599);
Second = Second(241:599);
Hour = 3600*(Hour);
Minute = 60*(Minute);
Time = Hour+Minute+Second;
Time = Time/3600; %Time in Hours

Rad=Rad(241:599);
SIII_Phi=SIII_Phi(241:599);
Phi=SIII_Phi;


SIII_Rho=SIII_Rho(241:599);
SIII_Theta=SIII_Theta(241:599);
SIII_Z=SIII_Z(241:599);

rho_mag=rho_mag(241:599);
theta_mag=theta_mag(241:599);
z_mag=z_mag(241:599);

rho_ceq=rho_ceq(241:599);
theta_ceq=theta_ceq(241:599);
z_ceq=z_ceq(241:599);


HDensity = HDensity(241:599);
HotODensity= HotODensity(241:599);
NaDensity= NaDensity(241:599);
ODensity= ODensity(241:599);
ODensity1= ODensity1(241:599);
SDensity= SDensity(241:599);
SDensity1= SDensity1(241:599);
SDensity2= SDensity2(241:599);
m=zeros(size(HDensity,1),size(HDensity,2));
m=str2double(HDensity);
HDensity = m; clear m; rho = rho_ceq;


HotOTemperature = HotOTemperature(241:599);
HTemperature = HTemperature(241:599);
NaTemperature = NaTemperature(241:599);
OTemperature = OTemperature(241:599);
OTemperature1 = OTemperature1(241:599);
SO2Density= SO2Density(241:599);
SO2Temperature = SO2Temperature(241:599);
STemperature = STemperature(241:599);
STemperature1 = STemperature1(241:599);
STemperature2 = STemperature2(241:599);

Charge_Densitycc = Charge_Densitycc(241:599);


L_inbound = Lmagneticfieldline(Rad,theta_mag);

V_Phi = V_Phi(241:599);
V_R = V_R(241:599);
V_Z = V_Z(241:599);
Fractional_Corotation = Fractional_Corotation(241:599);

 alpha_inbound = asind(sind(9.6)*sind(Phi-68)); %the term required to switch theta across coordinate systems



%The next portion is eliminating duplicates that were passed down to me
%somehow




Rad(255) = [];
theta_mag(255) = [];



HDensity(255) = [];
HotODensity(255) = [];
NaDensity(255) = [];
ODensity(255) = [];
ODensity1(255) = [];
SDensity(255) = [];
SDensity1(255) = [];
SDensity2(255) = [];
HotOTemperature(255) = [];
HTemperature(255) = [];
NaTemperature(255) = [];
OTemperature(255) = [];
OTemperature1(255) = [];
SO2Density(255) = [];
SO2Temperature(255) = [];
STemperature(255) = [];
STemperature1(255) = [];
STemperature2(255) = [];
Charge_Densitycc(255) = [];
L_inbound(255) = [];
Fractional_Corotation(255) = [];
alpha_inbound(255) = [];
Time(255) = [];




Rad(285) = [];
theta_mag(285) = [];



HDensity(285) = [];
HotODensity(285) = [];
NaDensity(285) = [];
ODensity(285) = [];
ODensity1(285) = [];
SDensity(285) = [];
SDensity1(285) = [];
SDensity2(285) = [];
HotOTemperature(285) = [];
HTemperature(285) = [];
NaTemperature(285) = [];
OTemperature(285) = [];
OTemperature1(285) = [];
SO2Density(285) = [];
SO2Temperature(285) = [];
STemperature(285) = [];
STemperature1(285) = [];
STemperature2(285) = [];
Charge_Densitycc(285) = [];
L_inbound(285) = [];
Fractional_Corotation(285) = [];
alpha_inbound(285) = [];
Time(285) = [];