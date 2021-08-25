load('/Users/pahi9557/Documents/MATLAB/Alfven_Waves/AW_data_prep/full_field_data_1_360.mat')

%How I generated the sys3 equator values
% Index.Sys3_equator = 1:359;
% 
% for counter = 1:359
% 
% a = Index.Line_Index(counter);
% b = Index.Line_Index(counter +1) - 1;
% Field_line_r = sorted_lines_1_360.r(a:b);
% Field_line_theta =sorted_lines_1_360.theta(a:b);
% tri = delaunayn(Field_line_theta);
% Index.Sys3_equator(counter) = dsearchn(Field_line_theta,tri,0) + a - 1;
% end


%North travel time


Index.Alfven_Travel_Time_North = Index.Line_Index;
for counter1 = 1:359

if counter1 < 359
a = Index.Line_Index(counter1);
b = Index.Line_Index(counter1 +1) - 1;
end
if counter1 == 359
a = Index.Line_Index(counter1);
b = 178175; %last value in the list
end
Field_line_r = sorted_lines_1_360.r(a:b);
Field_line_theta =sorted_lines_1_360.theta(a:b);
Field_line_V_A = sorted_lines_1_360.Alfven_speed(a:b);
I = find(Field_line_theta < 0);
Field_line_r(I)=[];
Field_line_theta(I)=[];
Field_line_V_A(I)=[];



Alfven_Travel_Time = 0;
for counter2 = 2:length(Field_line_r)
    r_i = Field_line_r(counter2-1)*71492;
    r_j = Field_line_r(counter2)*71492;
    theta_i = Field_line_theta(counter2-1);
    theta_j = Field_line_theta(counter2);
    V_A_i = Field_line_V_A(counter2-1);
    V_A_j = Field_line_V_A(counter2);
    V_A = (V_A_i + V_A_j)/2;
    r = (r_i + r_j)/2;
    theta = (theta_j - theta_i)*(pi/180);
    Arc_length = r*theta;
    Alfven_Travel_Time = Alfven_Travel_Time + Arc_length/V_A;
end
Index.Alfven_Travel_Time_North(counter1) = Alfven_Travel_Time;
end

clear a; clear b; clear counter1; clear I; clear Field_line_theta; clear Field_line_r;
clear r_i; clear r_j; clear theta_i; clear theta_j; clear V_A_i; clear V_A_j; clear V_A;
clear r; clear theta; clear Arc_length; clear Alfven_Travel_Time; clear counter2; clear Field_line_V_A;


%South Alfven Travel Time

Index.Alfven_Travel_Time_South = Index.Line_Index;
for counter1 = 1:359

if counter1 < 359
a = Index.Line_Index(counter1);
b = Index.Line_Index(counter1 +1) - 1;
end
if counter1 == 359
a = Index.Line_Index(counter1);
b = 178175; %last value in the list
end
Field_line_r = sorted_lines_1_360.r(a:b);
Field_line_theta =sorted_lines_1_360.theta(a:b);
Field_line_V_A = sorted_lines_1_360.Alfven_speed(a:b);
I = find(Field_line_theta > 0);
Field_line_r(I)=[];
Field_line_theta(I)=[];
Field_line_V_A(I)=[];



Alfven_Travel_Time = 0;
for counter2 = 2:length(Field_line_r)
    r_i = Field_line_r(counter2-1)*71492;
    r_j = Field_line_r(counter2)*71492;
    theta_i = Field_line_theta(counter2-1);
    theta_j = Field_line_theta(counter2);
    V_A_i = Field_line_V_A(counter2-1);
    V_A_j = Field_line_V_A(counter2);
    V_A = (V_A_i + V_A_j)/2;
    r = (r_i + r_j)/2;
    theta = (theta_j - theta_i)*(pi/180);
    Arc_length = r*theta;
    Alfven_Travel_Time = Alfven_Travel_Time + Arc_length/V_A;
end
Index.Alfven_Travel_Time_South(counter1) = Alfven_Travel_Time;
end

clear a; clear b; clear counter1; clear I; clear Field_line_theta; clear Field_line_r;
clear r_i; clear r_j; clear theta_i; clear theta_j; clear V_A_i; clear V_A_j; clear V_A;
clear r; clear theta; clear Arc_length; clear Alfven_Travel_Time; clear counter2; clear Field_line_V_A;

Index.Alfven_Travel_Time_Total = Index.Alfven_Travel_Time_South+Index.Alfven_Travel_Time_North;
