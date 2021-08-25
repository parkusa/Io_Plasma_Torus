

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

VIP_grid_maker% making the gird and loading the centrifugal locations generated
%at each grid point using Parker's version of Kaleb's produce field line
%code.

VIP_Grid_Interp%This module interps all required variables to run n_max on the grid of
%points. Including electron properties,fcorot and equatorial densitties.

VIP_Grid.theta_sys3 = 90 - VIP_Grid.theta_sys3; % lat dist takes in latitude
VIP_grid_equators.cent_theta = 90 - VIP_grid_equators.cent_theta;

load_sort_field_lines

%creating density grids to be filled

O_grid = zeros(size(field_line_158.x));
O1_grid = zeros(size(O_grid));
HotO_grid = zeros(size(O_grid));
S_grid = zeros(size(O_grid));
S1_grid = zeros(size(O_grid));
S2_grid = zeros(size(O_grid));
H_grid = zeros(size(O_grid));
Na_grid = zeros(size(O_grid));
ne_grid = zeros(size(O_grid));




for counter = 1:length(field_line_158.Radius) %length of each list to be iterated
    %pos is the grid point, scpos is the grid point mapped to the
    %equator
    
    posR = field_line_158.Radius(counter);
    posT = field_line_158.Theta(counter);
    scposR =field_line_158.Radius(184); % found this value using cent mapper
    scposT = field_line_158.Theta(184);
    %tpar=64; I assign this value inside the second nested for loop.
    tec = interp1(M_e,ColdTemperatureSS,6);% this is a list that I create in the te_teh_nhnc_calculator  module
    mass = [16,16,16,32,32,32,1,23];
    Charge = [1 2 1 1 2 3 1 1];
    fcorot = 1;
    teh = interp1(M_e,HotTemperatureSS,6);
    nhnc = interp1(M_e,HotColdDensitySS,6);
    % n_scpos=; must have lists of densities for easch species at the
    % spacecraft location. I assign this value inside the second nested for
    % loop.
    ns=8;
    
    scpos_electron_density = interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Oxygen,5.9)+2*interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Oxygen1,5.9)+interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_HotOxygen,5.9)...
        +interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Sulfur,5.9)+2*interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Sulfur1,5.9)+3*interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Sulfur2,5.9)...
        +interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Hydrogen,5.9)+interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Sodium,5.9);
    
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
                tpar = interp1(M_inbound,OTemperature,6);
                n_scpos = interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Oxygen,6);
            end
            
            if species_counter == 2
                tpar = interp1(M_inbound,OTemperature1,6);
                n_scpos = interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Oxygen1,6);
            end
            
            if species_counter == 3
                
                tpar = interp1(M_inbound,HotOTemperature,6);
                n_scpos = interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_HotOxygen,6);
            end
            
            if species_counter == 4
                
                tpar = interp1(M_inbound,STemperature,6);
                n_scpos = interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Sulfur,6);
            end
            
            if species_counter == 5
                tpar = interp1(M_inbound,STemperature1,6);
                n_scpos = interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Sulfur1,6);
            end
            
            if species_counter == 6
                tpar = interp1(M_inbound,STemperature2,6);
                n_scpos = interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Sulfur2,6);
            end
            
            if species_counter == 7
                
                tpar = interp1(M_inbound,HTemperature,6);
                n_scpos = interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Hydrogen,6);
            end
            
            if species_counter == 8
                
                tpar = interp1(M_inbound,NaTemperature,6);
                n_scpos = interp1(VIP_cent_loc.r,VIP_nmax_eq.n_max_Sodium,6);
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
        
        O_grid(counter) = n(1);
        O1_grid(counter) = n(2);
        HotO_grid(counter) = n(3);
        S_grid(counter) = n(4);
        S1_grid(counter) = n(5);
        S2_grid(counter) = n(6);
        H_grid(counter) = n(7);
        Na_grid(counter) = n(8);
        ne_grid(counter) = n(9);
        
        
        
        if abs(net_charge) < 0.001
            
            break
        end
        
        if squeeze == 21
            
            O_grid(counter) = 0;
            O1_grid(counter) = 0;
            HotO_grid(counter) = 0;
            S_grid(counter) = 0;
            S1_grid(counter) = 0;
            S2_grid(counter) = 0;
            H_grid(counter) = 0;
            Na_grid(counter) = 0;
            ne_grid(counter) = 0;
            
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


figure()
grid on
semilogy(field_line_158.Theta,HotO_grid,'Linewidth',4);
hold on
semilogy(field_line_158.Theta,H_grid,'Linewidth',4);
semilogy(field_line_158.Theta,O_grid,'Linewidth',4);
semilogy(field_line_158.Theta,O1_grid,'Linewidth',4);
semilogy(field_line_158.Theta,Na_grid,'Linewidth',4);
semilogy(field_line_158.Theta,S_grid,'Linewidth',4);
semilogy(field_line_158.Theta,S1_grid,'Linewidth',4);
i = semilogy(field_line_158.Theta,S2_grid,'Linewidth',4);
set(i, 'Color', (1/255)*[255 204 229])
yt=[ 0:.5:1 10:30:90 100:200:800];
set(gca,'ytick',yt)
set(gca,'yminorgrid','on')
%xt=(0:1:6);
%set(gca,'xtick',xt)
set(gca,'xminorgrid','on')
set(gca,'FontSize',16)
title('M = 6 \phi = 158','fontweight','bold','fontsize',22)
ylabel('ions/cm^3','fontweight','bold','fontsize',22) % x-axis label
xlabel('\theta_{Magnetic}','fontweight','bold','fontsize',22) % y-axis label
h_legend = legend('hot O+', 'H+','O+','O++','Na+','S+','S++','S+++','Location','best');
set(h_legend,'FontSize',20);
xlim([-35 35])
%ylim([1 1000])