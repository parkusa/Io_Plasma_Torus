% visualizing magentic perturbation at Alfven Wing

%defining constants
B_0   =  1.72*10^(-6);
mu_0  =  4*pi*10^(-7);
E_0   =  mu_0*B_0;
E_i   =  0.0909*E_0;
Sig_A =  4.033;
R_Io  = 1.821*10^6;


%Step 1: Create 3D grid
[x,y,z] = meshgrid([R_Io*(-10):R_Io*3:R_Io*10]);

%Step 2: Define 3 components of "velocity" vector

%B_x & B_y depend on whether rho > R_Io or not. So I need to create this
%condition.
temp_rho = sqrt(x(:).^2 + y(:).^2);
rho = x;
rho(:) = temp_rho;
clear temp_rho;

for c = 1:length(rho(:))

    if rho(c) < R_Io
        temp_B_x(c) = -E_i*mu_0*Sig_A;
        temp_B_y(c) = 0;
        a = 1;
    else
        temp_B_x(c) = (-E_0 + R_Io^2*(E_0 - E_i)*((x(c)^2 - y(c)^2)/rho(c)^4))*mu_0*Sig_A;
        temp_B_y(c) = R_Io^2*(E_0 - E_i)*2*x(c)*y(c)*mu_0*Sig_A/rho(c)^4;
        b = 1;
    end
    
    B_perp = sqrt(temp_B_x(c)^2+temp_B_y(c)^2);
    temp_B_z(c) = -sqrt(B_0^2 - B_perp^2);
    
end

u = x; u(:) = temp_B_x; clear temp_B_x;
v = x; v(:) = temp_B_y; clear temp_B_y;
w = x; w(:) = temp_B_z; clear temp_B_z;


figure(1)
%quiver3(x,y,z,u,v,w)
hold on
streamline(x,y,z,u,v,w,x,y,z)
[a,b,c] = cylinder(R_Io);
c(2, :) = R_Io*10;
surf(a,b,c, 'FaceColor', [1,0,0]);
zlim([0 10]);


figure()
streamslice(x,y,z,u,v,w,[],[],3)



% 2D version
% % visualizing magentic perturbation at Alfven Wing
% 
% %defining constants
% B_0   =  1.72*10^(-6);
% mu_0  =  4*pi*10^(-7);
% E_0   =  mu_0*B_0;
% E_i   =  0.0909*E_0;
% Sig_A =  4.033;
% R_Io  = 1.821*10^6;
% 
% 
% %Step 1: Create 3D grid
% [x,y] = meshgrid([R_Io*(-3):R_Io*0.5:R_Io*3]);
% 
% %Step 2: Define 3 components of "velocity" vector
% 
% %B_x & B_y depend on whether rho > R_Io or not. So I need to create this
% %condition.
% temp_rho = sqrt(x(:).^2 + y(:).^2);
% rho = x;
% rho(:) = temp_rho;
% clear temp_rho;
% 
% for c = 1:length(rho(:))
% 
%     if rho(c) < R_Io
%         temp_B_x(c) = -E_i*mu_0*Sig_A;
%         temp_B_y(c) = 0;
%         a = 1;
%     else
%         temp_B_x(c) = (-E_0 + R_Io^2*(E_0 - E_i)*((x(c)^2 - y(c)^2)/rho(c)^4))*mu_0*Sig_A;
%         temp_B_y(c) = R_Io^2*(E_0 - E_i)*2*x(c)*y(c)*mu_0*Sig_A/rho(c)^4;
%         b = 1;
%     end
%     
%     B_perp = sqrt(temp_B_x(c)^2+temp_B_y(c)^2);
%     temp_B_z(c) = -sqrt(B_0^2 - B_perp^2);
%     
% end
% 
% u = x; u(:) = temp_B_x; clear temp_B_x;
% v = x; v(:) = temp_B_y; clear temp_B_y;
% w = x; w(:) = temp_B_z; clear temp_B_z;
% 
% 
% figure(1)
% quiver(x,y,u,v)
% %hold on
% streamline(x,y,u,v,x,y)
