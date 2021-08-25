%This module applies the sys 3 variation found in A. Steffl's papers to our
%obtained data to calculate their values "independent of longitude". The
%Longitudinal variation will be re-added in one fowl sweep later in the
%JRM09_Cassini_UVIS_variation module


%note, I'm not messing with charge density here, so after running this
%module electron densities for the radial profiles will be off. However,
%my torus code re calculates electron density during lat dist (N_max)
%so it's okay


%loading the relative variations
%for further explanation of the following block of code see:
%Relative_variation_plots.m
c = 1 ;  % constant offest
lambda = linspace(0,360,361); %system 3 longitude
lambda = lambda'; % change from column vector to row vector (transpose)
A = 0.19; %Amplitude of variation
phi = 150; %phase of the variation
S_variation = mixing_ratio(A,lambda,phi,c); %generating sinusoid
A = 0.28; %Amplitude of variation
phi = 330; %phase of the variation
S2_variation = mixing_ratio(A,lambda,phi,c); %generating sinusoid
clear A; clear phi; clear c;


Mfactor_S = interp1(lambda,S_variation,Phi); %generating the
%multiplication factors for each point
Mfactor_S2= interp1(lambda,S2_variation,Phi); %generating the
%multiplication factors for each point
SDensity = SDensity./Mfactor_S;
SDensity2 = SDensity2./Mfactor_S2;

clear Mfactor_S2; clear Mfactor_S; clear lambda;