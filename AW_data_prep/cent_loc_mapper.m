load('/Users/pahi9557/Documents/MATLAB/Alfven_Waves/AW_data_prep/full_field_data.mat')
clear cent_eq_index;

%DEFINE r
%r = field_line_68.Radius;

%DEFINE this theta
theta_sys3_generated =  field_line_68.Theta + 90;
rho_sys3_location_Lmapped = r.*sind(theta_sys3_generated); % calculates the sys3 rho for each value along the shell
[M,I] = max(rho_sys3_location_Lmapped(:));% finds the max value of rho and saves its M(magnitude) and I(index)

