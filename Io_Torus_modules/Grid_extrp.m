%This module runs n_max code to extrapolate the density at each grid point



Theta_sys3_grid = 90 - Theta_sys3_grid; % lat dist takes in latitude

%creating density grids to be filled

O_grid = zeros(size(L_grid));
O1_grid = zeros(size(L_grid));
HotO_grid = zeros(size(L_grid));
S_grid = zeros(size(L_grid));
S1_grid = zeros(size(L_grid));
S2_grid = zeros(size(L_grid));
H_grid = zeros(size(L_grid));
Na_grid = zeros(size(L_grid));
ne_grid = zeros(size(L_grid));



progress1 = 0;
[rows, columns] = size(L_grid);
for j = 1:columns
    for i = 1:rows

        

        progressbar([[],progress1/1345086]) % Update progress bar
        progress1 = progress1+1;
        
        posR = R_grid(i,j);
        posT = Theta_sys3_grid(i,j);
        scposR=sc_posR_grid(i,j);
        scposT=sc_posT_grid(i,j);
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
        
        scpos_electron_density = n_max_Oxygen_grid(i,j)+2*n_max_Oxygen1_grid(i,j)+n_max_HotOxygen_grid(i,j)...
            +n_max_Sulfur_grid(i,j)+2*n_max_Sulfur1_grid(i,j)+3*n_max_Sulfur2_grid(i,j)...
            +n_max_Hydrogen_grid(i,j)+n_max_Sodium_grid(i,j);
        
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
        
        for squeeze = 1:20 %The squeeze is typically solved in < 20 iterations
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
                    tpar = interp1(L_inbound,OTemperature,L_grid(i,j));
                    n_scpos = n_max_Oxygen_grid(i,j);
                end
                
                if species_counter == 2
                    tpar = interp1(L_inbound,OTemperature1,L_grid(i,j));
                    n_scpos = n_max_Oxygen1_grid(i,j);
                end
                
                if species_counter == 3
                    
                    tpar = interp1(L_inbound,HotOTemperature,L_grid(i,j));
                    n_scpos = n_max_HotOxygen_grid(i,j);
                end
                
                if species_counter == 4
                    
                    tpar = interp1(L_inbound,STemperature,L_grid(i,j));
                    n_scpos = n_max_Sulfur_grid(i,j);
                end
                
                if species_counter == 5
                    tpar = interp1(L_inbound,STemperature1,L_grid(i,j));
                    n_scpos = n_max_Sulfur1_grid(i,j);
                end
                
                if species_counter == 6
                    tpar = interp1(L_inbound,STemperature2,L_grid(i,j));
                    n_scpos = n_max_Sulfur2_grid(i,j);
                end
                
                if species_counter == 7
                    
                    tpar = interp1(L_inbound,HTemperature,L_grid(i,j));
                    n_scpos = n_max_Hydrogen_grid(i,j);
                end
                
                if species_counter == 8
                    
                    tpar = interp1(L_inbound,NaTemperature,L_grid(i,j));
                    n_scpos = n_max_Sodium_grid(i,j);
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