%This module also produces the charcteristic "there" values.



B_sys_3_equator = sorted_lines_1_360.B_Mag(Index.Sys3_equator);

characteristic = struct();



characteristic.North.there.time = ones(8e6,1);
characteristic.South.there.time = ones(8e6,1);
characteristic.North.back.time = ones(8e6,1);
characteristic.South.back.time = ones(8e6,1);
characteristic.North.there.theta = ones(8e6,1);
characteristic.North.back.theta = ones(8e6,1);
characteristic.South.there.theta = ones(8e6,1);
characteristic.South.back.theta = ones(8e6,1);
characteristic.North.there.phi = ones(8e6,1);
characteristic.North.back.phi = ones(8e6,1);
characteristic.South.there.phi = ones(8e6,1);
characteristic.South.back.phi = ones(8e6,1);
characteristic.North.there.r = ones(8e6,1);
characteristic.North.back.r = ones(8e6,1);
characteristic.South.there.r = ones(8e6,1);
characteristic.South.back.r = ones(8e6,1);
characteristic.North.there.B = ones(8e6,1);
characteristic.North.back.B = ones(8e6,1);
characteristic.South.there.B = ones(8e6,1);
characteristic.South.back.B = ones(8e6,1);



characteristic.North.there.time(1) = 0;
characteristic.South.there.time(1) = 0;
characteristic.North.back.time(1) = 0;
characteristic.South.back.time(1) = 0;
characteristic.North.there.theta(1) = 0;
characteristic.North.back.theta(1) = 0;
characteristic.South.there.theta(1) = 0;
characteristic.South.back.theta(1) = 0;
characteristic.North.there.phi(1) = 1;
characteristic.North.back.phi(1) = 1;
characteristic.South.there.phi(1) = 1;
characteristic.South.back.phi(1) = 1;
characteristic.North.there.r(1) = 6;
characteristic.North.back.r(1) = 6;
characteristic.South.there.r(1) = 6;
characteristic.South.back.r(1) = 6;
characteristic.North.there.B(1) = B_sys_3_equator(3600);
characteristic.North.back.B(1) = B_sys_3_equator(3600);
characteristic.South.there.B(1) = B_sys_3_equator(3600);
characteristic.South.back.B(1) = B_sys_3_equator(3600);

progress1 = 0;
progressbar('Computing Travel Times...',0)

Index.Alfven_Travel_Time_North = Index.Line_Index;
Index.Alfven_Travel_Time_North_upper = Index.Line_Index;
Index.Alfven_Travel_Time_North_lower = Index.Line_Index;

cnt = 1;

%North Alfven Travel Time
for counter1 = 1:3600

if counter1 < 3600
a = Index.Line_Index(counter1);
b = Index.Line_Index(counter1 +1) - 1;
end
if counter1 == 3600
a = Index.Line_Index(counter1);
b = length(sorted_lines_1_360.phi); %last value in the list
end
Field_line_phi = sorted_lines_1_360.phi(a:b);
Field_line_r = sorted_lines_1_360.r(a:b);
Field_line_theta =sorted_lines_1_360.theta(a:b);
Field_line_B =sorted_lines_1_360.B_Mag(a:b);
Field_line_V_A = sorted_lines_1_360.Alfven_speed(a:b);
Field_line_V_A_upper = sorted_lines_1_360.Alfven_speed_upper(a:b);
Field_line_V_A_lower = sorted_lines_1_360.Alfven_speed_lower(a:b);
I = find(Field_line_theta < 0);
Field_line_phi(I)=[];
Field_line_r(I)=[];
Field_line_B(I)=[];
Field_line_theta(I)=[];
Field_line_V_A(I)=[];
Field_line_V_A_upper(I)=[];
Field_line_V_A_lower(I)=[];



Alfven_Travel_Time = 0;
Alfven_Travel_Time_upper = 0;
Alfven_Travel_Time_lower = 0;

for counter2 = 2:length(Field_line_r)
    r_i = Field_line_r(counter2-1)*71492;
    r_j = Field_line_r(counter2)*71492;
    theta_i = Field_line_theta(counter2-1);
    theta_j = Field_line_theta(counter2);
    V_A_i = Field_line_V_A(counter2-1);
    V_A_j = Field_line_V_A(counter2);
    V_A = (V_A_i + V_A_j)/2;
    V_A_i_upper = Field_line_V_A_upper(counter2-1);
    V_A_j_upper = Field_line_V_A_upper(counter2);
    V_A_upper = (V_A_i_upper + V_A_j_upper)/2;
    V_A_i_lower = Field_line_V_A_lower(counter2-1);
    V_A_j_lower = Field_line_V_A_lower(counter2);
    V_A_lower = (V_A_i_lower + V_A_j_lower)/2;
    r = (r_i + r_j)/2;
    theta = (theta_j - theta_i)*(pi/180);
    Arc_length = r*theta;
    Alfven_Travel_Time = Alfven_Travel_Time + Arc_length/V_A;
    Alfven_Travel_Time_upper = Alfven_Travel_Time_upper + Arc_length/V_A_upper;
    Alfven_Travel_Time_lower = Alfven_Travel_Time_lower + Arc_length/V_A_lower;

    cnt = cnt +1;

    characteristic.North.there.time(cnt) = Alfven_Travel_Time;
    characteristic.North.there.theta(cnt) = theta_j;
    characteristic.North.there.r(cnt) = Field_line_r(counter2);
    characteristic.North.there.phi(cnt) = Field_line_phi(counter2);
    characteristic.North.there.B(cnt) = Field_line_B(counter2);
end

cnt = cnt +1;

characteristic.North.there.B(cnt) = B_sys_3_equator(counter1);
characteristic.North.there.r(cnt) = 6;
characteristic.North.there.phi(cnt) = (counter1-1)/10;
characteristic.North.there.time(cnt) = 0;
characteristic.North.there.theta(cnt) = 0;

Index.Alfven_Travel_Time_North(counter1) = Alfven_Travel_Time;
Index.Alfven_Travel_Time_North_upper(counter1) = Alfven_Travel_Time_upper;
Index.Alfven_Travel_Time_North_lower(counter1) = Alfven_Travel_Time_lower;


progressbar([],progress1/7200) % Update progress bar
        progress1 = progress1+1;

end



characteristic.North.there.time = characteristic.North.there.time(1:cnt);
characteristic.North.back.time = characteristic.North.back.time(1:cnt);
characteristic.North.there.theta = characteristic.North.there.theta(1:cnt);
characteristic.North.back.theta = characteristic.North.back.theta(1:cnt);
characteristic.North.there.phi = characteristic.North.there.phi(1:cnt);
characteristic.North.back.phi = characteristic.North.back.phi(1:cnt);
characteristic.North.there.r = characteristic.North.there.r(1:cnt);
characteristic.North.back.r = characteristic.North.back.r(1:cnt);
characteristic.North.there.B = characteristic.North.there.B(1:cnt);
characteristic.North.back.B = characteristic.North.back.B(1:cnt);





clear a; clear b; clear counter1; clear I; clear Field_line_theta; clear Field_line_r;clear Field_line_B;
clear r_i; clear r_j; clear theta_i; clear theta_j; clear V_A_i; clear V_A_j; clear V_A;
clear r; clear theta; clear Arc_length; clear Alfven_Travel_Time; clear counter2; clear Field_line_V_A;




%South Alfven Travel Time

Index.Alfven_Travel_Time_South = Index.Line_Index;
Index.Alfven_Travel_Time_South_upper = Index.Line_Index;
Index.Alfven_Travel_Time_South_lower = Index.Line_Index;

cnt = 1;

for counter1 = 1:3600

if counter1 < 3600
a = Index.Line_Index(counter1);
b = Index.Line_Index(counter1 +1) - 1;
end
if counter1 == 3600
a = Index.Line_Index(counter1);
b = length(sorted_lines_1_360.phi); %last value in the list
end
Field_line_phi = wrev(sorted_lines_1_360.phi(a:b));
Field_line_r = wrev(sorted_lines_1_360.r(a:b));
Field_line_B = wrev(sorted_lines_1_360.B_Mag(a:b));
Field_line_theta = wrev(sorted_lines_1_360.theta(a:b));
Field_line_V_A = wrev(sorted_lines_1_360.Alfven_speed(a:b));
Field_line_V_A_upper = wrev(sorted_lines_1_360.Alfven_speed_upper(a:b));
Field_line_V_A_lower = wrev(sorted_lines_1_360.Alfven_speed_lower(a:b));
I = find(Field_line_theta > 0);
Field_line_r(I)=[];
Field_line_B(I)=[];
Field_line_phi(I)=[];
Field_line_theta(I)=[];
Field_line_V_A(I)=[];
Field_line_V_A_upper(I)=[];
Field_line_V_A_lower(I)=[];



Alfven_Travel_Time = 0;
Alfven_Travel_Time_upper = 0;
Alfven_Travel_Time_lower = 0;
for counter2 = 2:length(Field_line_r)
    r_i = Field_line_r(counter2-1)*71492;
    r_j = Field_line_r(counter2)*71492;
    theta_i = Field_line_theta(counter2-1);
    theta_j = Field_line_theta(counter2);
    V_A_i = Field_line_V_A(counter2-1);
    V_A_j = Field_line_V_A(counter2);
    V_A = (V_A_i + V_A_j)/2;
    V_A_i_upper = Field_line_V_A_upper(counter2-1);
    V_A_j_upper = Field_line_V_A_upper(counter2);
    V_A_upper = (V_A_i_upper + V_A_j_upper)/2;
    V_A_i_lower = Field_line_V_A_lower(counter2-1);
    V_A_j_lower = Field_line_V_A_lower(counter2);
    V_A_lower = (V_A_i_lower + V_A_j_lower)/2;
    r = (r_i + r_j)/2;
    theta = (theta_j - theta_i)*(pi/180);
    Arc_length = abs(r*theta);
    Alfven_Travel_Time = Alfven_Travel_Time + Arc_length/V_A;
    Alfven_Travel_Time_upper = Alfven_Travel_Time_upper + Arc_length/V_A_upper;
    Alfven_Travel_Time_lower = Alfven_Travel_Time_lower + Arc_length/V_A_lower;


    cnt = cnt +1;

    characteristic.South.there.time(cnt) = Alfven_Travel_Time;
    characteristic.South.there.theta(cnt) = theta_j;
    characteristic.South.there.r(cnt) = Field_line_r(counter2);
    characteristic.South.there.phi(cnt) = Field_line_phi(counter2);
    characteristic.South.there.B(cnt) = Field_line_B(counter2);
end

cnt = cnt +1;

characteristic.South.there.B(cnt) = B_sys_3_equator(counter1);
characteristic.South.there.r(cnt) = 6;
characteristic.South.there.phi(cnt) = (counter1-1)/10;
characteristic.South.there.time(cnt) = 0;
characteristic.South.there.theta(cnt) = 0;

Index.Alfven_Travel_Time_South(counter1) = Alfven_Travel_Time;
Index.Alfven_Travel_Time_South_upper(counter1) = Alfven_Travel_Time_upper;
Index.Alfven_Travel_Time_South_lower(counter1) = Alfven_Travel_Time_lower;
progressbar([],progress1/7200) % Update progress bar
        progress1 = progress1+1;

end

characteristic.South.there.time = characteristic.South.there.time(1:cnt);
characteristic.South.back.time = characteristic.South.back.time(1:cnt);
characteristic.South.there.theta = characteristic.South.there.theta(1:cnt);
characteristic.South.back.theta = characteristic.South.back.theta(1:cnt);
characteristic.South.there.phi = characteristic.South.there.phi(1:cnt);
characteristic.South.back.phi = characteristic.South.back.phi(1:cnt);
characteristic.South.there.r = characteristic.South.there.r(1:cnt);
characteristic.South.back.r = characteristic.South.back.r(1:cnt);
characteristic.South.there.B = characteristic.South.there.B(1:cnt);
characteristic.South.back.B = characteristic.South.back.B(1:cnt);

clear a; clear b; clear counter1; clear I; clear Field_line_theta; clear Field_line_r;
clear r_i; clear r_j; clear theta_i; clear theta_j; clear V_A_i; clear V_A_j; clear V_A;
clear r; clear theta; clear Arc_length; clear Alfven_Travel_Time; clear counter2; clear Field_line_V_A;

clear V_A_i_terminate_35; clear V_A_j_terminate_35; clear V_A_terminate_35;
clear Alfven_Travel_Time_terminate_35;clear Field_line_V_A_terminate_35;
clear V_A_i_speed_of_light; clear V_A_j_speed_of_light; clear V_A_speed_of_light;
clear Alfven_Travel_Time_speed_of_light;clear Field_line_V_A_speed_of_light;

clear V_A_i_model; clear V_A_j_model; clear V_A_model;
clear Alfven_Travel_Time_model;clear Field_line_V_A_model;

clear cnt;


Index.Alfven_Travel_Time_Total = Index.Alfven_Travel_Time_South+Index.Alfven_Travel_Time_North;
Index.Alfven_Travel_Time_Total_upper = Index.Alfven_Travel_Time_South_upper+Index.Alfven_Travel_Time_North_upper;
Index.Alfven_Travel_Time_Total_lower = Index.Alfven_Travel_Time_South_lower+Index.Alfven_Travel_Time_North_lower;

progressbar(1)

characteristic.North.there.time = characteristic.North.there.time';
characteristic.South.there.time = characteristic.South.there.time';
characteristic.North.there.theta = characteristic.North.there.theta';
characteristic.South.there.theta = characteristic.South.there.theta';
characteristic.North.there.r = characteristic.North.there.r';
characteristic.South.there.r = characteristic.South.there.r';
characteristic.North.there.B = characteristic.North.there.B';
characteristic.South.there.B = characteristic.South.there.B';
characteristic.North.there.phi = characteristic.North.there.phi';
characteristic.South.there.phi = characteristic.South.there.phi';

characteristic.North.there.time(length(characteristic.North.there.time)) = [];
characteristic.South.there.time(length(characteristic.South.there.time)) = [];
characteristic.North.there.theta(length(characteristic.North.there.theta)) = [];
characteristic.South.there.theta(length(characteristic.South.there.theta)) = [];
characteristic.North.there.r(length(characteristic.North.there.r)) = [];
characteristic.South.there.r(length(characteristic.South.there.r)) = [];
characteristic.North.there.B(length(characteristic.North.there.B)) = [];
characteristic.South.there.B(length(characteristic.South.there.B)) = [];
characteristic.North.there.phi(length(characteristic.North.there.phi)) = [];
characteristic.South.there.phi(length(characteristic.South.there.phi)) = [];

characteristic.North.back.time(length(characteristic.North.back.time)) = [];
characteristic.South.back.time(length(characteristic.South.back.time)) = [];
characteristic.North.back.theta(length(characteristic.North.back.theta)) = [];
characteristic.South.back.theta(length(characteristic.South.back.theta)) = [];
characteristic.North.back.r(length(characteristic.North.back.r)) = [];
characteristic.South.back.r(length(characteristic.South.back.r)) = [];
characteristic.North.back.B(length(characteristic.North.back.B)) = [];
characteristic.South.back.B(length(characteristic.South.back.B)) = [];
characteristic.North.back.phi(length(characteristic.North.back.phi)) = [];
characteristic.South.back.phi(length(characteristic.South.back.phi)) = [];