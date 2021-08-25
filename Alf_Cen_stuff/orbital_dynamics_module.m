%_____________________________________________________________________

%the real elements of an orbit are...

% P : the revolution period in years; alternativley the mean motion
% T : the time passage through periastron
% e : the numerical eccentricity of the orbit, the auxilary angle phi is arcsin(e)
% a : the semi-major axis in arseconds

%The apparent orbit results from a projection of the true orbit onto the
%celestial sphere, three more elements arise in this projection

% Omega (uppercase) : the position angle of the ascending node

% i : the orbital inclination, this is the angle between the plane of
% projection and the true orbital plane

% omega (lowercase) : the arguement of periastron. This is the angle
% between the node and the periastron.

%These 7 elements are called the Campbell elements.
%Thiele_Innes elements use Campbell's to to calculate rectangular
%coordinates:

% A = a(cos(omega)cos(Omega) - sin(omega)sin(Omega)cos(i)
% B = a(cos(omega)sin(Omega) + sin(omega)cos(Omega)cos(i)

% F = a(-sin(omega)cos(Omega) - cos(omega)sin(Omega)cos(i)
% G = a(-sin(omega)sin(Omega) + cos(omega)cos(Omega)cos(i)

%_____________________________________________________________________

%These Campbell elements taken exactly from:
%from https://www.aanda.org/articles/aa/abs/2016/02/aa27859-15/aa27859-15.html
%"Parallax and masses of \alpha Centauri revisted", jan 4 2016, Dimitri
%Pourbaix and Henri M.J. Boffin

P = 79.91;
T = 1955.66;
e = 0.524;
a = 17.66;
Omega = 204.75;
i = 79.32;
omega = 232.3;


A = a*(cosd(omega)*cosd(Omega) - sind(omega)*sind(Omega)*cosd(i));
B = a*(cosd(omega)*sind(Omega) + sind(omega)*cosd(Omega)*cosd(i));

F = a*(-sind(omega)*cosd(Omega) - cosd(omega)*sind(Omega)*cosd(i));
G = a*(-sind(omega)*sind(Omega) + cosd(omega)*cosd(Omega)*cosd(i));


mu = 2*pi/P; % https://en.wikipedia.org/wiki/Mean_motion
t = timestamp; % year of interest, defined outside of this module!!!!
M = mu*(t-T);
M_i = M;
E_i = M + e*sin(M) + e^2/M*sin(2*M);
for iteration = 1:100
M_j = E_i - e*sin(E_i);
E_j = E_i + (M - M_j)/(1 - e*cos(E_i));

E_i = E_j;
end


X = cos(E_i) - e; Y = (1 - e^2)^(0.5)*sin(E_i);
x = A*X + F*Y; y = B*X + G*Y;
x = x*0.0002778;y = y*0.0002778;%convert from arcs to deg

%Alf_Cen_B.propagated.RA/DEC this is defined outside of the loop
orb_dy_B_RA = Alf_Cen_A.propagated.RA+y;
orb_dy_B_DEC = Alf_Cen_A.propagated.DEC+x;















