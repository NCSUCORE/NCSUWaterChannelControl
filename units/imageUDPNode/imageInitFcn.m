function imageInitFcn(blockPath)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

open_system(blockPath,'force') %'force' option looks under block mask
recv_path = [blockPath '/UDP Receive']; 
config_pth = [blockPath '/IEEE 1588 Real-Time UDP']; 

correctIP = get_param(config_pth,'Receive1');
set_param(recv_path,'ipAddress',correctIP); 
close_system(systemPath);

end