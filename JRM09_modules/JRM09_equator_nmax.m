
M_inbound = JRM09_mag_loc.r;

JRM09_tec_list = interp1(M_e,ColdTemperatureSS,M_inbound);
JRM09_teh_list = interp1(M_e,HotTemperatureSS,M_inbound);
JRM09_nhnc_list = interp1(M_e,HotColdDensitySS,M_inbound);

JRM09_nmax_eq = struct();

        JRM09_nmax_eq.n_max_Oxygen = zeros(1,length(Rad));
        JRM09_nmax_eq.n_max_Oxygen1 = zeros(1,length(Rad));
        JRM09_nmax_eq.n_max_HotOxygen = zeros(1,length(Rad));
        JRM09_nmax_eq.n_max_Sulfur = zeros(1,length(Rad));
        JRM09_nmax_eq.n_max_Sulfur1 = zeros(1,length(Rad));
        JRM09_nmax_eq.n_max_Sulfur2 = zeros(1,length(Rad));
        JRM09_nmax_eq.n_max_Hydrogen = zeros(1,length(Rad));
        JRM09_nmax_eq.n_max_Sodium = zeros(1,length(Rad));
        JRM09_nmax_eq.n_max_Electron = zeros(1,length(Rad));

for counter = 1:length(Rad) %length of each list to be iterated
    
    ns=8;
    posR = JRM09_cent_loc.r(counter);
    posT = 90 - JRM09_cent_loc.theta(counter); %sys3
    scposR = Rad(counter);
    scposT = 90 - SIII_Theta(counter);
    %tpar=64; I assign this value inside the second nested for loop.
    te = JRM09_tec_list(counter);% this is a list that I create in the te_teh_nhnc_calculator  module
    mass=[16,16,16,32,32,32,1,23];
    Charge=[1 2 1 1 2 3 1 1];
    fcorot=Fractional_Corotation(counter);
    teh=JRM09_teh_list(counter);% this is a list that I create in the te_teh_nhnc_calculator  module
    nhnc=JRM09_nhnc_list(counter); %this is a list that I create in the te_teh_nhnc_calculator  module
    % this is a ratio of hot electron density to cold electron density!
    % very small numbers!
    % n_scpos=; must have lists of densities for easch species at the
    % spacecraft location. I assign this value inside the second nested for
    % loop.
    
    
    
    %    MAXWELLIAN DISTRIBUTIONS - ISOTROPIC
    %    includes effect of sub-corotational motion in reducing the
    %    centrifugal force by fcorot^2
    %    INPUT:
    %    ns = No. of ion species
    %    n_scpos = LIST density of the ion species at spacecraft location
    %    pos=position - where you want the densities calculated
    %    posR=r
    %    posT=lat, sys 3
    %    scpos=position - where reference densities are measured/provided
    %    scposR=r
    %    scposT=lat, sys 3
    %    scpos_electron_density= electron density at SC positon
    %    charge() is a  LIST of the charges for each species in ns
    % where ni(ns+1)=electron density
    %    tpar(ns)=parallel temperatures of ions, this is a  LIST for each
    %species
    %    te=electron temperature
    %    mass(ns)mass of each ion species, LIST corresponding to ns
    %    char(ns)charge of each ion species
    %    Vphi/Vcorotation
    %    OUTPUT:
    %    n(ns+1)= output densities of ns ion species plus n(ns+1)=electron density
    
    
    
    %                           !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    %Pre-define these values: ns,posR, posT, scposR, scposT, ni, tpar, te,
    %mass, char, fcorot, teh, nhnc, n_scpos
    
    
    
    
    
    %n_scpos = zeros(1,ns+1); %this should be the known density of the species at the
    %spacecraft location. This line will probably be deleted... or fixed.. or
    %something. These values should likely be pre-defined as well
    
    scpos_electron_density = ODensity(counter)+2*ODensity1(counter)+HotODensity(counter)...
    +SDensity(counter)+2*SDensity1(counter)+3*SDensity2(counter)+HDensity(counter)+NaDensity(counter);
    
    
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
    
    for i = 1:20 %The squeeze is typically solved in < 20 iterations
        total_ion_charge = 0; %starting at 0 for blank slate. Will be used to
        %compare with total electron charge for the charge neutrality
        %assumption
        df = 0 ; %Kaleb does not really know what this represents, though it is
        %what is used to increment the squeezing process
        for ii = 1:ns % This is the loop where we will finish calculating F-centrifugal.
            %one iteration for each species. We will also calculate the ambiopolar
            %electric field, based on the guess for P. The loop then calculates the
            %number density as pos. The charges are summed up here as well


            tpar_n_scpos_conditional;%Based on the iteration of the for loop, decides which
            %species temperature and density is to be considered. Defines tpar and n_scpos.
            
            if n_scpos ~= 0 % is n_scpos = 0 our equations get f$@^#&, same with tpar. Dividng by
                            % zero is a no go.

            Ambipolar_electric_potential = Charge(ii)*P/tpar; %From physics
            centrifugal_force = fcorot.^2.*0.825*mass(ii).*FCENT/tpar;%From physics,
            %the fcorot is a number less than one, and is the fraction of Jupiter's
            %angular velocity which the paeticles spin at
            n(ii) = n_scpos*exp(-Ambipolar_electric_potential-centrifugal_force);%From physics
            total_ion_charge = total_ion_charge+Charge(ii)*n(ii);%Multiplying the
            %the charge of the species times the number density. Adding up for all
            %of the species gives us the total charge density
            df = df - Charge(ii)^2*n(ii)/tpar; % again, not sure what this represents
            end
        end
        
        %now to calculate the number density of electrons using this given value
        %for P
        electron_ambipolar_potential = -1.*P/te; %from physics
        hot_electron_ambipolar_potential = electron_ambipolar_potential*te/teh; %from physics
        electron_centrifugal_force = fcorot^2*0.825/1836.*FCENT/te;%divide by
        %1836 for the mass of electron
        hot_electron_centrifugal_force = electron_centrifugal_force*te/teh;
        n_cold_electrons = scpos_electron_density*(1-nhnc)*...
            exp(-electron_ambipolar_potential-electron_centrifugal_force);% same as before
        %except multiplying by (1-nhnc) because only a fraction of the electrons
        %are cold
        n_hot_electrons = scpos_electron_density*nhnc*...
            exp(-hot_electron_ambipolar_potential-hot_electron_centrifugal_force);
        n(ns+1) = n_cold_electrons + n_hot_electrons;
        
        net_charge = total_ion_charge - n(ns+1);
        df = df-n(ns+1)/te;
        P = P-net_charge/df;
        
        JRM09_nmax_eq.n_max_Oxygen(counter) = n(1);
        JRM09_nmax_eq.n_max_Oxygen1(counter) = n(2);
        JRM09_nmax_eq.n_max_HotOxygen(counter) = n(3);
        JRM09_nmax_eq.n_max_Sulfur(counter) = n(4);
        JRM09_nmax_eq.n_max_Sulfur1(counter) = n(5);
        JRM09_nmax_eq.n_max_Sulfur2(counter) = n(6);
        JRM09_nmax_eq.n_max_Hydrogen(counter) = n(7);
        JRM09_nmax_eq.n_max_Sodium(counter) = n(8);
        JRM09_nmax_eq.n_max_Electron(counter) = n(9);

        if abs(net_charge) < 0.001
            break
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
clear te;
clear teh;
clear total_ion_charge;
clear tpar;

%transposing the density lists.
        JRM09_nmax_eq.n_max_Oxygen = JRM09_nmax_eq.n_max_Oxygen';
        JRM09_nmax_eq.n_max_Oxygen1 = JRM09_nmax_eq.n_max_Oxygen1';
        JRM09_nmax_eq.n_max_HotOxygen = JRM09_nmax_eq.n_max_HotOxygen';
        JRM09_nmax_eq.n_max_Sulfur = JRM09_nmax_eq.n_max_Sulfur';
        JRM09_nmax_eq.n_max_Sulfur1 = JRM09_nmax_eq.n_max_Sulfur1';
        JRM09_nmax_eq.n_max_Sulfur2 = JRM09_nmax_eq.n_max_Sulfur2';
        JRM09_nmax_eq.n_max_Hydrogen = JRM09_nmax_eq.n_max_Hydrogen';
        JRM09_nmax_eq.n_max_Sodium = JRM09_nmax_eq.n_max_Sodium';
        JRM09_nmax_eq.n_max_Electron = JRM09_nmax_eq.n_max_Electron';