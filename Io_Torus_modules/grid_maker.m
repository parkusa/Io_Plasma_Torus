%                 Making the VIP grid
phi_grid = 0:1:360; %generate the phi range
rho_grid = 5.5:0.1:10; % defining x axis of contour
z_grid = -4:0.1:4; % defining y axis of contour
[Rho_grid,Z_grid,Phi_grid] = meshgrid(rho_grid,z_grid,phi_grid);%creating a grid from those axises
R_grid = (Rho_grid.^2 + Z_grid.^2).^(0.5);% computing a Rad value for each point
Alpha_grid = asind(sind(9.6)*sind(Phi_grid-68));
Theta_mag_grid = acosd(Z_grid./R_grid)-Alpha_grid; % computing a theta_mag value for each point
Theta_ceq_grid = acosd(Z_grid./R_grid)-(2/3)*Alpha_grid;
Theta_sys3_grid = acosd(Z_grid./R_grid);
x_sys3 = R_grid.*sind(Theta_sys3_grid).*cosd(Phi_grid);
y_sys3 = R_grid.*sind(Theta_sys3_grid).*sind(Phi_grid);
z_sys3 = R_grid.*cosd(Theta_sys3_grid);
L_grid = Lmagneticfieldline(R_grid,Theta_mag_grid); %the L values for each point in our grid