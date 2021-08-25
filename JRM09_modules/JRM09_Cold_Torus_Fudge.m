load('/Users/pahi9557/Documents/MATLAB/VIP4CAN/Cold_Fudge/Cold_Fudge.mat')

JRM09_nmax_eq.n_max_Oxygen(166:258) = interp1(VIP_Cold_Torus_Fudge.RJ,VIP_Cold_Torus_Fudge.O,JRM09_cent_loc.r(166:258));
JRM09_nmax_eq.n_max_Oxygen1(166:258) = interp1(VIP_Cold_Torus_Fudge.RJ,VIP_Cold_Torus_Fudge.O1,JRM09_cent_loc.r(166:258));
JRM09_nmax_eq.n_max_HotOxygen(166:258) = interp1(VIP_Cold_Torus_Fudge.RJ,VIP_Cold_Torus_Fudge.Ohot,JRM09_cent_loc.r(166:258));
JRM09_nmax_eq.n_max_Sulfur(166:258) = interp1(VIP_Cold_Torus_Fudge.RJ,VIP_Cold_Torus_Fudge.S,JRM09_cent_loc.r(166:258));
JRM09_nmax_eq.n_max_Sulfur1(166:258) = interp1(VIP_Cold_Torus_Fudge.RJ,VIP_Cold_Torus_Fudge.S1,JRM09_cent_loc.r(166:258));
JRM09_nmax_eq.n_max_Sulfur2(166:258) = interp1(VIP_Cold_Torus_Fudge.RJ,VIP_Cold_Torus_Fudge.S2,JRM09_cent_loc.r(166:258));
JRM09_nmax_eq.n_max_Hydrogen(166:258) = interp1(VIP_Cold_Torus_Fudge.RJ,VIP_Cold_Torus_Fudge.H,JRM09_cent_loc.r(166:258));
JRM09_nmax_eq.n_max_Sodium(166:258) = interp1(VIP_Cold_Torus_Fudge.RJ,VIP_Cold_Torus_Fudge.Na,JRM09_cent_loc.r(166:258));
JRM09_nmax_eq.n_max_Electron(166:258) = interp1(VIP_Cold_Torus_Fudge.RJ,VIP_Cold_Torus_Fudge.Ne,JRM09_cent_loc.r(166:258));