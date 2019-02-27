function imageInitFcn(blockPath,systemPath)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

open_system(systemPath,'force') %'force' option looks under block mask
recv_path = [blockPath]; 
config_pth = [systemPath '/IEEE 1588 Real-Time UDP']; 

%open_system(recv_path);

correctIP = get_param(config_pth,'IpAddress');
udpslgate('privateupdateIPlist', recv_path, 'UpdateIPList');

%close_system(recv_path);

set_param(recv_path,'ipAddress',correctIP); 
close_system(systemPath);

set_param(gcs,'SimulationCommand','Update');

end