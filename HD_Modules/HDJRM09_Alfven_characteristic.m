%this module computes the three characteristic times/distances for the
%wavefront model and organizes the there and back times


%Multiply the time to go from Io to Jupiter by 2, to include the time for
%the wave to come back to Io
characteristic.North_time = Index.Alfven_Travel_Time_North*2;
characteristic.South_time = Index.Alfven_Travel_Time_South*2;

%convert to minutes
characteristic.North_time = characteristic.North_time/60;
characteristic.South_time = characteristic.South_time/60;

%Jupiter's magnetic field rotates 360 degrees in 9.93 hrs. This equals 0.6
%degrees per minute. Multiply the characteristic travel time by by 0.6
%tells you the angular distance Io has traveled in that time.
characteristic.North_distance = characteristic.North_time*0.6; 
characteristic.South_distance = characteristic.South_time*0.6;


%d1 is the shorter time from Io to Jupiter (and back)
%d2 is the longer  time from Io to Jupiter (and back)

%This "time" is how long it takes an Alfven wave to propogate either north
%or south from Io to Jupiter (and back)

%d3 is the addition of d1 and d2. These are the three characteristic times


%This loop assigns, for each longitude, d1 and d2 to either North or South
for counter = 1:3600
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
%should be a (1 x 3600) array

%preparing north back locations from north there locations. Times will be
%done separately 
for counter1 = 1:3600
    
    if counter1 < 3600
        a = characteristic.North.index(counter1);
        b = characteristic.North.index(counter1 +1) - 1;
    end
    if counter1 == 3600
        a = characteristic.North.index(counter1);
        b = length(characteristic.North.there.theta); %last value in the list
    end
    
    characteristic.North.back.theta(a:b) = wrev(characteristic.North.there.theta(a:b));
    characteristic.North.back.r(a:b) = wrev(characteristic.North.there.r(a:b));
    characteristic.North.back.B(a:b) = wrev(characteristic.North.there.B(a:b));
    characteristic.North.back.phi(a:b) = wrev(characteristic.North.there.phi(a:b));

end


characteristic.South.index = find(characteristic.South.there.time==0);
%should be a (1 x 3600) array


%preparing South back locations from South there locations. Times will be
%done separately 
for counter1 = 1:3600
    
    if counter1 < 3600
        a = characteristic.South.index(counter1);
        b = characteristic.South.index(counter1 +1) - 1;
    end
    if counter1 == 3600
        a = characteristic.South.index(counter1);
        b = length(characteristic.South.there.theta); %last value in the list
    end
    
    characteristic.South.back.theta(a:b) = wrev(characteristic.South.there.theta(a:b));
    characteristic.South.back.r(a:b) = wrev(characteristic.South.there.r(a:b));
    characteristic.South.back.B(a:b) = wrev(characteristic.South.there.B(a:b));
    characteristic.South.back.phi(a:b) = wrev(characteristic.South.there.phi(a:b));

end
clear counter1; clear counter; clear a; clear b;


characteristic.North.back.theta = characteristic.North.back.theta';
characteristic.North.back.r = characteristic.North.back.r';
characteristic.North.back.B = characteristic.North.back.B';
characteristic.North.back.phi = characteristic.North.back.phi';
characteristic.South.back.theta = characteristic.South.back.theta';
characteristic.South.back.r = characteristic.South.back.r';
characteristic.South.back.B = characteristic.South.back.B';
characteristic.South.back.phi = characteristic.South.back.phi';




%The following code computes the back tavel times from the there travel
%times. This starts at the end of the there travel time, and takes the
%difference between each time, as the difference between two points there
%and back should be equal.
progress1 = 0;
progressbar('Computing There and Back Times...',0)
characteristic.North.back.time = ones(length(characteristic.North.there.time), 1);
characteristic.North.back.time(1) = 0;
cnt = 1;
for counter1 = 1:3600
    
temp_time = 0;

    if counter1 < 3600
        a = characteristic.North.index(counter1);
        b = characteristic.North.index(counter1 +1) - 1;
    end
    if counter1 == 3600
        a = characteristic.North.index(counter1);
        b = length(characteristic.North.there.time); %last value in the list
    end
    
    for counter2 = 1:(length(characteristic.North.there.time(a:b))-1)  
            c1 = characteristic.North.there.time(b - counter2);
            c2 = characteristic.North.there.time(b - counter2 +1);
            temp_time = temp_time + (c2 - c1);
            cnt = cnt + 1;
            characteristic.North.back.time(cnt) =  temp_time;
   
    end
    cnt = cnt + 1;
    characteristic.North.back.time(cnt) = 0;
    
    progressbar([],progress1/7200) % Update progress bar
    progress1 = progress1+1;
    
    
end
characteristic.North.back.time(length(characteristic.North.back.time)) = [];
clear c1; clear c2; clear temp_time;clear counter1; clear counter; clear a; clear b;
characteristic.North.back.time = characteristic.North.back.time'; clear counter2; clear cnt;

characteristic.South.back.time = ones(length(characteristic.South.there.time), 1);
characteristic.South.back.time(1) = 0;
cnt = 1;
for counter1 = 1:3600
    
temp_time = 0;

    if counter1 < 3600
        a = characteristic.South.index(counter1);
        b = characteristic.South.index(counter1 +1) - 1;
    end
    if counter1 == 3600
        a = characteristic.South.index(counter1);
        b = length(characteristic.South.there.time); %last value in the list
    end
    
    for counter2 = 1:(length(characteristic.South.there.time(a:b))-1)  
            c1 = characteristic.South.there.time(b - counter2);
            c2 = characteristic.South.there.time(b - counter2 +1);
            temp_time = temp_time + (c2 - c1);
            cnt = cnt + 1;
            characteristic.South.back.time(cnt) =  temp_time;
   
    end
    cnt = cnt + 1;
    characteristic.South.back.time(cnt) = 0;
    
    progressbar([],progress1/7200) % Update progress bar
    progress1 = progress1+1;
    
    
end
characteristic.South.back.time(length(characteristic.South.back.time)) = [];
clear c1; clear c2; clear temp_time;clear counter1; clear counter; clear a; clear b;
characteristic.South.back.time = characteristic.South.back.time'; clear counter2; clear cnt;

progressbar(1)
