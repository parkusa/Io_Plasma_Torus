%This module maps the location of the centrifugal equator at each sc
%location

theta_mag_generated = 0:0.02:180; %generate the theta range

r_cent_location_Lmapped = []; % create empty list to fill
theta_sys3_cent_location_Lmapped = [];% create empty list to fill



for ii = 1:length(L_inbound) %iterate for every coordinate
   r = rmagneticfieldline(L_inbound(ii),theta_mag_generated); %find all r values for each theta along the first L shell

    alpha = asind(sind(9.6)*sind(Phi(ii)-68)); %the term required to switch theta across coordinate systems
    theta_sys3_generated =  theta_mag_generated + alpha; % converts the theta mag list to system 3
  

   

    rho_sys3_location_Lmapped = r.*sind(theta_sys3_generated); % calculates the sys3 rho for each value along the L shell
    [M,I] = max(rho_sys3_location_Lmapped(:));% finds the max value of rho and saves its M(magnitude) and I(index)
    r_cent_location_Lmapped = [r_cent_location_Lmapped,r(I)]; %appends the r value associated with max rho
    theta_sys3_cent_location_Lmapped = [theta_sys3_cent_location_Lmapped,theta_sys3_generated(I)]; 
   
%appends the theta value associated with max rho

end


r_cent_location_Lmapped = r_cent_location_Lmapped'; % tranpose
theta_sys3_cent_location_Lmapped = theta_sys3_cent_location_Lmapped';% tranpose


% get rid of extra variables
clear alpha;
clear theta_mag_generated;
clear theta_sys3_generated;
clear rho_sys3_location_Lmapped;
clear ii;
clear r;
clear I;
clear M;
clear rho;
rho_cent_location_in_sys3 = r_cent_location_Lmapped.*sind(theta_sys3_cent_location_Lmapped);