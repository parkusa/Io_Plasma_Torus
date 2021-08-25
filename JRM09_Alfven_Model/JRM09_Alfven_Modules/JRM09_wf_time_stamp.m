if desired_phi < 0
    desired_phi = desired_phi +360;
end
if desired_phi == 360
    desired_phi = 0;
end

wf = struct();
wf.list = (0:desired_phi);
wf.list = [wrev(wf.list) wrev((desired_phi+1):359)];
wf.list = wf.list';

wf.time_stamp = (0:359)*2.1767;
wf.time_stamp = wrev(wf.time_stamp);
wf.time_stamp = wf.time_stamp';