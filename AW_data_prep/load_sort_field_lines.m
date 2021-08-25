load('/Users/pahi9557/Documents/MATLAB/Alfven_Waves/AW_data_prep/filed_lines_68_158.mat')

field_line_68.x = field_line_68.Radius.*sind(field_line_68.Theta).*cosd(field_line_68.Phi);
field_line_68.y = field_line_68.Radius.*sind(field_line_68.Theta).*sind(field_line_68.Phi);
field_line_68.z = field_line_68.Radius.*cosd(field_line_68.Theta);


field_line_158.x = field_line_158.Radius.*sind(field_line_158.Theta).*cosd(field_line_158.Phi);
field_line_158.y = field_line_158.Radius.*sind(field_line_158.Theta).*sind(field_line_158.Phi);
field_line_158.z = field_line_158.Radius.*cosd(field_line_158.Theta);


field_line_68.Theta = 90 - field_line_68.Theta;
field_line_158.Theta = 90 - field_line_158.Theta;


I = find(field_line_68.Theta > 35);
field_line_68.flag1(I)=[];
field_line_68.Radius(I)=[];
field_line_68.Theta(I)=[];
field_line_68.Phi(I)=[];
field_line_68.x(I)=[];
field_line_68.y(I)=[];
field_line_68.z(I)=[];


I = find(field_line_68.Theta < -35);

field_line_68.flag1(I)=[];
field_line_68.Radius(I)=[];
field_line_68.Theta(I)=[];
field_line_68.Phi(I)=[];
field_line_68.x(I)=[];
field_line_68.y(I)=[];
field_line_68.z(I)=[];


I = find(field_line_158.Theta > 35);
field_line_158.flag1(I)=[];
field_line_158.Radius(I)=[];
field_line_158.Theta(I)=[];
field_line_158.Phi(I)=[];
field_line_158.x(I)=[];
field_line_158.y(I)=[];
field_line_158.z(I)=[];


I = find(field_line_158.Theta < -35);

field_line_158.flag1(I)=[];
field_line_158.Radius(I)=[];
field_line_158.Theta(I)=[];
field_line_158.Phi(I)=[];
field_line_158.x(I)=[];
field_line_158.y(I)=[];
field_line_158.z(I)=[];



[field_line_68.Theta, a_order] = sort(field_line_68.Theta);

field_line_68.flag1 = field_line_68.flag1(a_order,:);
field_line_68.Radius = field_line_68.Radius(a_order,:);
field_line_68.Phi = field_line_68.Phi(a_order,:);
field_line_68.x = field_line_68.x(a_order,:);
field_line_68.y = field_line_68.y(a_order,:);
field_line_68.z = field_line_68.z(a_order,:);



[field_line_158.Theta, a_order] = sort(field_line_158.Theta);

field_line_158.flag1 = field_line_158.flag1(a_order,:);
field_line_158.Radius = field_line_158.Radius(a_order,:);
field_line_158.Phi = field_line_158.Phi(a_order,:);
field_line_158.x = field_line_158.x(a_order,:);
field_line_158.y = field_line_158.y(a_order,:);
field_line_158.z = field_line_158.z(a_order,:);





field_line_68.flag1(69) = [];
field_line_68.Theta(69) = [];
field_line_68.Radius(69) = [];
field_line_68.Phi(69) = [];
field_line_68.x(69) = [];
field_line_68.y(69) = [];
field_line_68.z(69) = [];


clear a_order;
clear I;

