%There are four points on my field lines that are exactly on the spin
%equator. Here, I slightly fudge the four points to be on either side of
%the equator
% sorted_lines_1_360.theta(70546) = sorted_lines_1_360.theta(70546) - eps;
% sorted_lines_1_360.theta(70547) = sorted_lines_1_360.theta(70547) + eps;
% sorted_lines_1_360.theta(256153) = sorted_lines_1_360.theta(256153) - eps;
% sorted_lines_1_360.theta(256154) = sorted_lines_1_360.theta(256154) + eps;

%rewriting index as a struct
a = Index;
clear Index;
Index = struct();
Index.Line_Index = a;
clear a;
Index.Sys3_equator = 1:3600;
Index.cent_equator_min35 = 1:3600;
Index.cent_equator_max35 = 1:3600;



sorted_lines_1_360.alpha = asind(sind(9.6)*sind(sorted_lines_1_360.phi-68)); %calculating alpha, difference between mag and spin
sorted_lines_1_360.theta_ceq = sorted_lines_1_360.theta+(2/3)*sorted_lines_1_360.alpha; %calculating cent equator


progress1 = 0;
progressbar('Sorting North vs South lists...',0)

for counter = 1:3600

progressbar([],progress1/3600) % Update progress bar
        progress1 = progress1+1;

if counter < 3600
a = Index.Line_Index(counter);
b = Index.Line_Index(counter +1) - 1;
end

if counter == 3600
a = Index.Line_Index(counter);
b = length(sorted_lines_1_360.phi);
end

Field_line_theta = sorted_lines_1_360.theta(a:b);
tri = delaunayn(Field_line_theta);
Index.Sys3_equator(counter) = dsearchn(Field_line_theta,tri,0) + a - 1;

Field_line_theta_cent =sorted_lines_1_360.theta_ceq(a:b);
tri = delaunayn(Field_line_theta_cent);
Index.cent_equator_min35(counter) = dsearchn(Field_line_theta_cent,tri,-35) + a - 1;
Index.cent_equator_max35(counter) = dsearchn(Field_line_theta_cent,tri, 35) + a - 1;

end
clear I; clear tri; clear Field_line_theta; clear Field_line_theta_cent; clear a; clear b; clear counter;
progressbar(1)




%Fixing folding field lines...
for counter = 1:3600


if counter < 3600
a = sorted_lines_1_360.mag_eq_index(Index.Line_Index(counter));
b = Index.Line_Index(counter +1) - 1;
end

if counter == 3600
a = sorted_lines_1_360.mag_eq_index(Index.Line_Index(counter));
b = length(sorted_lines_1_360.phi);
end

c = sorted_lines_1_360.r(a:b);
d = sorted_lines_1_360.theta(a:b);
e = sorted_lines_1_360.phi(a:b);


[sorted_lines_1_360.B_Mag(a:b), B_order] = sort(sorted_lines_1_360.B_Mag(a:b));
c = c(B_order,:);
d = d(B_order,:);
e = e(B_order,:);

sorted_lines_1_360.r(a:b) = c;
sorted_lines_1_360.theta(a:b) = d;
sorted_lines_1_360.phi(a:b) = e;

end


clear a; clear b; clear c; clear d; clear e; clear counter; clear progress1; clear B_order;
