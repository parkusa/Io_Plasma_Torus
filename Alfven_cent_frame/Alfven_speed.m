
%This module computes the alfven speed at each point


%This bit converts the B field to nano teslas
a = 10^(-9);
sorted_lines_1_360.B_Mag = sorted_lines_1_360.B_Mag*a;
clear a;
permeability_of_free_space = 4*pi*10^(-7);


mass_density = 16*(sorted_lines_1_360.O_grid+sorted_lines_1_360.O1_grid+sorted_lines_1_360.HotO_grid)+32*(sorted_lines_1_360.S_grid+sorted_lines_1_360.S1_grid+sorted_lines_1_360.S2_grid)+sorted_lines_1_360.H_grid+23*sorted_lines_1_360.Na_grid;
mass_density = mass_density*(1.66054*10^(-21)); %amu to kg
sorted_lines_1_360.Alfven_speed = sorted_lines_1_360.B_Mag./(permeability_of_free_space*mass_density).^(1/2);
sorted_lines_1_360.Alfven_speed(isinf(sorted_lines_1_360.Alfven_speed))=0;
sorted_lines_1_360.Alfven_speed = sorted_lines_1_360.Alfven_speed*10^(-3);%convert to km/s
