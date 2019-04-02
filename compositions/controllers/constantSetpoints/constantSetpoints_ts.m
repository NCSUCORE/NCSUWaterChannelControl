close all
clear
clc
Tf = 10;
Ts = 1e-3;

test = 'fault';

time = 0:Ts:Tf;
faultStatus = false(size(time));

switch test
    case 'pitch'
        roll_deg  = 0;
        pitch_deg = 1;
        yaw_deg   = 0;
        CoMPositionVec_cm = [0 0 39];
        
    case 'roll'
        roll_deg  = 1;
        pitch_deg = 0;
        yaw_deg   = 0;
        CoMPositionVec_cm = [0 0 39];
                
    case 'fault'
        roll_deg  = 1;
        pitch_deg = 0;
        yaw_deg   = 0;
        CoMPositionVec_cm = [0 0 40];
        faultStatus(and(time>4,time<6)) = true;
         
    otherwise
end

faultStatus = timeseries(faultStatus,time);

sim('constantSetpoints_th')

figure
subplot(3,1,1)
mtr1.plot
subplot(3,1,2)
mtr2.plot
subplot(3,1,3)
mtr3.plot
