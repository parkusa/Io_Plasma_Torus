
%out of date



te_list = zeros(1,length(Rad)); %generating an empty list for speed
teh_list = zeros(1,length(Rad));%generating an empty list for speed
nhnc_list = zeros(1,length(Rad));%generating an empty list for speed
a = 0;%this will replace te temporarily in the for loop
b = 0;%this will replace teh temporarily in the for loop
c = 0;%this will replace nhnc temporarily in the for loop

for counter = 1:length(Rad)


%tec conditions

    if Rad(counter) < 12
        a = 4.6*(Rad(counter)/6)^(3.4);
    else
        a = 50;
    end
    

%teh conditions

    if Rad(counter) < 11.795734
        b = 35*(Rad(counter)/6)^(4.2);
    else
        b = 600;
    end
    
%nhnc conditions


    if Rad(counter) < 09.696
        c = .001*(Rad(counter)/6)^(8);
    else
        c = 0.1;
    end
    
    te_list(counter) = a;
    teh_list(counter)= b;
    nhnc_list(counter) = c;
end

clear a;
clear b;
clear c;
clear counter;

te_list = te_list';
teh_list = teh_list';
nhnc_list = nhnc_list';