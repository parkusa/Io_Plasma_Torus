
%THIS VERSION OF GRID INTERP IS FOR THE TORUS MODEL, USE GRID INTERP FOR
%THE CONTOUR PLOTS

%This module interps all required variables to run n_max on the grid of
%points. Including electron properties,fcorot and equatorial densitties.


tec_grid = interp1(L_e,ColdTemperatureSS,L_grid);

teh_grid = interp1(L_e,HotTemperatureSS,L_grid);

nhnc_grid = interp1(L_e,HotColdDensitySS,L_grid);

fcorot_grid = interp1(L_inbound,Fractional_Corotation,L_grid);


n_max_HotOxygen_grid = interp1(L_inbound,n_max_HotOxygen,L_grid);
n_max_Hydrogen_grid = interp1(L_inbound,n_max_Hydrogen,L_grid);
n_max_Oxygen_grid = interp1(L_inbound,n_max_Oxygen,L_grid);
n_max_Oxygen1_grid = interp1(L_inbound,n_max_Oxygen1,L_grid);
n_max_Sodium_grid = interp1(L_inbound,n_max_Sodium,L_grid);
n_max_Sulfur_grid = interp1(L_inbound,n_max_Sulfur,L_grid);
n_max_Sulfur1_grid = interp1(L_inbound,n_max_Sulfur1,L_grid);
n_max_Sulfur2_grid = interp1(L_inbound,n_max_Sulfur2,L_grid);

clear n_max_HotOxygen; clear n_max_Hydrogen; clear n_max_Oxygen; clear n_max_Oxygen1;
clear n_max_Sodium; clear n_max_Sulfur; clear n_max_Sulfur1; clear n_max_Sulfur2;
clear n_max_Electron;



theta_mag_generated = 0:0.02:180; %generate the theta range

sc_posR_grid = zeros(size(L_grid)); % create empty list to fill
sc_posT_grid = zeros(size(L_grid)); % create empty list to fill



[rows, columns] = size(L_grid);
progress = 0;
for j = 1:columns
    for i = 1:rows
        

progressbar([progress/1345086],[])
progress = progress+1;

        r = rmagneticfieldline(L_grid(i,j),theta_mag_generated); %find all r values for each theta along the first L shell
        theta_sys3_generated =  theta_mag_generated + Alpha_grid(i,j); % converts the theta mag list to system 3
        
        rho_sys3_location_Lmapped = r.*sind(theta_sys3_generated); % calculates the sys3 rho for each value along the L shell
        [~,I] = max(rho_sys3_location_Lmapped(:));% finds the max value of rho and saves its M(magnitude) and I(index)
        sc_posR_grid(i,j) = r(I); %appends the r value associated with max rho
        sc_posT_grid(i,j) = theta_sys3_generated(I); %appends the theta value associated with max rho
    end
end

sc_posT_grid = 90 - sc_posT_grid;
clear r; clear theta_sys3_generated; clear rows; clear columns;
clear theta_mag_generated; clear i; clear j; clear I;