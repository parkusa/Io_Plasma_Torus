%This module smooths the electron properties gleaned from Grace's
%data

load('/Users/pahi9557/Documents/MATLAB/Workspaces/electron_properties.mat')

M = movmedian(ColdTemperatureSS,2);
ColdTemperatureSS = M;

M = movmedian(HotColdDensitySS,2);
HotColdDensitySS = M;

M = movmedian(HotTemperatureSS,2);
HotTemperatureSS = M;
clear M;

M_e = interp1(Time,JRM09_mag_loc.r,Time_e);

%the first 28 values of this are simply 0, so they are non unique. This
%will cause problems later down the road. So here, I just delete them..

for i = 1:29
   
    M_e(1) = [];
    ColdTemperatureSS(1) = [];
    HotTemperatureSS(1) = [];
    HotColdDensitySS(1) = [];

end
clear i;

%This is a slight fudge that allows me to run n_max into M = 5, I don't
%think it's necessary for JRM09.
% M_e(120) = 5; 
% ColdTemperatureSS(120) = ColdTemperatureSS(119);
% HotColdDensitySS(120) = HotColdDensitySS(119);
% HotTemperatureSS(120) = HotTemperatureSS(119);

%This whole next section is a fudge that allows me to run n_max code out to
%M = 51

%Simply - currently out of the question for JRM09.

% 
% temp_M = linspace(14,51,37);
% M_e = M_e';
% M_e = [M_e temp_M];
% M_e = M_e';
% M_e = sort(M_e, 'descend');
% 
% temp_M = linspace(50,50,37);
% ColdTemperatureSS = ColdTemperatureSS';
% ColdTemperatureSS = [temp_M ColdTemperatureSS];
% ColdTemperatureSS = ColdTemperatureSS';
% 
% temp_M = linspace(600,600,37);
% HotTemperatureSS = HotTemperatureSS';
% HotTemperatureSS = [temp_M HotTemperatureSS];
% HotTemperatureSS = HotTemperatureSS';
% 
% temp_M = linspace(0.1,0.1,37);
% HotColdDensitySS = HotColdDensitySS';
% HotColdDensitySS = [temp_M HotColdDensitySS];
% HotColdDensitySS = HotColdDensitySS';
% 
% clear temp_M; 