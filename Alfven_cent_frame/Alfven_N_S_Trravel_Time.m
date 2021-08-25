progress1 = 0;
progressbar('Computing Travel Times...',0)

Index.Alfven_Travel_Time_North = Index.Line_Index;
Index.Alfven_Travel_Time_North_terminate_35 = Index.Line_Index;
Index.Alfven_Travel_Time_North_speed_of_light = Index.Line_Index;
Index.Alfven_Travel_Time_North_model = Index.Line_Index;



for counter1 = 1:360

if counter1 < 360
a = Index.Line_Index(counter1);
b = Index.Line_Index(counter1 +1) - 1;
end
if counter1 == 360
a = Index.Line_Index(counter1);
b = 373103; %last value in the list
end
Field_line_r = sorted_lines_1_360.r(a:b);
Field_line_theta =sorted_lines_1_360.theta(a:b);
Field_line_V_A = sorted_lines_1_360.Alfven_speed(a:b);
Field_line_V_A_terminate_35 = sorted_lines_1_360.Alfven_speed_terminate_35(a:b);
Field_line_V_A_speed_of_light = sorted_lines_1_360.Alfven_speed_of_light(a:b);
Field_line_V_A_model = sorted_lines_1_360.Alfven_speed_model(a:b);
I = find(Field_line_theta < 0);
Field_line_r(I)=[];
Field_line_theta(I)=[];
Field_line_V_A(I)=[];
Field_line_V_A_terminate_35(I)=[];
Field_line_V_A_speed_of_light(I)=[];
Field_line_V_A_model(I)=[];



Alfven_Travel_Time = 0;
Alfven_Travel_Time_terminate_35 = 0;
Alfven_Travel_Time_speed_of_light = 0;
Alfven_Travel_Time_model = 0;
for counter2 = 2:length(Field_line_r)
    r_i = Field_line_r(counter2-1)*71492;
    r_j = Field_line_r(counter2)*71492;
    theta_i = Field_line_theta(counter2-1);
    theta_j = Field_line_theta(counter2);
    V_A_i = Field_line_V_A(counter2-1);
    V_A_j = Field_line_V_A(counter2);
    V_A = (V_A_i + V_A_j)/2;
    V_A_i_terminate_35 = Field_line_V_A_terminate_35(counter2-1);
    V_A_j_terminate_35 = Field_line_V_A_terminate_35(counter2);
    V_A_terminate_35 = (V_A_i_terminate_35 + V_A_j_terminate_35)/2;
    V_A_i_speed_of_light = Field_line_V_A_speed_of_light(counter2-1);
    V_A_j_speed_of_light = Field_line_V_A_speed_of_light(counter2);
    V_A_speed_of_light = (V_A_i_speed_of_light + V_A_j_speed_of_light)/2;
    V_A_i_model = Field_line_V_A_model(counter2-1);
    V_A_j_model = Field_line_V_A_model(counter2);
    V_A_model = (V_A_i_model + V_A_j_model)/2;
    r = (r_i + r_j)/2;
    theta = (theta_j - theta_i)*(pi/180);
    Arc_length = r*theta;
    Alfven_Travel_Time = Alfven_Travel_Time + Arc_length/V_A;
    Alfven_Travel_Time_speed_of_light = Alfven_Travel_Time_speed_of_light + Arc_length/V_A_speed_of_light;
    Alfven_Travel_Time_model = Alfven_Travel_Time_model + Arc_length/V_A_model;
    if V_A_terminate_35 ~= 0
    Alfven_Travel_Time_terminate_35 = Alfven_Travel_Time_terminate_35 + Arc_length/V_A_terminate_35;
    end

end
Index.Alfven_Travel_Time_North(counter1) = Alfven_Travel_Time;
Index.Alfven_Travel_Time_North_terminate_35(counter1) = Alfven_Travel_Time_terminate_35;
Index.Alfven_Travel_Time_North_speed_of_light(counter1) = Alfven_Travel_Time_speed_of_light;
Index.Alfven_Travel_Time_North_model(counter1) = Alfven_Travel_Time_model;

progressbar([],progress1/720) % Update progress bar
        progress1 = progress1+1;

end

clear a; clear b; clear counter1; clear I; clear Field_line_theta; clear Field_line_r;
clear r_i; clear r_j; clear theta_i; clear theta_j; clear V_A_i; clear V_A_j; clear V_A;
clear r; clear theta; clear Arc_length; clear Alfven_Travel_Time; clear counter2; clear Field_line_V_A;

clear V_A_i_terminate_35; clear V_A_j_terminate_35; clear V_A_terminate_35;
clear Alfven_Travel_Time_terminate_35;clear Field_line_V_A_terminate_35;clear Field_line_V_A_speed_of_light;


%South Alfven Travel Time

Index.Alfven_Travel_Time_South = Index.Line_Index;
Index.Alfven_Travel_Time_South_terminate_35 = Index.Line_Index;
Index.Alfven_Travel_Time_South_speed_of_light = Index.Line_Index;
Index.Alfven_Travel_Time_South_model = Index.Line_Index;
for counter1 = 1:360

if counter1 < 360
a = Index.Line_Index(counter1);
b = Index.Line_Index(counter1 +1) - 1;
end
if counter1 == 360
a = Index.Line_Index(counter1);
b = 373103; %last value in the list
end
Field_line_r = sorted_lines_1_360.r(a:b);
Field_line_theta =sorted_lines_1_360.theta(a:b);
Field_line_V_A = sorted_lines_1_360.Alfven_speed(a:b);
Field_line_V_A_terminate_35 = sorted_lines_1_360.Alfven_speed_terminate_35(a:b);
Field_line_V_A_speed_of_light = sorted_lines_1_360.Alfven_speed_of_light(a:b);
Field_line_V_A_model = sorted_lines_1_360.Alfven_speed_model(a:b);
I = find(Field_line_theta > 0);
Field_line_r(I)=[];
Field_line_theta(I)=[];
Field_line_V_A(I)=[];
Field_line_V_A_terminate_35(I)=[];
Field_line_V_A_speed_of_light(I)=[];



Alfven_Travel_Time = 0;
Alfven_Travel_Time_terminate_35 = 0;
Alfven_Travel_Time_speed_of_light = 0;
Alfven_Travel_Time_model = 0;
for counter2 = 2:length(Field_line_r)
    r_i = Field_line_r(counter2-1)*71492;
    r_j = Field_line_r(counter2)*71492;
    theta_i = Field_line_theta(counter2-1);
    theta_j = Field_line_theta(counter2);
    V_A_i = Field_line_V_A(counter2-1);
    V_A_j = Field_line_V_A(counter2);
    V_A = (V_A_i + V_A_j)/2;
    V_A_i_terminate_35 = Field_line_V_A_terminate_35(counter2-1);
    V_A_j_terminate_35 = Field_line_V_A_terminate_35(counter2);
    V_A_terminate_35 = (V_A_i_terminate_35 + V_A_j_terminate_35)/2;
    V_A_i_speed_of_light = Field_line_V_A_speed_of_light(counter2-1);
    V_A_j_speed_of_light = Field_line_V_A_speed_of_light(counter2);
    V_A_speed_of_light = (V_A_i_speed_of_light + V_A_j_speed_of_light)/2;
    V_A_i_model = Field_line_V_A_model(counter2-1);
    V_A_j_model = Field_line_V_A_model(counter2);
    V_A_model = (V_A_i_model + V_A_j_model)/2;
    r = (r_i + r_j)/2;
    theta = (theta_j - theta_i)*(pi/180);
    Arc_length = r*theta;
    Alfven_Travel_Time = Alfven_Travel_Time + Arc_length/V_A;
    Alfven_Travel_Time_speed_of_light = Alfven_Travel_Time_speed_of_light + Arc_length/V_A_speed_of_light;
    Alfven_Travel_Time_model = Alfven_Travel_Time_model + Arc_length/V_A_model;
    if V_A_terminate_35 ~= 0
    Alfven_Travel_Time_terminate_35 = Alfven_Travel_Time_terminate_35 + Arc_length/V_A_terminate_35;
    end

   
end
Index.Alfven_Travel_Time_South(counter1) = Alfven_Travel_Time;
Index.Alfven_Travel_Time_South_terminate_35(counter1) = Alfven_Travel_Time_terminate_35;
Index.Alfven_Travel_Time_South_speed_of_light(counter1) = Alfven_Travel_Time_speed_of_light;
Index.Alfven_Travel_Time_South_model(counter1) = Alfven_Travel_Time_model;
progressbar([],progress1/720) % Update progress bar
        progress1 = progress1+1;

end

clear a; clear b; clear counter1; clear I; clear Field_line_theta; clear Field_line_r;
clear r_i; clear r_j; clear theta_i; clear theta_j; clear V_A_i; clear V_A_j; clear V_A;
clear r; clear theta; clear Arc_length; clear Alfven_Travel_Time; clear counter2; clear Field_line_V_A;

clear V_A_i_terminate_35; clear V_A_j_terminate_35; clear V_A_terminate_35;
clear Alfven_Travel_Time_terminate_35;clear Field_line_V_A_terminate_35;
clear V_A_i_speed_of_light; clear V_A_j_speed_of_light; clear V_A_speed_of_light;
clear Alfven_Travel_Time_speed_of_light;clear Field_line_V_A_speed_of_light;

clear V_A_i_model; clear V_A_j_model; clear V_A_model;
clear Alfven_Travel_Time_model;clear Field_line_V_A_model;


Index.Alfven_Travel_Time_Total = Index.Alfven_Travel_Time_South+Index.Alfven_Travel_Time_North;
Index.Alfven_Travel_Time_Total_terminate_35 = Index.Alfven_Travel_Time_South_terminate_35+Index.Alfven_Travel_Time_North_terminate_35;
Index.Alfven_Travel_Time_Total_speed_of_light = Index.Alfven_Travel_Time_South_speed_of_light+Index.Alfven_Travel_Time_North_speed_of_light;
Index.Alfven_Travel_Time_Total_model = Index.Alfven_Travel_Time_South_model+Index.Alfven_Travel_Time_North_model;
progressbar(1)

