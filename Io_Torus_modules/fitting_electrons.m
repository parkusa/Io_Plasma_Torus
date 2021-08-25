%This module simply smooths the electron properties gleaned from Grace's
%data

load('/Users/pahi9557/Documents/MATLAB/Workspaces/electron_properties.mat')

M = movmedian(ColdTemperatureSS,2);
ColdTemperatureSS = M;

M = movmedian(HotColdDensitySS,2);
HotColdDensitySS = M;

M = movmedian(HotTemperatureSS,2);
HotTemperatureSS = M;
clear M;
%This section adds to the electron properties information from logan &
%fran's power laws, adding to the lists L = 13-20 (roughly). The power laws
%denote a constant value for the electron properties in this region


temp_L = linspace(13.05,21,50);
L_e = L_e';
L_e = [L_e temp_L];
L_e = L_e';
L_e = sort(L_e, 'descend');



temp_L = linspace(50,50,50);
ColdTemperatureSS = ColdTemperatureSS';
ColdTemperatureSS = [temp_L ColdTemperatureSS];
ColdTemperatureSS = ColdTemperatureSS';


temp_L = linspace(600,600,50);
HotTemperatureSS = HotTemperatureSS';
HotTemperatureSS = [temp_L HotTemperatureSS];
HotTemperatureSS = HotTemperatureSS';

temp_L = linspace(0.1,0.1,50);
HotColdDensitySS = HotColdDensitySS';
HotColdDensitySS = [temp_L HotColdDensitySS];
HotColdDensitySS = HotColdDensitySS';

clear temp_L; 

