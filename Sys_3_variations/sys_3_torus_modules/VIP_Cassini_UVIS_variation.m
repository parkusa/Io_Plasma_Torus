
%This module applies the sys 3 variation found in A. Steffl's papers to our
%centrifugal density points at different longitudes.


%note, I'm not messing with charge density here, so after running this
%module electron densities for the radial profiles will be off. However,
%my torus code re calculates electron density during lat dist (Grid_extrp)
%so it's okay


%loading the relative variations
%for further explanation of the following block of code see:
%Relative_variation_plots.m
c = 1 ;  % constant offest
lambda = linspace(0,360,361); %system 3 longitude
lambda = lambda'; % change from column vector to row vector (transpose)
A = 0.19; %Amplitude of variation
phi = 150; %phase of the variation
S_variation = mixing_ratio(A,lambda,phi,c); %generating sinusoid
A = 0.28; %Amplitude of variation
phi = 330; %phase of the variation
S2_variation = mixing_ratio(A,lambda,phi,c); %generating sinusoid
clear A; clear phi; clear c;


Mfactor_S_grid = interp1(lambda,S_variation,VIP_Grid.phi); %generating the
%multiplication factors for each point
Mfactor_S2_grid = interp1(lambda,S2_variation,VIP_Grid.phi); %generating the
%multiplication factors for each point

%unpacking 3D grids into 1d ones to make for loop easier

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



