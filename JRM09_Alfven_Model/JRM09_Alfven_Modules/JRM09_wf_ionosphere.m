
% In the first two loops I'm computing the "theta" (which is wrong because the
% thetas are sorted in ascending/descending order but the field lines are
% more complicated) associated with the phi of the field line that goes
% through Io.

% In the second two for loops I compute the actual theta and phi on Jupiter
% of the ionosphere


for counter1 = 1:360
    
    if counter1 < 360
        a = characteristic.South.index(counter1);
        b = characteristic.South.index(counter1 +1) - 1;
    end
    if counter1 == 360
        a = characteristic.South.index(counter1);
        b = length(characteristic.South.back.theta); %last value in the list
    end
    
    wf.south_ionosphere(counter1) = min(characteristic.South.there.theta(a:b));
    
end

clear counter1; clear a; clear b;


for counter1 = 1:360
    
    if counter1 < 360
        a = characteristic.North.index(counter1);
        b = characteristic.North.index(counter1 +1) - 1;
    end
    if counter1 == 360
        a = characteristic.North.index(counter1);
        b = length(characteristic.North.there.time); %last value in the list
    end
    
    wf.north_ionosphere(counter1) = max(characteristic.North.there.theta(a:b));
    
    
end

clear counter1; clear a; clear b;
wf.north_ionosphere = wf.north_ionosphere';
wf.south_ionosphere = wf.south_ionosphere';






%%%% Computing the actual ionosphere locations






for counter1 = 1:360
    
    if counter1 < 360
        a = characteristic.South.index(counter1);
        b = characteristic.South.index(counter1 +1) - 1;
    end
    if counter1 == 360
        a = characteristic.South.index(counter1);
        b = length(characteristic.South.back.theta); %last value in the list
    end
    
    phield_line_of_interest = characteristic.South.there.r(a:b);
    [M,I] = min(phield_line_of_interest);
    I = a + I -1;
    wf.south_ionosphere_r(counter1) = characteristic.South.there.r(I);
    wf.south_ionosphere_theta(counter1) = characteristic.South.there.theta(I);
    wf.south_ionosphere_phi(counter1) = characteristic.South.there.phi(I);
    
    
end

clear counter1; clear a; clear b;


for counter1 = 1:360
    
    if counter1 < 360
        a = characteristic.North.index(counter1);
        b = characteristic.North.index(counter1 +1) - 1;
    end
    if counter1 == 360
        a = characteristic.North.index(counter1);
        b = length(characteristic.North.there.time); %last value in the list
    end
    
    
    phield_line_of_interest = characteristic.North.there.r(a:b);
    [M,I] = min(phield_line_of_interest);
    I = a + I -1;
    wf.north_ionosphere_r(counter1) = characteristic.North.there.r(I);
    wf.north_ionosphere_theta(counter1) = characteristic.North.there.theta(I);
    wf.north_ionosphere_phi(counter1) = characteristic.North.there.phi(I);
    
    
end

clear counter1; clear a; clear b;
wf.north_ionosphere_r = wf.north_ionosphere_r';
wf.north_ionosphere_theta = wf.north_ionosphere_theta';
wf.north_ionosphere_phi = wf.north_ionosphere_phi';

wf.south_ionosphere_r = wf.south_ionosphere_r';
wf.south_ionosphere_theta = wf.south_ionosphere_theta';
wf.south_ionosphere_phi = wf.south_ionosphere_phi';

for c = 1:360
    
    if wf.north_ionosphere_phi(c) > 360
        wf.north_ionosphere_phi(c) = wf.north_ionosphere_phi(c) - 360;
    end
    
    if wf.south_ionosphere_phi(c) > 360
        wf.south_ionosphere_phi(c) = wf.north_ionosphere_phi(c) - 360;
    end

    if wf.south_ionosphere_phi(c) < 0
        wf.south_ionosphere_phi(c) = wf.north_ionosphere_phi(c) + 360;
    end
    
end
