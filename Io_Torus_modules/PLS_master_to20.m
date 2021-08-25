load('/Users/pahi9557/Documents/MATLAB/Workspaces/PLS_Master.mat')



%This module loads all of the data from the PLS_Master, and modifies it to
%suit our torus needs. It's like the list_size_4_10 code but specific for
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
o_Time = o_Time/3600; %Time back to Hours

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

o_VIP_cent_loc = struct();
o_VIP_cent_loc.r =VIP_cent_loc.r(600:770);
o_VIP_cent_loc.theta =VIP_cent_loc.theta(600:770);
o_VIP_cent_loc.phi =VIP_cent_loc.phi(600:770);

o_VIP_mag_loc = struct();
o_VIP_mag_loc.r =VIP_mag_loc.r(600:770);
o_VIP_mag_loc.theta =VIP_mag_loc.theta(600:770);
o_VIP_mag_loc.phi =VIP_mag_loc.phi(600:770);



%Set Time to one variable in seconds
Year = Year(81:599);
Day = Day(81:599);
Hour = Hour(81:599);
Minute = Minute(81:599);
Second = Second(81:599);
Hour = 3600*(Hour);
Minute = 60*(Minute);
Time = Hour+Minute+Second;
Time = Time/3600; %Time in Hours

Rad=Rad(81:599);
SIII_Phi=SIII_Phi(81:599);
Phi=SIII_Phi;


SIII_Rho=SIII_Rho(81:599);
SIII_Theta=SIII_Theta(81:599);
SIII_Z=SIII_Z(81:599);

rho_mag=rho_mag(81:599);
theta_mag=theta_mag(81:599);
z_mag=z_mag(81:599);

rho_ceq=rho_ceq(81:599);
theta_ceq=theta_ceq(81:599);
z_ceq=z_ceq(81:599);


HDensity = HDensity(81:599);
HotODensity= HotODensity(81:599);
NaDensity= NaDensity(81:599);
ODensity= ODensity(81:599);
ODensity1= ODensity1(81:599);
SDensity= SDensity(81:599);
SDensity1= SDensity1(81:599);
SDensity2= SDensity2(81:599);
m=zeros(size(HDensity,1),size(HDensity,2));
m=str2double(HDensity);
HDensity = m; clear m; rho = rho_ceq;


HotOTemperature = HotOTemperature(81:599);
HTemperature = HTemperature(81:599);
NaTemperature = NaTemperature(81:599);
OTemperature = OTemperature(81:599);
OTemperature1 = OTemperature1(81:599);
SO2Density= SO2Density(81:599);
SO2Temperature = SO2Temperature(81:599);
STemperature = STemperature(81:599);
STemperature1 = STemperature1(81:599);
STemperature2 = STemperature2(81:599);

Charge_Densitycc = Charge_Densitycc(81:599);


L_inbound = Lmagneticfieldline(Rad,theta_mag);

V_Phi = V_Phi(81:599);
V_R = V_R(81:599);
V_Z = V_Z(81:599);
Fractional_Corotation = Fractional_Corotation(81:599);

 alpha_inbound = asind(sind(9.6)*sind(Phi-68)); %the term required to switch theta across coordinate systems


VIP_cent_loc.r =VIP_cent_loc.r(81:599);
VIP_cent_loc.theta =VIP_cent_loc.theta(81:599);
VIP_cent_loc.phi =VIP_cent_loc.phi(81:599);


VIP_mag_loc.r =VIP_mag_loc.r(81:599);
VIP_mag_loc.theta =VIP_mag_loc.theta(81:599);
VIP_mag_loc.phi =VIP_mag_loc.phi(81:599);




%The next portion is eliminating duplicates that were passed down to me
%somehow




Rad(415) = [];
theta_mag(415) = [];
VIP_cent_loc.r(415) = [];
VIP_cent_loc.theta(415) = [];
VIP_cent_loc.phi(415) = [];
VIP_mag_loc.r(415) = [];
VIP_mag_loc.theta(415) = [];
VIP_mag_loc.phi(415) = [];

HDensity(415) = [];
HotODensity(415) = [];
NaDensity(415) = [];
ODensity(415) = [];
ODensity1(415) = [];
SDensity(415) = [];
SDensity1(415) = [];
SDensity2(415) = [];
HotOTemperature(415) = [];
HTemperature(415) = [];
NaTemperature(415) = [];
OTemperature(415) = [];
OTemperature1(415) = [];
SO2Density(415) = [];
SO2Temperature(415) = [];
STemperature(415) = [];
STemperature1(415) = [];
STemperature2(415) = [];
Charge_Densitycc(415) = [];
L_inbound(415) = [];
Fractional_Corotation(415) = [];
alpha_inbound(415) = [];
Time(415) = [];

Day(415) = [];
Hour(415) = [];
Minute(415) = [];
Second(415) = [];
Year(415) = [];
Phi(415) = [];
rho(415) = [];
rho_ceq(415) = [];
rho_mag(415) = [];
SIII_Phi(415) = [];
SIII_Rho(415) = [];
SIII_Theta(415) = [];
SIII_Z(415) = [];
theta_ceq(415) = [];
V_Phi(415) = [];
V_R(415) = [];
V_Z(415) = [];
z_ceq(415) = [];
z_mag(415) = [];


Rad(444) = [];
theta_mag(444) = [];
VIP_cent_loc.r(444) = [];
VIP_cent_loc.theta(444) = [];
VIP_cent_loc.phi(444) = [];
VIP_mag_loc.r(444) = [];
VIP_mag_loc.theta(444) = [];
VIP_mag_loc.phi(444) = [];


HDensity(444) = [];
HotODensity(444) = [];
NaDensity(444) = [];
ODensity(444) = [];
ODensity1(444) = [];
SDensity(444) = [];
SDensity1(444) = [];
SDensity2(444) = [];
HotOTemperature(444) = [];
HTemperature(444) = [];
NaTemperature(444) = [];
OTemperature(444) = [];
OTemperature1(444) = [];
SO2Density(444) = [];
SO2Temperature(444) = [];
STemperature(444) = [];
STemperature1(444) = [];
STemperature2(444) = [];
Charge_Densitycc(444) = [];
L_inbound(444) = [];
Fractional_Corotation(444) = [];
alpha_inbound(444) = [];
Time(444) = [];

Day(444) = [];
Hour(444) = [];
Minute(444) = [];
Second(444) = [];
Year(444) = [];
Phi(444) = [];
rho(444) = [];
rho_ceq(444) = [];
rho_mag(444) = [];
SIII_Phi(444) = [];
SIII_Rho(444) = [];
SIII_Theta(444) = [];
SIII_Z(444) = [];
theta_ceq(444) = [];
V_Phi(444) = [];
V_R(444) = [];
V_Z(444) = [];
z_ceq(444) = [];
z_mag(444) = [];




Rad(511) = [];
theta_mag(511) = [];
VIP_cent_loc.r(511) = [];
VIP_cent_loc.theta(511) = [];
VIP_cent_loc.phi(511) = [];
VIP_mag_loc.r(511) = [];
VIP_mag_loc.theta(511) = [];
VIP_mag_loc.phi(511) = [];


HDensity(511) = [];
HotODensity(511) = [];
NaDensity(511) = [];
ODensity(511) = [];
ODensity1(511) = [];
SDensity(511) = [];
SDensity1(511) = [];
SDensity2(511) = [];
HotOTemperature(511) = [];
HTemperature(511) = [];
NaTemperature(511) = [];
OTemperature(511) = [];
OTemperature1(511) = [];
SO2Density(511) = [];
SO2Temperature(511) = [];
STemperature(511) = [];
STemperature1(511) = [];
STemperature2(511) = [];
Charge_Densitycc(511) = [];
L_inbound(511) = [];
Fractional_Corotation(511) = [];
alpha_inbound(511) = [];
Time(511) = [];

Day(511) = [];
Hour(511) = [];
Minute(511) = [];
Second(511) = [];
Year(511) = [];
Phi(511) = [];
rho(511) = [];
rho_ceq(511) = [];
rho_mag(511) = [];
SIII_Phi(511) = [];
SIII_Rho(511) = [];
SIII_Theta(511) = [];
SIII_Z(511) = [];
theta_ceq(511) = [];
V_Phi(511) = [];
V_R(511) = [];
V_Z(511) = [];
z_ceq(511) = [];
z_mag(511) = [];


Rad(511) = [];
theta_mag(511) = [];
VIP_cent_loc.r(511) = [];
VIP_cent_loc.theta(511) = [];
VIP_cent_loc.phi(511) = [];
VIP_mag_loc.r(511) = [];
VIP_mag_loc.theta(511) = [];
VIP_mag_loc.phi(511) = [];


HDensity(511) = [];
HotODensity(511) = [];
NaDensity(511) = [];
ODensity(511) = [];
ODensity1(511) = [];
SDensity(511) = [];
SDensity1(511) = [];
SDensity2(511) = [];
HotOTemperature(511) = [];
HTemperature(511) = [];
NaTemperature(511) = [];
OTemperature(511) = [];
OTemperature1(511) = [];
SO2Density(511) = [];
SO2Temperature(511) = [];
STemperature(511) = [];
STemperature1(511) = [];
STemperature2(511) = [];
Charge_Densitycc(511) = [];
L_inbound(511) = [];
Fractional_Corotation(511) = [];
alpha_inbound(511) = [];
Time(511) = [];

Day(511) = [];
Hour(511) = [];
Minute(511) = [];
Second(511) = [];
Year(511) = [];
Phi(511) = [];
rho(511) = [];
rho_ceq(511) = [];
rho_mag(511) = [];
SIII_Phi(511) = [];
SIII_Rho(511) = [];
SIII_Theta(511) = [];
SIII_Z(511) = [];
theta_ceq(511) = [];
V_Phi(511) = [];
V_R(511) = [];
V_Z(511) = [];
z_ceq(511) = [];
z_mag(511) = [];


Rad(509) = [];
theta_mag(509) = [];
VIP_cent_loc.r(509) = [];
VIP_cent_loc.theta(509) = [];
VIP_cent_loc.phi(509) = [];
VIP_mag_loc.r(509) = [];
VIP_mag_loc.theta(509) = [];
VIP_mag_loc.phi(509) = [];


HDensity(509) = [];
HotODensity(509) = [];
NaDensity(509) = [];
ODensity(509) = [];
ODensity1(509) = [];
SDensity(509) = [];
SDensity1(509) = [];
SDensity2(509) = [];
HotOTemperature(509) = [];
HTemperature(509) = [];
NaTemperature(509) = [];
OTemperature(509) = [];
OTemperature1(509) = [];
SO2Density(509) = [];
SO2Temperature(509) = [];
STemperature(509) = [];
STemperature1(509) = [];
STemperature2(509) = [];
Charge_Densitycc(509) = [];
L_inbound(509) = [];
Fractional_Corotation(509) = [];
alpha_inbound(509) = [];
Time(509) = [];

Day(509) = [];
Hour(509) = [];
Minute(509) = [];
Second(509) = [];
Year(509) = [];
Phi(509) = [];
rho(509) = [];
rho_ceq(509) = [];
rho_mag(509) = [];
SIII_Phi(509) = [];
SIII_Rho(509) = [];
SIII_Theta(509) = [];
SIII_Z(509) = [];
theta_ceq(509) = [];
V_Phi(509) = [];
V_R(509) = [];
V_Z(509) = [];
z_ceq(509) = [];
z_mag(509) = [];