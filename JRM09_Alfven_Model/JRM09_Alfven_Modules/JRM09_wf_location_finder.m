%converting so that everything is in minutes
characteristic.North.there.time = characteristic.North.there.time/60;
characteristic.North.back.time = characteristic.North.back.time/60;
characteristic.South.there.time = characteristic.South.there.time/60;
characteristic.South.back.time = characteristic.South.back.time/60;
%assigning the three characteristic times
characteristic.T1 = characteristic.North_time;
characteristic.T2 = characteristic.South_time;
characteristic.T3 = characteristic.T1 + characteristic.T2;

%Initializing Progress bar
progress1 = 0;
progressbar('Tuning the Violins...',0)


for counter = 1:360
    
    temp_longitude = wf.list(counter) + 1;
    
    if temp_longitude < 360
        a = characteristic.North.index(temp_longitude);
        b = characteristic.North.index(temp_longitude+1)-1;
    end
    if temp_longitude == 360
        a = characteristic.North.index(temp_longitude);
        b = length(characteristic.North.there.time); %last value in the list
    end
    if temp_longitude < 360
        c = characteristic.South.index(temp_longitude);
        d = characteristic.South.index(temp_longitude+1)-1;
    end
    if temp_longitude == 360
        c = characteristic.South.index(temp_longitude);
        d = length(characteristic.South.there.time); %last value in the list
    end
    
    
    quotient = floor(wf.time_stamp(counter)/characteristic.T3(temp_longitude));
    remainder = mod(wf.time_stamp(counter),characteristic.T3(temp_longitude));
    temp_time = wf.time_stamp(counter) - quotient*characteristic.T3(temp_longitude); % should be equal to remainder
    
    tri = delaunayn(characteristic.North.there.time(a:b));
    temp_index = dsearchn(characteristic.North.there.time(a:b),tri,temp_time) + a - 1;
    wf.theta1(counter) = characteristic.North.there.theta(temp_index);
    wf.phi1(counter) = characteristic.North.there.phi(temp_index);
    wf.r1(counter) = characteristic.North.there.r(temp_index);
    if temp_time > characteristic.T1(temp_longitude)/2
        tri = delaunayn(characteristic.North.back.time(a:b));
        temp_index = dsearchn(characteristic.North.back.time(a:b),tri,(temp_time-characteristic.T1(temp_longitude)/2)) + a - 1;
        wf.theta1(counter) = characteristic.North.back.theta(temp_index);
        wf.phi1(counter) = characteristic.North.back.phi(temp_index);
        wf.r1(counter) = characteristic.North.back.r(temp_index);
    end
    
    if temp_time > characteristic.T1(temp_longitude)
        tri = delaunayn(characteristic.South.there.time(c:d));
        temp_index = dsearchn(characteristic.South.there.time(c:d),tri,(temp_time-characteristic.T1(temp_longitude))) + c - 1;
        wf.theta1(counter) = characteristic.South.there.theta(temp_index);
        wf.phi1(counter) = characteristic.South.there.phi(temp_index);
        wf.r1(counter) = characteristic.South.there.r(temp_index);
    end
    if temp_time > (characteristic.T1(temp_longitude) + characteristic.T2(temp_longitude)/2)
        tri = delaunayn(characteristic.South.back.time(c:d));
        temp_index = dsearchn(characteristic.South.back.time(c:d),tri,(temp_time-characteristic.T1(temp_longitude)-characteristic.T2(temp_longitude)/2)) + c - 1;
        wf.theta1(counter) = characteristic.South.back.theta(temp_index);
        wf.phi1(counter) = characteristic.South.back.phi(temp_index);
        wf.r1(counter) = characteristic.South.back.r(temp_index);
    end
    clear a; clear b; clear c; clear d; clear temp_index;
    clear temp_time; clear tri; clear quotient; clear remainder;
    
    
    
    
    if temp_longitude < 360
        a = characteristic.South.index(temp_longitude);
        b = characteristic.South.index(temp_longitude+1)-1;
    end
    if temp_longitude == 360
        a = characteristic.South.index(temp_longitude);
        b = length(characteristic.South.there.time); %last value in the list
    end
    if temp_longitude < 360
        c = characteristic.North.index(temp_longitude);
        d = characteristic.North.index(temp_longitude+1)-1;
    end
    if temp_longitude == 360
        c = characteristic.North.index(temp_longitude);
        d = length(characteristic.North.there.time); %last value in the list
    end
    
    
    quotient = floor(wf.time_stamp(counter)/characteristic.T3(temp_longitude));
    remainder = mod(wf.time_stamp(counter),characteristic.T3(temp_longitude));
    temp_time = wf.time_stamp(counter) - quotient*characteristic.T3(temp_longitude); % should be equal to remainder
    
    tri = delaunayn(characteristic.South.there.time(a:b));
    temp_index = dsearchn(characteristic.South.there.time(a:b),tri,temp_time) + a - 1;
    wf.theta2(counter) = characteristic.South.there.theta(temp_index);
    wf.phi2(counter) = characteristic.South.there.phi(temp_index);
    wf.r2(counter) = characteristic.South.there.r(temp_index);
    if temp_time > characteristic.T2(temp_longitude)/2
        tri = delaunayn(characteristic.South.back.time(a:b));
        temp_index = dsearchn(characteristic.South.back.time(a:b),tri,(temp_time-characteristic.T2(temp_longitude)/2)) + a - 1;
        wf.theta2(counter) = characteristic.South.back.theta(temp_index);
        wf.phi2(counter) = characteristic.South.back.phi(temp_index);
        wf.r2(counter) = characteristic.South.back.r(temp_index);
    end
    
    if temp_time > characteristic.T2(temp_longitude)
        tri = delaunayn(characteristic.North.there.time(c:d));
        temp_index = dsearchn(characteristic.North.there.time(c:d),tri,(temp_time-characteristic.T2(temp_longitude))) + c - 1;
        wf.theta2(counter) = characteristic.North.there.theta(temp_index);
        wf.phi2(counter) = characteristic.North.there.phi(temp_index);
        wf.r2(counter) = characteristic.North.there.r(temp_index);
    end
    if temp_time > (characteristic.T2(temp_longitude) + characteristic.T1(temp_longitude)/2)
        tri = delaunayn(characteristic.North.back.time(c:d));
        temp_index = dsearchn(characteristic.North.back.time(c:d),tri,(temp_time-characteristic.T2(temp_longitude)-characteristic.T1(temp_longitude)/2)) + c - 1;
        wf.theta2(counter) = characteristic.North.back.theta(temp_index);
        wf.phi2(counter) = characteristic.North.back.phi(temp_index);
        wf.r2(counter) = characteristic.North.back.r(temp_index);
    end
    clear a; clear b; clear c; clear d; clear temp_index;
    clear temp_time; clear tri; clear quotient; clear remainder; clear temp_longitude;
    
    progressbar([],progress1/360) % Update progress bar
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