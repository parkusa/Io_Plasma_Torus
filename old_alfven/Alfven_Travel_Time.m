
load('/Users/pahi9557/Documents/MATLAB/Alfven_Waves/AW_data_prep/full_field_data_68_158.mat')
Alfven_Travel_Time_68 = 0;

for counter = 250:length(field_line_68.Theta)
    r_i = field_line_68.Radius(counter-1)*71492;
    r_j = field_line_68.Radius(counter)*71492;
    theta_i = field_line_68.Theta(counter-1);
    theta_j = field_line_68.Theta(counter);
    V_A_i = field_line_68.Alfven_speed(counter-1);
    V_A_j = field_line_68.Alfven_speed(counter);
    V_A = (V_A_i + V_A_j)/2;
    r = (r_i + r_j)/2;
    theta = (theta_j - theta_i)*(pi/180);
    Arc_length = r*theta;
    Alfven_Travel_Time_68 = Alfven_Travel_Time_68 + Arc_length/V_A;
end

Alfven_Travel_Time_158 = 0;

for counter = 226:length(field_line_158.Theta)
    r_i = field_line_158.Radius(counter-1)*71492;
    r_j = field_line_158.Radius(counter)*71492;
    theta_i = field_line_158.Theta(counter-1);
    theta_j = field_line_158.Theta(counter);
    V_A_i = field_line_158.Alfven_speed(counter-1);
    V_A_j = field_line_158.Alfven_speed(counter);
    V_A = (V_A_i + V_A_j)/2;
    r = (r_i + r_j)/2;
    theta = (theta_j - theta_i)*(pi/180);
    Arc_length = r*theta;
    Alfven_Travel_Time_158 = Alfven_Travel_Time_158 + Arc_length/V_A;
end