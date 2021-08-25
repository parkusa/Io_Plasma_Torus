%this module computes the three characteristic times/distances for the
%wavefront model

characteristic.North_time = Index.Alfven_Travel_Time_North*2;
characteristic.South_time = Index.Alfven_Travel_Time_South*2;

%convert to minutes
characteristic.North_time = characteristic.North_time/60;
characteristic.South_time = characteristic.South_time/60;

characteristic.North_distance = characteristic.North_time*0.6; %0.6 is prob dist/time or something.
characteristic.South_distance = characteristic.South_time*0.6;


%d1 is the shorter time from Io to Jupiter
%d2 is the longer  time from Io to Jupiter

%This "time" is how long it takes an Alfven wave to propogate either north
%or south from Io to Jupiter

%d3 is the addition of d1 and d2. These are the three characteristic times


%This loop assigns, for each longitude, d1 and d2 to either North or South
for counter = 1:360
    if characteristic.North_distance(counter) < characteristic.South_distance
        d1 = characteristic.North_distance(counter);
        d2 = characteristic.South_distance(counter);
    else
        d2 = characteristic.North_distance(counter);
        d1 = characteristic.South_distance(counter);
    end
    d3 = d1+d2;
    
    characteristic.d1(counter) = d1;
    characteristic.d2(counter) = d2;
    characteristic.d3(counter) = d3;
end
%transposing
characteristic.d1 = characteristic.d1';
characteristic.d2 = characteristic.d2';
characteristic.d3 = characteristic.d3';


characteristic.North.index = find(characteristic.North.there.time==0);

%preparing north back times from north there times
for counter1 = 1:360
    
    if counter1 < 360
        a = characteristic.North.index(counter1);
        b = characteristic.North.index(counter1 +1) - 1;
    end
    if counter1 == 360
        a = characteristic.North.index(counter1);
        b = length(characteristic.North.there.theta); %last value in the list
    end
    
    characteristic.North.back.theta(a:b) = wrev(characteristic.North.there.theta(a:b));
    characteristic.North.back.r(a:b) = wrev(characteristic.North.there.r(a:b));
    characteristic.North.back.B(a:b) = wrev(characteristic.North.there.B(a:b));
    characteristic.North.back.phi(a:b) = wrev(characteristic.North.there.phi(a:b));

end


characteristic.South.index = find(characteristic.South.there.time==0);

%dealing with "edges" of field lines. This will introduce infinitesimal
%error to results

characteristic.South.there.theta(1) = [];
characteristic.South.there.theta(length(characteristic.South.there.theta)+1) = 0;

characteristic.South.there.r(1) = [];
characteristic.South.there.r(length(characteristic.South.there.r)+1) = 6;

characteristic.South.there.B(1) = [];
characteristic.South.there.B(length(characteristic.South.there.B)+1) = B_sys_3_equator(359);

characteristic.South.there.phi(characteristic.South.index) = characteristic.South.there.phi(characteristic.South.index) - 1;
characteristic.South.there.phi(1) = [];
characteristic.South.there.phi=characteristic.South.there.phi';
characteristic.South.there.phi = [characteristic.South.there.phi 359];
characteristic.South.there.phi=characteristic.South.there.phi';

characteristic.South.back.time = characteristic.South.there.time;
characteristic.South.back.r = characteristic.South.there.r;
characteristic.South.back.B = characteristic.South.there.B;
characteristic.South.back.theta = characteristic.South.there.theta;
characteristic.South.back.phi = characteristic.South.there.phi;


%preparing south there times from south times

for counter1 = 1:360
    
    if counter1 < 360
        a = characteristic.South.index(counter1);
        b = characteristic.South.index(counter1 +1) - 1;
    end
    if counter1 == 360
        a = characteristic.South.index(counter1);
        b = length(characteristic.South.back.theta); %last value in the list
    end
    
    characteristic.South.there.theta(a:b) = wrev(characteristic.South.back.theta(a:b));
    characteristic.South.there.r(a:b) = wrev(characteristic.South.back.r(a:b));
    characteristic.South.there.B(a:b) = wrev(characteristic.South.back.B(a:b));
    characteristic.South.there.phi(a:b) = wrev(characteristic.South.back.phi(a:b));
    
end
clear counter1; clear counter; clear a; clear b;
characteristic.North.back.theta = characteristic.North.back.theta';
characteristic.North.back.r = characteristic.North.back.r';
characteristic.North.back.B = characteristic.North.back.B';
characteristic.North.back.phi = characteristic.North.back.phi';



clear characteristic.South.there.time;
characteristic.South.there.time = 0;
characteristic.South.there.time = [characteristic.South.there.time 0];

temp_time = 0;



progress1 = 0;
progressbar('Computing There and Back Times...',0)


for counter1 = 1:360
    
    if counter1 < 360
        a = characteristic.South.index(counter1);
        b = characteristic.South.index(counter1 +1) - 1;
    end
    if counter1 == 360
        a = characteristic.South.index(counter1);
        b = length(characteristic.South.back.time); %last value in the list
    end
    
    for counter2 = 2:length(characteristic.South.back.time(a:b))
        if counter2 ~= length(characteristic.South.back.time(a:b))
            c1 = characteristic.South.back.time(b - counter2);
            c2 = characteristic.South.back.time(b - counter2 +1);
            temp_time = temp_time + (c2 - c1);
            characteristic.South.there.time = [characteristic.South.there.time temp_time];
        else
            c2 = characteristic.South.back.time(b);
            c1 = temp_time;
            characteristic.South.there.time((a+1):b)=characteristic.South.there.time((a+1):b)+(c2-c1);
            temp_time = 0;
        end
        
        
        
    end
    characteristic.South.there.time = [characteristic.South.there.time 0];
    characteristic.South.there.time = [characteristic.South.there.time 0];
    
    progressbar([],progress1/720) % Update progress bar
    progress1 = progress1+1;
    
    
end
characteristic.South.there.time(length(characteristic.South.there.time)) = [];
characteristic.South.there.time(length(characteristic.South.there.time)) = [];
clear c1; clear c2; clear temp_time;clear counter1; clear counter; clear a; clear b;
characteristic.South.there.time = characteristic.South.there.time';


characteristic.North.back.time = 0;
characteristic.North.back.time = [characteristic.North.back.time 0];

temp_time = 0;



for counter1 = 1:360
    
    if counter1 < 360
        a = characteristic.North.index(counter1);
        b = characteristic.North.index(counter1 +1) - 1;
    end
    if counter1 == 360
        a = characteristic.North.index(counter1);
        b = length(characteristic.North.there.time); %last value in the list
    end
    
    for counter2 = 2:length(characteristic.North.there.time(a:b))
        if counter2 ~= length(characteristic.North.there.time(a:b))
            c1 = characteristic.North.there.time(b - counter2);
            c2 = characteristic.North.there.time(b - counter2 +1);
            temp_time = temp_time + (c2 - c1);
            characteristic.North.back.time = [characteristic.North.back.time temp_time];
        else
            c2 = characteristic.North.there.time(b);
            c1 = temp_time;
            characteristic.North.back.time((a+1):b)=characteristic.North.back.time((a+1):b)+(c2-c1);
            temp_time = 0;
        end
        
        
        
    end
    characteristic.North.back.time = [characteristic.North.back.time 0];
    characteristic.North.back.time = [characteristic.North.back.time 0];
    
    progressbar([],progress1/720) % Update progress bar
    progress1 = progress1+1;
    
    
end
characteristic.North.back.time(length(characteristic.North.back.time)) = [];
characteristic.North.back.time(length(characteristic.North.back.time)) = [];
clear c1; clear c2; clear temp_time;clear counter1; clear counter; clear a; clear b;
characteristic.North.back.time = characteristic.North.back.time'; clear counter2;

progressbar(1)
