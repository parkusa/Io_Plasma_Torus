load('/Users/pahi9557/Documents/MATLAB/JRM09/modelfeb18_19.mat')


gridpoint_volume = 0.1*pi*((JRM09_Grid.Rho_grid + 0.05).^2 - (JRM09_Grid.Rho_grid - 0.05).^2)/360;
gridpoint_volume = gridpoint_volume*71492e5^3; %cubic RJ to cubic cm

mass_density = 16*(O_grid+O1_grid+HotO_grid)+32*(S_grid+S1_grid+S2_grid)+H_grid+23*Na_grid;
mass_density = mass_density*(1.66054*10^(-27)); %amu to kg

%delete double counting from 0 & 360
a = size(JRM09_Grid.phi);
length = a(1) * a(2) * a(3);
for counter = 1:length;

if JRM09_Grid.phi(counter) == 0
    mass_density(counter) = 0;
end


if JRM09_Grid.phi(counter) == 0
    ne_grid(counter) = 0;
end

end
clear a; clear length; clear counter;


all_electrons = ne_grid.*gridpoint_volume;
TEC = sum(all_electrons(:))
mass = mass_density.*gridpoint_volume;
Total_mass2 = sum(mass(:))


I = find(M_grid > 6);
A = sum(mass(I))
I = find(M_grid<6 & M_grid>5.7);
B = sum(mass(I))
I = find(M_grid < 5.7);
C = sum(mass(I))

tot = A + B + C