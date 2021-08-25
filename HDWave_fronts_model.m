% mkdir temporary
% fname = 'temporary';
% philosphersstone = 1;
% 
HDMAW = struct();
HDMAW.Io_east_long = [];
HDMAW.north.r = [];
HDMAW.north.theta_lat = [];
HDMAW.north.phi_east = [];
HDMAW.south.r = [];
HDMAW.south.theta_lat = [];
HDMAW.south.phi_east = [];


HDRAW = struct();
HDRAW.Io_east_long = [];
HDRAW.north.r = [];
HDRAW.north.theta_lat = [];
HDRAW.north.phi_east = [];
HDRAW.south.r = [];
HDRAW.south.theta_lat = [];
HDRAW.south.phi_east = [];


HDTEB = struct();
HDTEB.Io_east_long = [];
HDTEB.north.r = [];
HDTEB.north.theta_lat = [];
HDTEB.north.phi_east = [];
HDTEB.south.r = [];
HDTEB.south.theta_lat = [];
HDTEB.south.phi_east = [];
% 
% for counter10 = 1:10:360 % for wf on jupiter
%desired_phi = 360 - counter10;





% Start out by inputing your desired phi, this is the location that you
% place Io. This is the location that your are interested in knowing where
% the wavefronts are, when Io is at desired phi. The code then breaks Io's
% orbit into 3600 discrete points. At each point, wf_time_stamp calcualtes
% how much time has passed since Io was at the longitude to launch a
% wavefront.

%wf_location_finder uses this time stamp, the 3 characteristic
% distances, and the discrete field lines to find out where along the field
% line each wavefront is. The three uniqure distances are T1: from io to
% Jupiter (North), T2: from io to Jupiter (South), and T3: T1 + T2. 
% T3 is actually a non unique distance, but is useful to define.
% wf_location_finder then divides each time_stamp by the T3 associated with
% it, this is because after a T3, a wavefront has returned to Io as if it
% had just been launched. We use the time remaining to narrow down where on
% the field line that wavefront is. wf_location_finder does this, and
% computes and saves the location of each wavefront.

%wf_ionosphere calculates where the terminus of each field line is on the
%ionosphere of Jupiter
desired_phi = 200; %in east longitude
load('/Users/pahi9557/Documents/MATLAB/HDAlfven_JRM09/HDJRM09_Alfven_Model_1_19_19.mat')
HDJRM09_wf_time_stamp % creating the wavefronts and the time stamp that each one is launched at


%%% Time increaser %%%%
% characteristic.North.there.time = characteristic.North.there.time*(1.5)^(1/2);
% characteristic.North.back.time = characteristic.North.back.time*(1.5)^(1/2);
% characteristic.South.there.time = characteristic.South.there.time*(1.5)^(1/2);
% characteristic.South.back.time = characteristic.South.back.time*(1.5)^(1/2);
% characteristic.North_time = characteristic.North_time*(1.5)^(1/2);
% characteristic.South_time = characteristic.South_time*(1.5)^(1/2);
%%%%%%%%%%%%%%%%%%%%%%


HDJRM09_wf_location_finder
HDJRM09_wf_ionosphere

%this filter will be used to help decide whether or not a peak is
%actualy reaching the ionosphere
load('/Users/pahi9557/Documents/MATLAB/HDAlfven_JRM09/HD_wf_Modules/wf_filter.mat')

%HDwf_visualizer
wf_on_jup_movie












% 
% 
%      if philosphersstone < 9
%          saveas(gca,fullfile(fname,['fig000' num2str(philosphersstone)]),'jpeg');
%      end
%      
%      if philosphersstone < 99
%          if philosphersstone > 9
%              saveas(gca,fullfile(fname,['fig00' num2str(philosphersstone)]),'jpeg');
%          end
%      end
%      
%      if philosphersstone < 999
%          if philosphersstone > 99
%              saveas(gca,fullfile(fname,['fig0' num2str(philosphersstone)]),'jpeg');
%          end
%      end
%      if philosphersstone < 9999
%          if philosphersstone > 999
%              saveas(gca,fullfile(fname,['fig' num2str(philosphersstone)]),'jpeg');
%          end
%      end
%      
%      
%      if philosphersstone == 9
%          saveas(gca,fullfile(fname,['fig000' num2str(philosphersstone)]),'jpeg');
%      end
%      if philosphersstone == 99
%          saveas(gca,fullfile(fname,['fig00' num2str(philosphersstone)]),'jpeg');
%      end
%      if philosphersstone == 999
%          saveas(gca,fullfile(fname,['fig' num2str(philosphersstone)]),'jpeg');
%      end
%      
%      
%      
%      philosphersstone = philosphersstone+1;
% 
% 



%  close all;
% end