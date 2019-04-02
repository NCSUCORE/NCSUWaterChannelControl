close all
clear
clc

test = 'roll';

switch test
    case 'pitch'
        roll_deg  = 0;
        pitch_deg = 1;
        yaw_deg   = 0;
        CoMPositionVec_cm = [0 0 39];
        faultStatus = false;
        
    case 'roll'
        roll_deg  = 1;
        pitch_deg = 0;
        yaw_deg   = 0;
        CoMPositionVec_cm = [0 0 39];
        faultStatus = false;
        
    otherwise
end

sim('constantSetpoints_th')

figure
subplot(3,1,1)
mtr1.plot
subplot(3,1,2)
mtr2.plot
subplot(3,1,3)
mtr3.plot

figure
simout.plot