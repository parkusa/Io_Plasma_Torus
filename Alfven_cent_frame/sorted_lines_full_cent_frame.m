load('/Users/pahi9557/Documents/MATLAB/Alfven_Waves/AW_data_prep/unsorted_lines.mat')


%There are two non-unique point in these lists, here I clear them
unsorted_lines_1_360.r(257188) = [];
unsorted_lines_1_360.theta(257188) = [];
unsorted_lines_1_360.phi(257188) = [];
unsorted_lines_1_360.B_Mag(257188) = [];
unsorted_lines_1_360.flag(257188) = [];

unsorted_lines_1_360.r(69514) = [];
unsorted_lines_1_360.theta(69514) = [];
unsorted_lines_1_360.phi(69514) = [];
unsorted_lines_1_360.B_Mag(69514) = [];
unsorted_lines_1_360.flag(69514) = [];





Index = find(unsorted_lines_1_360.flag==1);
sorted_lines_1_360 = struct();

for c = 1:360


if c < 360
a = Index(c);
b = Index(c+1)-1;
end

if c == 360
    a = Index(c);
    b = 373101;
end

[sorted_lines_1_360.theta(a:b), theta_order] = sort(unsorted_lines_1_360.theta(a:b));
theta_order = theta_order + a - 1;
sorted_lines_1_360.r(a:b) = unsorted_lines_1_360.r(theta_order,:);
sorted_lines_1_360.phi(a:b) = unsorted_lines_1_360.phi(theta_order,:);
sorted_lines_1_360.B_Mag(a:b) = unsorted_lines_1_360.B_Mag(theta_order,:);


end
sorted_lines_1_360.theta = sorted_lines_1_360.theta';
sorted_lines_1_360.r = sorted_lines_1_360.r';
sorted_lines_1_360.phi = sorted_lines_1_360.phi';
sorted_lines_1_360.B_Mag = sorted_lines_1_360.B_Mag';

clear a; clear b; clear c; clear theta_order; clear unsorted_lines_1_360;



%This bit deletes values for which theta is too large
%--------------------------------------
% I = find(sorted_lines_1_360.theta < -35);
% sorted_lines_1_360.theta(I)=[];
% sorted_lines_1_360.r(I)=[];
% sorted_lines_1_360.phi(I)=[];
% sorted_lines_1_360.B_Mag(I)=[];
% 
% clear I;
% I = find(sorted_lines_1_360.theta > 35);
% sorted_lines_1_360.theta(I)=[];
% sorted_lines_1_360.r(I)=[];
% sorted_lines_1_360.phi(I)=[];
% sorted_lines_1_360.B_Mag(I)=[];
% 
% clear I;
% I = find(sorted_lines_1_360.r == 0);
% sorted_lines_1_360.theta(I)=[];
% sorted_lines_1_360.r(I)=[];
% sorted_lines_1_360.phi(I)=[];
% sorted_lines_1_360.B_Mag(I)=[];
% 
% clear I;
% clear Index;
% --------------------------------------



% %This bit "re-calibrates" the index after resorting and getting rid of a
% %lot of thetas
% %-------------------
% Index = linspace(1,359,359);
% Index = Index';
% c = 1;
% for counter = 487:length(sorted_lines_1_360.r)
% a = sorted_lines_1_360.theta(counter) - sorted_lines_1_360.theta(counter - 1);
% counter
% if a < -60
% c = c+1;
% Index(c) = counter; 
% end
% end
% clear a; clear c; clear counter;
% %-------------------


for line_counter = 1:360
    
    if line_counter < 360
        a = Index(line_counter);
        b = Index(line_counter+1)-1;
    end
    if line_counter == 360
        a = Index(line_counter);
        b = 373101;% 178175 if I sorted the thetas
    end
    
    %find centrifugal location for field line
    theta_sys3_generated = 90 - sorted_lines_1_360.theta(a:b); %theta-sys3-gen is co-lat %sorted_lines_1_360.theta(a:b) + 90;
    rho_sys3_location_Lmapped = sorted_lines_1_360.r(a:b).*sind(theta_sys3_generated); % calculates the sys3 rho for each value along the shell
    [M,I] = max(rho_sys3_location_Lmapped(:));% finds the max value of rho and saves its M(magnitude) and I(index)
    I = a + I -1;
    for counter = 1:length(sorted_lines_1_360.theta(a:b)) %length of each list to be iterated
        
        counter2 = a + counter - 1;
        sorted_lines_1_360.cent_eq_index(counter2) = I;
    end
end

clear a; clear b; clear counter; clear counter2; clear I; clear line_counter; clear M; clear rho_sys3_location_Lmapped;clear theta_sys3_generated;

sorted_lines_1_360.cent_eq_index = sorted_lines_1_360.cent_eq_index';

% WRONG-> sorted_lines_1_360.phi = 360 - sorted_lines_1_360.phi;% IDL outputs west longitude, I work in east longitude