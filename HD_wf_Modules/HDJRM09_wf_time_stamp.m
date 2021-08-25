if desired_phi < 0
    desired_phi = desired_phi +360;
end
if desired_phi == 360
    desired_phi = 0;
end

wf = struct();
wf.list = (0:0.1:desired_phi);
wf.list = [wrev(wf.list) wrev((desired_phi+.1):0.1:359.9)];

if desired_phi == 359.8;
    wf.list = [wf.list 359.9];
end
wf.list = wf.list';

%2.1767 is how many minutes pass between integer field line launches

wf.time_stamp = (0:3599)*0.21767;
wf.time_stamp = wrev(wf.time_stamp);
wf.time_stamp = wf.time_stamp';