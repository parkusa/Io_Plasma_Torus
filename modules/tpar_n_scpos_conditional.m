%Based on the iteration of the for loop, decides which species temperature
%and density is to be considered. Defines tpar and n_scpos.

%This is a module specifically desgined for my n_max code

if ii == 1
    tpar = OTemperature(counter);
    n_scpos = ODensity(counter);
end

if ii == 2
    tpar = OTemperature1(counter);
    n_scpos = ODensity1(counter);
end

if ii == 3
    tpar = HotOTemperature(counter);
    n_scpos = HotODensity(counter);
end

if ii == 4
    tpar = STemperature(counter);
    n_scpos = SDensity(counter);
end

if ii == 5
    tpar = STemperature1(counter);
    n_scpos = SDensity1(counter);
end

if ii == 6
    tpar = STemperature2(counter);
    n_scpos = SDensity2(counter);
end

if ii == 7
    tpar = HTemperature(counter);
    n_scpos = HDensity(counter);
end

if ii == 8
    tpar = NaTemperature(counter);
    n_scpos = NaDensity(counter);
end