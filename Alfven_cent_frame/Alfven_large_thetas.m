


%rewriting index as a struct
a = Index;
clear Index;
Index = struct();
Index.Line_Index = a;
clear a;
Index.Sys3_equator = 1:360;
Index.cent_equator_min35 = 1:360;
Index.cent_equator_max35 = 1:360;



sorted_lines_1_360.alpha = asind(sind(9.6)*sind(sorted_lines_1_360.phi-68)); %calculating alpha, difference between mag and spin
sorted_lines_1_360.theta_ceq = sorted_lines_1_360.theta+(2/3)*sorted_lines_1_360.alpha; %calculating cent equator
sorted_lines_1_360.Alfven_speed_terminate_35 = sorted_lines_1_360.Alfven_speed; %setting the speed along the rest of the line = to the speed at theta = 35
sorted_lines_1_360.Alfven_speed_of_light = sorted_lines_1_360.Alfven_speed; %setting the speed along the rest of the line = c
sorted_lines_1_360.Alfven_speed_model = sorted_lines_1_360.Alfven_speed; %just keeping the model calculated values and imposing speed limit = c


I = find(sorted_lines_1_360.Alfven_speed_model > 300000);
sorted_lines_1_360.Alfven_speed_model(I) = 300000;
clear I


%calculating the system 3 equator in order to compute North and South
%travel times, also, if theta_cent exceeds +/- 35, setting the alfven speed
%to the speed at +/- 35
for counter = 1:360

if counter < 360
a = Index.Line_Index(counter);
b = Index.Line_Index(counter +1) - 1;
end

if counter == 360
b = 373103;
end

Field_line_theta = sorted_lines_1_360.theta(a:b);
tri = delaunayn(Field_line_theta);
Index.Sys3_equator(counter) = dsearchn(Field_line_theta,tri,0) + a - 1;

Field_line_theta_cent =sorted_lines_1_360.theta_ceq(a:b);
tri = delaunayn(Field_line_theta_cent);
Index.cent_equator_min35(counter) = dsearchn(Field_line_theta_cent,tri,-35) + a - 1;
Index.cent_equator_max35(counter) = dsearchn(Field_line_theta_cent,tri, 35) + a - 1;

I = find(Field_line_theta_cent < -35)+ a - 1;
sorted_lines_1_360.Alfven_speed(I)=sorted_lines_1_360.Alfven_speed(Index.cent_equator_min35(counter));
sorted_lines_1_360.Alfven_speed_terminate_35(I) = 0;
sorted_lines_1_360.Alfven_speed_of_light(I) = 300000;

I = find(Field_line_theta_cent > 35)+ a - 1;
sorted_lines_1_360.Alfven_speed(I)=sorted_lines_1_360.Alfven_speed(Index.cent_equator_max35(counter));
sorted_lines_1_360.Alfven_speed_terminate_35(I) = 0;
sorted_lines_1_360.Alfven_speed_of_light(I) = 300000;


end


clear I; clear tri; clear Field_line_theta; clear Field_line_theta_cent; clear a; clear b; clear counter;

