load 'data_15_Nov_2019_14_11_00.mat' 

% define time to observe 
tStart = 100; %change to 0 if needed. 
% tend => end;  -- change if needed  

% Euler angles  
figure
hold on
grid

plot(180/pi*tsc.pitch_rad.Data(tStart:end),'r-')
plot(180/pi*tsc.roll_rad.Data(tStart:end),'g-')
plot(180/pi*tsc.yaw_rad.Data(tStart:end),'b-')
plot(tsc.PitchSetpoint.Data(tStart:end),'LineWidth',4)
plot(tsc.RollSetpoint.Data(tStart:end),'LineWidth',4)

title('Euler angle plots')
legend('pitch','roll','yaw')

% CoM positions 
figure 
hold on
grid

plot(tsc.CoMPosVec_cm.data(3,tStart:end),'r-')
plot(tsc.CoMPosVec_cm.data(1,tStart:end),'g-')
plot(tsc.CoMPosVec_cm.data(2,tStart:end),'b-')

title('CoM position plots')
legend('z','x','y')

% Velocity tracking  

figure 
hold on
grid

plot(diff(tsc.CoMPosVec_cm.data(3,tStart:end))./0.01,'r-')
plot(diff(tsc.CoMPosVec_cm.data(1,tStart:end))./0.01,'g-')
plot(diff(tsc.CoMPosVec_cm.data(2,tStart:end))./0.01,'b-')

title('CoM raw velocity plots')
legend('Vz','Vx','Vy')

Vflow = 17.6;                                                               %Define tunnel flow velocity 

Vz = diff(tsc.CoMPosVec_cm.data(3,tStart:end))./0.01; 
Vx = diff(tsc.CoMPosVec_cm.data(1,tStart:end))./0.01; 
Vy = diff(tsc.CoMPosVec_cm.data(2,tStart:end))./0.01; 

windowSize_vel = 1000; 
b = (1/windowSize_vel)*ones(1,windowSize_vel);
a = 1;
Vz_f = filter(b,a,Vz);
Vx_f = filter(b,a,Vx);
Vy_f = filter(b,a,Vy);

figure 
hold on
grid

plot(Vz_f)
plot(Vx_f)
plot(Vy_f)

title('CoM filtered velocity plots')
legend('Vz','Vx','Vy')

% Power ratio 

Vapp = [abs(Vz); abs(Vx - Vflow); abs(Vy)]; 
Vapp = Vapp';
Vapp_mag = sqrt((Vapp(:,1).*Vapp(:,1))+(Vapp(:,2).*Vapp(:,2))+(Vapp(:,3).*Vapp(:,3)));
Vratio = Vapp_mag./Vflow; 
P_ratio = Vratio.^3; 

figure
grid
plot(Vratio)
title('Velocity Ratio') 

windowSize_pow = 1000; 
b = (1/windowSize_pow)*ones(1,windowSize_pow);
a = 1;
P_ratio = filter(b,a,P_ratio);
figure 
plot(P_ratio)
title('Filtered power ratio') 


