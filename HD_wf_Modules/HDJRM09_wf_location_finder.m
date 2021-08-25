%converting so that everything is in minutes
characteristic.North.there.time = characteristic.North.there.time/60;
characteristic.North.back.time = characteristic.North.back.time/60;
characteristic.South.there.time = characteristic.South.there.time/60;
characteristic.South.back.time = characteristic.South.back.time/60;
%assigning the three characteristic times
characteristic.T1 = characteristic.North_time;
characteristic.T2 = characteristic.South_time;
characteristic.T3 = characteristic.T1 + characteristic.T2;

%transposing
characteristic.North.there.time = characteristic.North.there.time';
characteristic.North.back.time = characteristic.North.back.time';
characteristic.South.there.time = characteristic.South.there.time';
characteristic.South.back.time = characteristic.South.back.time';

%Initializing Progress bar
progress1 = 0;
progressbar('Tuning the Violins...',0)


for counter = 1:3600
    
    temp_longitude = wf.list(counter) + 0.1; %picking the wavefront to launch
    temp_longitude = round(temp_longitude*10); % turning 159.9000 into ->
    temp_longitude = temp_longitude/10;% 159.9
    
    %First we find the wavefront that was launched north
    
    if temp_longitude < 360
        a = characteristic.North.index(10*temp_longitude); %a & b are north indexes
        b = characteristic.North.index(10*temp_longitude+1)-1;
    end
    if temp_longitude == 360
        a = characteristic.North.index(10*temp_longitude);
        b = length(characteristic.North.there.time); %last value in the list
    end
    if temp_longitude < 360
        c = characteristic.South.index(10*temp_longitude); %c & d are north indexes
        d = characteristic.South.index(10*temp_longitude+1)-1;
    end
    if temp_longitude == 360
        c = characteristic.South.index(10*temp_longitude);
        d = length(characteristic.South.there.time); %last value in the list
    end
    
    
    quotient = floor(wf.time_stamp(counter)/characteristic.T3(10*temp_longitude)); %How mnay times does the time stamp fit into T3 (integers)?
    %We can ignore all of this time. Each T3 that passes the wave will have
    %launched, gone to Jupiter and back, and then gone to Jupiter and back
    %the other way. So after each T3, the wave will again be back at Io as
    %if it were just launched. What really matter is how much time has
    %passed since the last T3 -> the remainder.
    remainder = mod(wf.time_stamp(counter),characteristic.T3(10*temp_longitude)); %How much is left over?
    temp_time = wf.time_stamp(counter) - quotient*characteristic.T3(10*temp_longitude); % This should be equal to the remainder.
    %From here out, temp_time serves to tell us where this wavefront is.
    
    tri = delaunayn(characteristic.North.there.time(a:b)); %creating a searchable list for all
    %possible locations of the wavefront being considered (the magnetic
    %field line)
    temp_index = dsearchn(characteristic.North.there.time(a:b),tri,temp_time) + a - 1;
    %Search the list for the time that most closely matches the time
    %passed. This value will remain what it is only if the wavefront is on
    %its way from Io to Jupiter. The next section will decide where the
    %wavefront generally is, and may overwrite the location of the
    %wavefront.
    
    %The next three lines save the current, possibly temporary, location of the wavefront
    %wf.r/theta/phi1 are represent the northern launched footprint
    %location. Later in this simulation I will define wf.r.theta/phi2,
    %which represents the south launched wavefront.
    wf.theta1(counter) = characteristic.North.there.theta(temp_index);
    wf.phi1(counter) = characteristic.North.there.phi(temp_index);
    wf.r1(counter) = characteristic.North.there.r(temp_index);
    
    
    %This section decides whether the northern wavefront is on its way up
    %to Jupiter, back from Jupiter's North, down to Jupiter, or back from
    %Jupiter's south
    
    if temp_time > characteristic.T1(10*temp_longitude)/2 %if the wavefront has gone
        %at least from Io to Jupiter. Then it will be on it's way back to
        %Io. We save this location, which may be overwritten if the other
        %if statements are satisfied.
        tri = delaunayn(characteristic.North.back.time(a:b));
        temp_index = dsearchn(characteristic.North.back.time(a:b),tri,(temp_time-characteristic.T1(10*temp_longitude)/2)) + a - 1;
        wf.theta1(counter) = characteristic.North.back.theta(temp_index);
        wf.phi1(counter) = characteristic.North.back.phi(temp_index);
        wf.r1(counter) = characteristic.North.back.r(temp_index);
    end
    
    if temp_time > characteristic.T1(10*temp_longitude) %If the wavefront has
        %gone from Io to Jupiter and back, and is now working its way south
        tri = delaunayn(characteristic.South.there.time(c:d));
        temp_index = dsearchn(characteristic.South.there.time(c:d),tri,(temp_time-characteristic.T1(10*temp_longitude))) + c - 1;
        wf.theta1(counter) = characteristic.South.there.theta(temp_index);
        wf.phi1(counter) = characteristic.South.there.phi(temp_index);
        wf.r1(counter) = characteristic.South.there.r(temp_index);
    end
    if temp_time > (characteristic.T1(10*temp_longitude) + characteristic.T2(10*temp_longitude)/2)
        % If the wavefront has gone from Io, to Jupiter, back, down to
        % Jupiter, and is working its way back again
        tri = delaunayn(characteristic.South.back.time(c:d));
        temp_index = dsearchn(characteristic.South.back.time(c:d),tri,(temp_time-characteristic.T1(10*temp_longitude)-characteristic.T2(10*temp_longitude)/2)) + c - 1;
        wf.theta1(counter) = characteristic.South.back.theta(temp_index);
        wf.phi1(counter) = characteristic.South.back.phi(temp_index);
        wf.r1(counter) = characteristic.South.back.r(temp_index);
    end
    clear a; clear b; clear c; clear d; clear temp_index;
    clear temp_time; clear tri; clear quotient; clear remainder;
    
    
    %Now we repeat this process for the wavefront which was launched south
    
    if temp_longitude < 360
        a = characteristic.South.index(10*temp_longitude);
        b = characteristic.South.index(10*temp_longitude+1)-1;
    end
    if temp_longitude == 360
        a = characteristic.South.index(10*temp_longitude);
        b = length(characteristic.South.there.time); %last value in the list
    end
    if temp_longitude < 360
        c = characteristic.North.index(10*temp_longitude);
        d = characteristic.North.index(10*temp_longitude+1)-1;
    end
    if temp_longitude == 360
        c = characteristic.North.index(10*temp_longitude);
        d = length(characteristic.North.there.time); %last value in the list
    end
    
    
    quotient = floor(wf.time_stamp(counter)/characteristic.T3(10*temp_longitude));
    remainder = mod(wf.time_stamp(counter),characteristic.T3(10*temp_longitude));
    temp_time = wf.time_stamp(counter) - quotient*characteristic.T3(10*temp_longitude); % should be equal to remainder
    
    tri = delaunayn(characteristic.South.there.time(a:b));
    temp_index = dsearchn(characteristic.South.there.time(a:b),tri,temp_time) + a - 1;
    wf.theta2(counter) = characteristic.South.there.theta(temp_index);
    wf.phi2(counter) = characteristic.South.there.phi(temp_index);
    wf.r2(counter) = characteristic.South.there.r(temp_index);
    if temp_time > characteristic.T2(10*temp_longitude)/2
        tri = delaunayn(characteristic.South.back.time(a:b));
        temp_index = dsearchn(characteristic.South.back.time(a:b),tri,(temp_time-characteristic.T2(10*temp_longitude)/2)) + a - 1;
        wf.theta2(counter) = characteristic.South.back.theta(temp_index);
        wf.phi2(counter) = characteristic.South.back.phi(temp_index);
        wf.r2(counter) = characteristic.South.back.r(temp_index);
    end
    
    if temp_time > characteristic.T2(10*temp_longitude)
        tri = delaunayn(characteristic.North.there.time(c:d));
        temp_index = dsearchn(characteristic.North.there.time(c:d),tri,(temp_time-characteristic.T2(10*temp_longitude))) + c - 1;
        wf.theta2(counter) = characteristic.North.there.theta(temp_index);
        wf.phi2(counter) = characteristic.North.there.phi(temp_index);
        wf.r2(counter) = characteristic.North.there.r(temp_index);
    end
    if temp_time > (characteristic.T2(10*temp_longitude) + characteristic.T1(10*temp_longitude)/2)
        tri = delaunayn(characteristic.North.back.time(c:d));
        temp_index = dsearchn(characteristic.North.back.time(c:d),tri,(temp_time-characteristic.T2(10*temp_longitude)-characteristic.T1(10*temp_longitude)/2)) + c - 1;
        wf.theta2(counter) = characteristic.North.back.theta(temp_index);
        wf.phi2(counter) = characteristic.North.back.phi(temp_index);
        wf.r2(counter) = characteristic.North.back.r(temp_index);
    end
    clear a; clear b; clear c; clear d; clear temp_index;
    clear temp_time; clear tri; clear quotient; clear remainder; clear temp_longitude;
    
    progressbar([],progress1/3600) % Update progress bar
        progress1 = progress1+1;
    
end

progressbar(1)%close progress bar

wf.theta1 = wf.theta1';
wf.theta2 = wf.theta2';
wf.phi1 = wf.phi1';
wf.phi2 = wf.phi2';
wf.r1 = wf.r1';
wf.r2 = wf.r2';
clear counter; clear temp_longitude;
clc

%forcing phi to be from 0 - 359.9
for counter = 1:length(wf.phi1)
    
if wf.phi1(counter)>360
    wf.phi1(counter) = wf.phi1(counter) - 360;
end
if wf.phi1(counter)<0
    wf.phi1(counter) = wf.phi1(counter) + 360;
end

end
for counter = 1:length(wf.phi2)
    
if wf.phi2(counter)>360
    wf.phi2(counter) = wf.phi2(counter) - 360;
end
if wf.phi2(counter)<0
    wf.phi2(counter) = wf.phi2(counter) + 360;
end

end
clear counter;

