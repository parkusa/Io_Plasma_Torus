
% Here I'm computing the ionosphere's sys3 theta associated
% with each field line. Just, where does each field line reach Jupiter? 


%starting with the south lines, saving the last value of each "there" list
%of thetas
for counter1 = 1:3600
    
    if counter1 < 3600
        a = characteristic.South.index(counter1);
        b = characteristic.South.index(counter1 +1) - 1;
    end
    if counter1 == 3600
        a = characteristic.South.index(counter1);
        b = length(characteristic.South.back.theta); %last value in the list
    end
    z = characteristic.South.there.theta(a:b);
    wf.south_ionosphere(counter1) = z(length(z));
    
end

clear counter1; clear a; clear b; clear z;

%repeat for the north
for counter1 = 1:3600
    
    if counter1 < 3600
        a = characteristic.North.index(counter1);
        b = characteristic.North.index(counter1 +1) - 1;
    end
    if counter1 == 3600
        a = characteristic.North.index(counter1);
        b = length(characteristic.North.there.time); %last value in the list
    end
    z = characteristic.North.there.theta(a:b);
    wf.north_ionosphere(counter1) = z(length(z));
    
end

clear counter1; clear a; clear b; clear z;
wf.north_ionosphere = wf.north_ionosphere';
wf.south_ionosphere = wf.south_ionosphere';






%%%% Computing the actual ionosphere locations

% Now I compute the actual theta and phi on Jupiter
% of the ionosphere.  


%starting with the south
for counter1 = 1:3600
    
    if counter1 < 3600
        a = characteristic.South.index(counter1);
        b = characteristic.South.index(counter1 +1) - 1;
    end
    if counter1 == 3600
        a = characteristic.South.index(counter1);
        b = length(characteristic.South.back.theta); %last value in the list
    end
    
    phield_line_of_interest = characteristic.South.there.r(a:b); % all b field
    %values along field line
    [M,I] = min(phield_line_of_interest); %index of greatest one in list
    I = a + I -1; %index of that value amongst all field lines
    
    %saving that location on the ionosphere
    wf.south_ionosphere_r(counter1) = characteristic.South.there.r(I);
    wf.south_ionosphere_theta(counter1) = characteristic.South.there.theta(I);
    wf.south_ionosphere_phi(counter1) = characteristic.South.there.phi(I);
    
    
end

clear counter1; clear a; clear b;

%repeat for north
for counter1 = 1:3600
    
    if counter1 < 3600
        a = characteristic.North.index(counter1);
        b = characteristic.North.index(counter1 +1) - 1;
    end
    if counter1 == 3600
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

%transposing everything
wf.north_ionosphere_r = wf.north_ionosphere_r';
wf.north_ionosphere_theta = wf.north_ionosphere_theta';
wf.north_ionosphere_phi = wf.north_ionosphere_phi';
wf.south_ionosphere_r = wf.south_ionosphere_r';
wf.south_ionosphere_theta = wf.south_ionosphere_theta';
wf.south_ionosphere_phi = wf.south_ionosphere_phi';


%forcing all longitudes to be equal to or between 0 and 359.9
for c = 1:3600
    
    if wf.north_ionosphere_phi(c) > 360
        wf.north_ionosphere_phi(c) = wf.north_ionosphere_phi(c) - 360;
    end
    
    if wf.south_ionosphere_phi(c) > 360
        wf.south_ionosphere_phi(c) = wf.north_ionosphere_phi(c) - 360;
    end
    
    if wf.south_ionosphere_phi(c) < 0
        wf.south_ionosphere_phi(c) = wf.south_ionosphere_phi(c) + 360;
    end
    
    if wf.north_ionosphere_phi(c) < 0
        wf.north_ionosphere_phi(c) = wf.north_ionosphere_phi(c) + 360;
    end
    
end
