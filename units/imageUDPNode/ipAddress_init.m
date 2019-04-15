function ipAddress_init(blockPath,systemPath)

% This function is used to update IP address list
% Receives path to block and overall system in order to re-initialize IP
% address list known by IEEE 1588 Real-Time UDP block

% This function is necessary for proper propogation when using UDP 
% communication in unit library

% Open system (imageUDPNode)
open_system(systemPath,'force') % 'force' option looks under block mask

% Path to current block (usually UDP Send block)
recv_path = blockPath; 

% Path to IEEE 1588 Real-Time UDP block
config_pth = [systemPath '/IEEE 1588 Real-Time UDP']; 

% Get correct IP address from Real-Time UDP block
correctIP = get_param(config_pth,'IpAddress');

% Update IP list of receive path (UDP Send block)
udpslgate('privateupdateIPlist', recv_path, 'UpdateIPList');

% Set ipAddress parameter in receive path (UDP Send block)
set_param(recv_path,'ipAddress',correctIP);

% Close system (imageUDPNode)
close_system(systemPath);

% Update diagram of system to propogate changes
set_param(gcs,'SimulationCommand','Update');

end