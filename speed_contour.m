% This script will produce a contour of Alfven wave speeds
%Note, when running this, you must type in the proper phi value ( line ~
%38) and load the associated grid (line ~ 83). 







PLS_master_to20%This module loads all of the data from the PLS_Master
%This version elimates duplicates in the data set. This module exists
%in the Lat-Dist/Io_Torus_Modules

VIP_cent_location_mapping %This module is supposed to compute the centrifu-
%locations in sys3 for each sc location. However, since that is already do-
%ne, this module really just computes one variable

VIP_fitting_electrons % This prepares all of the electron properties along 
%M shells

VIP_equator_nmax % This module produces the number density at each location 
%extrapolated to the equator. 

%VIP_equator_power_laws % Using power laws so I can create a model that can
%use Mshell out to M = 50

VIP_M10_cutoff % This module cuts the lists down so we only model what's inside
% M = 10.

VIP_Cold_Torus_Fudge % Fran and I have created a fudge for values for rho_cent
%5-6RJ.

VIP_Smoother %Smooths the radial profiles to get rid of jagged edges and fake
%anomalies

%making the grid
phi1 = 68; % For which phi value are you interested in?

rho_grid = 5:0.1:10; % defining x axis of contour
z_grid = -4:0.1:4; % defining y axis of contour
[Rho_grid,Z_grid] = meshgrid(rho_grid,z_grid);%creating a grid from those axises
R_grid = (Rho_grid.^2 + Z_grid.^2).^(0.5);% computing a Rad value for each point
alpha = asind(sind(9.6)*sind(phi1-68));

Phi_grid = R_grid;
Phi_grid(:) = phi1;

Alpha_grid = asind(sind(9.6)*sind(Phi_grid-68));
Theta_ceq_grid = acosd(Z_grid./R_grid);%
Theta_sys3_grid = acosd(Z_grid./R_grid)+(2/3)*Alpha_grid;
Theta_mag_grid = Theta_sys3_grid-alpha; % computing a theta_mag value for each point

VIP_Grid = struct();

VIP_Grid.r = R_grid;
VIP_Grid.theta_sys3 = Theta_sys3_grid;
VIP_Grid.phi = Phi_grid;
VIP_Grid.Theta_ceq_grid = Theta_ceq_grid;
VIP_Grid.Theta_mag_grid = Theta_mag_grid;
VIP_Grid.Rho_grid = Rho_grid;
VIP_Grid.Z_grid = Z_grid;


%Must prepare a new csv for every phi value we use
%----------------------------------
%%preparing a csv for Kaleb's produce field line code

% R = VIP_Grid.r(:);
% Theta = VIP_Grid.theta_sys3(:); 
% Phi = VIP_Grid.phi(:);
% 
% Ran1 = zeros(size(R(:)))+1;
% Ran2 = zeros(size(R(:)))+1;
% Ran3 = zeros(size(R(:)))+1;
% Ran4 = zeros(size(R(:)))+1;
% Ran5 = zeros(size(R(:)))+1;
% 
% csvwrite('2Dgrid_locations.csv',[Ran1 Ran2 Ran3 Ran4 Ran5 R Theta Phi])
%----------------------------------

load('/Users/pahi9557/Documents/MATLAB/VIP4CAN/VIP_data_prep/VIP_grid_cent_locs_contour68.mat')


% grid interp
M_grid = VIP_grid_equators.mag_r;

tec_grid = interp1(M_e,ColdTemperatureSS,M_grid);
teh_grid = interp1(M_e,HotTemperatureSS,M_grid);
nhnc_grid = interp1(M_e,HotColdDensitySS,M_grid);


fcorot_grid = interp1(M_inbound,Fractional_Corotation,M_grid);




%interpolating the cent equator density location of each point between cent location and
%density to find 
VIP_n_max_grid = struct();
VIP_n_max_grid.n_max_HotOxygen_grid = interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_HotOxygen,VIP_grid_equators.cent_r);
VIP_n_max_grid.n_max_Hydrogen_grid = interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Hydrogen,VIP_grid_equators.cent_r);
VIP_n_max_grid.n_max_Oxygen_grid = interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Oxygen,VIP_grid_equators.cent_r);
VIP_n_max_grid.n_max_Oxygen1_grid = interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Oxygen1,VIP_grid_equators.cent_r);
VIP_n_max_grid.n_max_Sodium_grid = interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Sodium,VIP_grid_equators.cent_r);
VIP_n_max_grid.n_max_Sulfur_grid = interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Sulfur,VIP_grid_equators.cent_r);
VIP_n_max_grid.n_max_Sulfur1_grid = interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Sulfur1,VIP_grid_equators.cent_r);
VIP_n_max_grid.n_max_Sulfur2_grid = interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Sulfur2,VIP_grid_equators.cent_r);



%Cassini_UVIS time variation
%-------------------------------------------------------------------
c = 1 ;  % constant offest
lambda = linspace(0,360,361); %system 3 longitude
lambda = lambda'; % change from column vector to row vector (transpose)
A = 0.19; %Amplitude of variation
phi_vary = 150; %phase of the variation
S_variation = mixing_ratio(A,lambda,phi_vary,c); %generating sinusoid
A = 0.28; %Amplitude of variation
phi_vary = 330; %phase of the variation
S2_variation = mixing_ratio(A,lambda,phi_vary,c); %generating sinusoid
clear A; clear phi_vary; clear c;
Mfactor_S_grid = interp1(lambda,S_variation,VIP_Grid.phi); %generating the
%multiplication factors for each point
Mfactor_S2_grid = interp1(lambda,S2_variation,VIP_Grid.phi); %generating the
%multiplication factors for each point
%unpacking 2D grids into 1d ones to make for loop easier
Mfactor_S_grid_1D = Mfactor_S_grid(:);
Mfactor_S2_grid_1D = Mfactor_S2_grid(:);
S_grid_1D = VIP_n_max_grid.n_max_Sulfur_grid(:);
S2_grid_1D = VIP_n_max_grid.n_max_Sulfur2_grid(:);
%ne_grid_1D = ne_grid(:);
M_grid_1D = M_grid(:);
progress1 = 0;
progressbar('Adding Time Variation...',0)
for counter = 1:length(S_grid_1D)
 progressbar([],progress1/length(S_grid_1D)) % Update progress bar
        progress1 = progress1+1;
    if M_grid_1D(counter) > 5.6
        S_varied = Mfactor_S_grid_1D(counter) * S_grid_1D(counter);
        S2_varied = Mfactor_S2_grid_1D(counter) * S2_grid_1D(counter);
        %old_elec_contribution = S_grid_1D(counter) + 3*S2_grid_1D(counter);
        %new_elec_contribution = S_varied + 3*S2_varied;
        %ne_grid_1D(counter) = ne_grid_1D(counter) - old_elec_contribution + new_elec_contribution;
        S_grid_1D(counter) = S_varied;
        S2_grid_1D(counter) = S2_varied;   
    end
end
%repacking variables into the 3D grids
VIP_n_max_grid.n_max_Sulfur_grid(:) =  S_grid_1D;
VIP_n_max_grid.n_max_Sulfur2_grid(:) = S2_grid_1D; 
%ne_grid(:) = ne_grid_1D;
%clearing now useless tools
clear Mfactor_S_grid_1D; clear Mfactor_S2_grid_1D; clear S_grid_1D; clear S2_grid_1D;
clear ne_grid_1D; clear M_grid_1D; clear old_elec_contribution;
clear S_varied; clear S2_varied; clear new_elec_contribution; clear progress1;
progressbar(1)

%-------------------------------------------------------------------






% Grid_extrp 


%This module runs n_max code to extrapolate the density at each grid point



VIP_Grid.theta_sys3 = 90 - VIP_Grid.theta_sys3; % lat dist takes in latitude
VIP_grid_equators.cent_theta = 90 - VIP_grid_equators.cent_theta;



%creating density grids to be filled

O_grid = zeros(size(M_grid));
O1_grid = zeros(size(M_grid));
HotO_grid = zeros(size(M_grid));
S_grid = zeros(size(M_grid));
S1_grid = zeros(size(M_grid));
S2_grid = zeros(size(M_grid));
H_grid = zeros(size(M_grid));
Na_grid = zeros(size(M_grid));
ne_grid = zeros(size(M_grid));



progress1 = 0;
[rows, columns] = size(M_grid);
for j = 1:columns
    for i = 1:rows

        

        progressbar(progress1/4131) % Update progress bar
        progress1 = progress1+1;
        
        %pos is the grid point, scpos is the grid point mapped to the
        %equator

        posR = VIP_Grid.r(i,j);
        posT = VIP_Grid.theta_sys3(i,j);
        scposR = VIP_grid_equators.cent_r(i,j);
        scposT = VIP_grid_equators.cent_theta(i,j);
        %tpar=64; I assign this value inside the second nested for loop.
        tec = tec_grid(i,j);% this is a list that I create in the te_teh_nhnc_calculator  module
        mass = [16,16,16,32,32,32,1,23];
        Charge = [1 2 1 1 2 3 1 1];
        fcorot = fcorot_grid(i,j);
        teh = teh_grid(i,j);
        nhnc = nhnc_grid(i,j);
        % n_scpos=; must have lists of densities for easch species at the
        % spacecraft location. I assign this value inside the second nested for
        % loop.
        ns=8;
        
        scpos_electron_density = VIP_n_max_grid.n_max_Oxygen_grid(i,j)+2*VIP_n_max_grid.n_max_Oxygen1_grid(i,j)+VIP_n_max_grid.n_max_HotOxygen_grid(i,j)...
            +VIP_n_max_grid.n_max_Sulfur_grid(i,j)+2*VIP_n_max_grid.n_max_Sulfur1_grid(i,j)+3*VIP_n_max_grid.n_max_Sulfur2_grid(i,j)...
            +VIP_n_max_grid.n_max_Hydrogen_grid(i,j)+VIP_n_max_grid.n_max_Sodium_grid(i,j);
        
        n = zeros(1,ns+1); %Pre allocates space for this array to be filled later, one
        %spot for the number denisty of each species, and one spot for the number
        %density of electrons
        P=0; % Setting the starting electric ambipolar potential to 0
        
        %Now comes time to calculate the centrifugal force. We start by
        %calculating the rho^2 distance from Jupiter, and the difference between the
        %spacecraft rho^2 and the position of interest rho^2. To be used in the
        %calculation of factor
        
        rho_sqrd_pos = posR.^2.*cosd(posT).^2; % rho for position of interest
        rho_sqrd_scpos = scposR.^2.*cosd(scposT).^2; % rho for position of interest
        FCENT = rho_sqrd_scpos - rho_sqrd_pos;% rho(S) - rho(s0) from physics walkthrough
        
        %Given this rho position, we will use a for loop to calculate the
        %centrifugal foce for each species in question. First, we begin the
        %main for loop, which will also include the squeeze of the true ambipolar
        %electric potential value.
        
        for squeeze = 1:21 %The squeeze is typically solved in < 20 iterations
            total_ion_charge = 0; %starting at 0 for blank slate. Will be used to
            %compare with total electron charge for the charge neutrality
            %assumption
            df = 0 ; %Kaleb does not really know what this represents, though it is
            %what is used to increment the squeezing process
            for species_counter = 1:ns % This is the loop where we will finish calculating F-centrifugal.
                %one iteration for each species. We will also calculate the ambiopolar
                %electric field, based on the guess for P. The loop then calculates the
                %number density as pos. The charges are summed up here as well
                
                if species_counter == 1
                    tpar = interp1(M_inbound,OTemperature,VIP_grid_equators.mag_r(i,j));
                    n_scpos = VIP_n_max_grid.n_max_Oxygen_grid(i,j);
                end
                
                if species_counter == 2
                    tpar = interp1(M_inbound,OTemperature1,VIP_grid_equators.mag_r(i,j));
                    n_scpos = VIP_n_max_grid.n_max_Oxygen1_grid(i,j);
                end
                
                if species_counter == 3
                    
                    tpar = interp1(M_inbound,HotOTemperature,VIP_grid_equators.mag_r(i,j));
                    n_scpos = VIP_n_max_grid.n_max_HotOxygen_grid(i,j);
                end
                
                if species_counter == 4
                    
                    tpar = interp1(M_inbound,STemperature,VIP_grid_equators.mag_r(i,j));
                    n_scpos = VIP_n_max_grid.n_max_Sulfur_grid(i,j);
                end
                
                if species_counter == 5
                    tpar = interp1(M_inbound,STemperature1,VIP_grid_equators.mag_r(i,j));
                    n_scpos = VIP_n_max_grid.n_max_Sulfur1_grid(i,j);
                end
                
                if species_counter == 6
                    tpar = interp1(M_inbound,STemperature2,VIP_grid_equators.mag_r(i,j));
                    n_scpos = VIP_n_max_grid.n_max_Sulfur2_grid(i,j);
                end
                
                if species_counter == 7
                    
                    tpar = interp1(M_inbound,HTemperature,VIP_grid_equators.mag_r(i,j));
                    n_scpos = VIP_n_max_grid.n_max_Hydrogen_grid(i,j);
                end
                
                if species_counter == 8
                    
                    tpar = interp1(M_inbound,NaTemperature,VIP_grid_equators.cent_r(i,j));
                    n_scpos = VIP_n_max_grid.n_max_Sodium_grid(i,j);
                end
                
                if n_scpos ~= 0
                    Ambipolar_electric_potential = Charge(species_counter)*P/tpar; %From physics
                    centrifugal_force = fcorot.^2.*0.825*mass(species_counter).*FCENT/tpar;%From physics,
                    %the fcorot is a number less than one, and is the fraction of Jupiter's
                    %angular velocity which the paeticles spin at
                    n(species_counter) = n_scpos*exp(-Ambipolar_electric_potential-centrifugal_force);%From physics
                    total_ion_charge = total_ion_charge+Charge(species_counter)*n(species_counter);%Multiplying the
                    %the charge of the species times the number density. Adding up for all
                    %of the species gives us the total charge density
                    df = df - Charge(species_counter)^2*n(species_counter)/tpar; % again, not sure what this represents
                end
            end
            
            
            
            %now to calculate the number density of electrons using this given value
            %for P
            electron_ambipolar_potential = -1.*P/tec; %from physics
            hot_electron_ambipolar_potential = electron_ambipolar_potential*tec/teh; %from physics
            electron_centrifugal_force = fcorot^2*0.825/1836.*FCENT/tec;%divide by
            %1836 for the mass of electron
            hot_electron_centrifugal_force = electron_centrifugal_force*tec/teh;
            n_cold_electrons = scpos_electron_density*(1-nhnc)*...
                exp(-electron_ambipolar_potential-electron_centrifugal_force);% same as before
            %except multiplying by (1-nhnc) because only a fraction of the electrons
            %are cold
            n_hot_electrons = scpos_electron_density*nhnc*...
                exp(-hot_electron_ambipolar_potential-hot_electron_centrifugal_force);
            n(ns+1) = n_cold_electrons + n_hot_electrons;
            
            net_charge = total_ion_charge - n(ns+1);
            df = df-n(ns+1)/tec;
            P = P-net_charge/df;
         
            O_grid(i,j) = n(1);
            O1_grid(i,j) = n(2);
            HotO_grid(i,j) = n(3);
            S_grid(i,j) = n(4);
            S1_grid(i,j) = n(5);
            S2_grid(i,j) = n(6);
            H_grid(i,j) = n(7);
            Na_grid(i,j) = n(8);
            ne_grid(i,j) = n(9);


            
            if abs(net_charge) < 0.001
                
                break
            end

            if squeeze == 21
                
            O_grid(i,j) = 0;
            O1_grid(i,j) = 0;
            HotO_grid(i,j) = 0;
            S_grid(i,j) = 0;
            S1_grid(i,j) = 0;
            S2_grid(i,j) = 0;
            H_grid(i,j) = 0;
            Na_grid(i,j) = 0;
            ne_grid(i,j) = 0;                

            end


        end
    end
end


%clearing the working parts of the code, as they are no longer useful

clear Ambipolar_electric_potential;
clear centrifugal_force;
clear counter;
clear df;
clear electron_ambipolar_potential;
clear electron_centrifugal_force;
clear FCENT;
clear fcorot;
clear hot_electron_ambipolar_potential;
clear hot_electron_centrifugal_force;
clear i;
clear ii;
clear n;
clear n_cold_electrons;
clear n_hot_electrons;
clear n_scpos;
clear net_charge;
clear nhnc;
clear ns;
clear P;
clear posR;
clear posT;
clear rho_sqrd_pos;
clear rho_sqrd_scpos;
clear scpos_electron_density;
clear scposR;
clear scposT;
clear tec;
clear teh;
clear total_ion_charge;
clear tpar;
clear squeeze;
clear species_counter;





progressbar(1); %closes the progress bar module






%calculating and plotting alfven speeds

b = 10^(-9);
VIP_grid_equators.b_field = VIP_grid_equators.b_field*b;
clear b;
permeability_of_free_space = 4*pi*10^(-7);

total_amu = 16*(O_grid+O1_grid+HotO_grid)+32*(S_grid+S1_grid+S2_grid)+H_grid+23*Na_grid;
mass_density = total_amu*(1.66054*10^(-21)); %amu to kg
clear total_amu;

Alfven_speed = VIP_grid_equators.b_field./(permeability_of_free_space*mass_density).^(1/2);
Alfven_speed = Alfven_speed*10^(-3);%convert to km/s

Alfven_speed(isinf(Alfven_speed))=299792; % speed of light in km/s

a = [250,500,1000];%contour values

a1 = [5.9, 5.9];
a2 = [-0.7 0.7];

figure()
c = contour(Rho_grid,Z_grid,Alfven_speed,a,'k');
clabel(c,'FontSize',17,'FontWeight','bold','Color','k')
hold on
plot(a1,a2,'m','linewidth',2);

str = {'Io''s orbit'};
text(8,3,str,'Color','m','FontSize',22)
%h = colorbar;
% colormap('default')
% temp1 = colormap;
% temp1 = temp1(end:-1:1,:);
% colormap(temp1);
%h = colorbar;
%caxis([0 50])
% ylabel(h, 'colorbar label here')
title(['Alfven Speed in km/s at \phi = ' num2str(phi1)],'fontweight','bold','fontsize',28)
xlabel('\rho_{cent}','fontweight','bold','fontsize',20) 
ylabel('Z_{RJ}','fontweight','bold','fontsize',20)
set(gca,'FontSize',16)
set(gca,'yminorgrid','on')
set(gca,'xminorgrid','on')
daspect([1 1 1])
