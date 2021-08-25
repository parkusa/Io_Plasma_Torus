

Phi = 1:0.1:360;
Phi = Phi';
R = linspace(6,6,length(Phi));
R = R';
%Theta = 90 + asind(sind(9.6)*sind(Phi-68));
Theta = Phi;
Theta(:) = 90;

Ran1 = zeros(size(R(:)))+1;
Ran2 = zeros(size(R(:)))+1;
Ran3 = zeros(size(R(:)))+1;
Ran4 = zeros(size(R(:)))+1;
Ran5 = zeros(size(R(:)))+1;
%csvwrite('grid_locations.csv',[Ran1 Ran2 Ran3 Ran4 Ran5 R Theta Phi])

load('/Users/pahi9557/Documents/MATLAB/Alfven_Waves/AW_data_prep/unsorted_lines.mat')
Ran1 = zeros(size(unsort_flag1))+1;
Ran2 = zeros(size(unsort_flag1))+1;
Ran3 = zeros(size(unsort_flag1))+1;
Ran4 = zeros(size(unsort_flag1))+1;
Ran5 = zeros(size(unsort_flag1))+1;
%csvwrite('grid_locations.csv',[Ran1 Ran2 Ran3 Ran4 Ran5 unsort_Radius unsort_Theta unsort_Phi])