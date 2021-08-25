
% Loading the data set imported from IDL. This is raw.

load('/Users/pahi9557/Documents/MATLAB/HDAlfven_JRM09/HDJRM09_Alfven.mat')
JRM09.theta = 90 - JRM09.theta; %changing to latitude from co-latitude.

%Because I use the REVDIR keyword in IDL, each field line is traced up
%and down from the same starting point. The result is that this starting
%point is duplicated. This code finds the index for each of these duplicate
%points so that I can work on removing 1 form each pair. If I generate 360
%lines, index should be a list with 360x2=720 elements.
[n, bin] = histc(JRM09.phi, unique(JRM09.phi));
multiple = find(n > 1);
index    = find(ismember(bin, multiple));
clear multiple; clear n; clear bin;

%this code actually removes one of the duplicates from each pair. I delete
%starting with larger indexes so as not to change the value of the index of
%other duplicates by deleting one duplicate

index = fliplr(index')';
for i = 1:2:length(index)
JRM09.r(index(i)) = [];
JRM09.theta(index(i)) = [];
JRM09.phi(index(i)) = [];
JRM09.magB(index(i)) = [];
end
clear i; 
index = fliplr(index')';
clear index;

%Now I want to create THE index that dictates where one field line ends and
%the next one begins. Note, row 1 of the index indicates where the phi = 0
%field line begins. row 2 indicates wherw phi = .1 -> phi = (row - 1)/10
JRM09.index = [];
for i=0:0.1:359.9
[row,] = find(abs(JRM09.phi - i) < 1e-5);
j = find(abs(JRM09.r(row) - 6) < 1e-5);
JRM09.index = [JRM09.index row(j)];
end
JRM09.index = JRM09.index'; clear i; clear j; clear row;


%Here I reduce the size of each of the arrays by a factor of ~10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% progress1 = 0;
% d = 0; % a counter
% temp_var = length(JRM09.phi); % the # of elements we have
% var_to_delete = linspace(0,0,length(JRM09.phi))'; % creating a list of zeros
% %with size equal to the # of elements we have
% for counter = 1:temp_var % i want to loop through each variable
%  progressbar(progress1/length(JRM09.phi)) % Update progress bar
%         progress1 = progress1+1; %progress the progress bar
%         backwards_counter = temp_var + 1 - counter; %count backwards to not affect indicies of future deletions
%         %JRM09.phi(backwards_counter);
%         d = d+1; % increment this counter     
%         if d < 10 % i want to keep only every 10th value
%                 var_to_delete(counter) = backwards_counter; %save the index for deletion
%         end      
%         if d ==10 %reset the counter every 10th iteration
%             d =0;
%         end
% end
% progressbar(1) %close progress bar
% for counter = 1:temp_var %for every element
% row = find(JRM09.index == var_to_delete(counter)); %check to see if it is one of our indexes
% if floor(row)==row %if it is an index
% var_to_delete(counter) = 0; %effectively remove it from the list of things to be deleted
% end
% end
% I = find(var_to_delete == 0); % find all the 0's in the to be deleted list
% var_to_delete(I) = []; %remove those zeros
% JRM09.r(var_to_delete)=[]; % now delete all of the indexes to shorten our lists
% JRM09.theta(var_to_delete)=[];% now delete all of the indexes to shorten our lists
% JRM09.phi(var_to_delete)=[];% now delete all of the indexes to shorten our lists
% JRM09.magB(var_to_delete)=[];% now delete all of the indexes to shorten our lists
% clear progress1; clear temp_var; clear d; clear ans; clear backwards_counter;
% clear counter; clear I; clear var_to_delete; clear row;
% %re-defining index.
% JRM09.index = [];
% for i=0:0.1:359.9
% [row,] = find(abs(JRM09.phi - i) < 1e-5);
% j = find(abs(JRM09.r(row) - 6) < 1e-5);
% JRM09.index = [JRM09.index row(j)];
% end
% JRM09.index = JRM09.index'; clear i; clear j; clear row;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%now I want to sort each list according to the value of theta, this causes
%every field line to start from it's lowest latitude and go to its highest
%latitude. The index still apropriatley indexes field lines, but they no 
%longer start at the 0.1 phi values

%Note that this sorting will cause problems as the field lines fold at
%the top and theta sorting fails. Later we will actually sort by
%B_mag to solve this

for c = 1:3600

if c < 3600
a = JRM09.index(c);
b = JRM09.index(c+1)-1;
end

if c == 3600
    a = JRM09.index(c);
    b = length(JRM09.phi);
end

[JRM09.theta(a:b), theta_order] = sort(JRM09.theta(a:b));
theta_order = theta_order + a - 1;
JRM09.r(a:b) = JRM09.r(theta_order,:);
JRM09.phi(a:b) = JRM09.phi(theta_order,:);
JRM09.magB(a:b) = JRM09.magB(theta_order,:);

end
clear a; clear b; clear c; clear theta_order;


%now, to find the centrifugal equator along each field line
JRM09.cent_eq = []; % create an empty variable
for c = 1:3600
    
    if c < 3600
        a = JRM09.index(c);
        b = JRM09.index(c+1)-1;
    end
    
    if c == 3600
        a = JRM09.index(c);
        b = length(JRM09.phi);
    end
    
    %find centrifugal location for field line
    rho_sys3_location_Lmapped = JRM09.r(a:b).*cosd(JRM09.theta(a:b)); % calculates the sys3 rho for each value along the shell
    [M,I] = max(rho_sys3_location_Lmapped(:));% finds the max value of rho and saves its M(magnitude) and I(index)
    I = a + I -1;
    JRM09.cent_eq = [JRM09.cent_eq I];
    for counter = 1:length(JRM09.theta(a:b)) %length of each list to be iterated
        %pos is the grid point, scpos is the grid point mapped to the
        %equator
        
        counter2 = a + counter - 1;
        JRM09.cent_eq_index(counter2) = I;
    end

end

clear a; clear b; clear counter; clear counter2; clear I; clear c; clear M; clear rho_sys3_location_Lmapped;clear theta_sys3_generated;





JRM09.mag_eq = [];
for c = 1:3600
    
    if c < 3600
        a = JRM09.index(c);
        b = JRM09.index(c+1)-1;
    end
    
    if c == 3600
        a = JRM09.index(c);
        b = length(JRM09.phi);
    end
    
    %find magnetic location for field line
    B = JRM09.magB(a:b); % calculates the sys3 rho for each value along the shell
    [M,I] = min(B);% finds the max value of rho and saves its M(magnitude) and I(index)
    I = a + I -1;
    JRM09.mag_eq = [JRM09.mag_eq I];

for counter = 1:length(JRM09.theta(a:b)) %length of each list to be iterated
        %pos is the grid point, scpos is the grid point mapped to the
        %equator
        
        counter2 = a + counter - 1;
        JRM09.mag_eq_index(counter2) = I;
    end

end

clear a; clear b; clear counter; clear B; clear I; clear c; clear M; clear rho_sys3_location_Lmapped;clear theta_sys3_generated;

clear counter2;
JRM09.cent_eq = JRM09.cent_eq'; JRM09.cent_eq_index = JRM09.cent_eq_index';
JRM09.mag_eq=JRM09.mag_eq';JRM09.mag_eq_index=JRM09.mag_eq_index';


%Now I prepare the final ouput of this script: sorted_line_1_360. This is a
%stucture that I used in the old alfven code. Reusing this title will allow
%me to easily transfer old Alfven code to this JRMo9 model!

I = find(JRM09.phi > 360);
JRM09.phi(I) = JRM09.phi(I) - 360;
clear I;

sorted_lines_1_360 = struct();
sorted_lines_1_360.r = JRM09.r;
sorted_lines_1_360.theta = JRM09.theta;
sorted_lines_1_360.phi = JRM09.phi;
sorted_lines_1_360.B_Mag = JRM09.magB;
sorted_lines_1_360.cent_eq_index = JRM09.cent_eq_index;
sorted_lines_1_360.mag_eq_index=JRM09.mag_eq_index;
Index = JRM09.index;



% Verification plots

% 
% X = JRM09.r.*sind(90 - JRM09.theta).*cosd(JRM09.phi);
% Y = JRM09.r.*sind(90 - JRM09.theta).*sind(JRM09.phi);
% Z = JRM09.r.*cosd(90 - JRM09.theta);
% figure()
% scatter3(X,Y,Z)
% hold on
% 
% X = JRM09.r(JRM09.cent_eq).*sind(90 - JRM09.theta(JRM09.cent_eq)).*cosd(JRM09.phi(JRM09.cent_eq));
% Y = JRM09.r(JRM09.cent_eq).*sind(90 - JRM09.theta(JRM09.cent_eq)).*sind(JRM09.phi(JRM09.cent_eq));
% Z = JRM09.r(JRM09.cent_eq).*cosd(90 - JRM09.theta(JRM09.cent_eq));
% %figure()
% scatter3(X,Y,Z, 'r')
% hold on
% X = JRM09.r(JRM09.mag_eq).*sind(90 - JRM09.theta(JRM09.mag_eq)).*cosd(JRM09.phi(JRM09.mag_eq));
% Y = JRM09.r(JRM09.mag_eq).*sind(90 - JRM09.theta(JRM09.mag_eq)).*sind(JRM09.phi(JRM09.mag_eq));
% Z = JRM09.r(JRM09.mag_eq).*cosd(90 - JRM09.theta(JRM09.mag_eq));
% %figure()
% scatter3(X,Y,Z, 'g')

