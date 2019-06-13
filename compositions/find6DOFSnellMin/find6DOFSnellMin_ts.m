% clc; clear;
loadParams;
% load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_23_May_2019_11_20_54.mat');
load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_12_Jun_2019_11_07_53.mat')

timeStart = 800;
timeEnd = 801;
index = 1;

length = timeEnd - timeStart;

for timeIndex = timeStart:timeEnd

    sideDot(index,:) = tsc.sideDotCoords.Data(:,:,timeIndex);
    botDot(index,:) = tsc.botDotCoords.Data(:,:,timeIndex);
    slntDot(index,:) = tsc.slantDotCoords.Data(:,:,timeIndex);
    
    index = index + 1;
    
end

sideDotTime = timeseries(sideDot);
botDotTime = timeseries(botDot);
slntDotTime = timeseries(slntDot);

for ii = 1:index - 1

    tic
    sim('find6DOFSnellMin_th');
    time(index) = toc;
    
end

% EulAng_deg = [roll_deg.Data(1), pitch_deg.Data(1), yaw_deg.Data(1)]';

timeInd = 1;
CoMPos = tsc.CoMPosVec_cm.Data(:,:,timeInd)
EulAng_rad = [tsc.roll_rad.Data(timeInd);
              tsc.pitch_rad.Data(timeInd);
              tsc.yaw_rad.Data(timeInd)];
          
EulAng_deg = EulAng_rad.*180/pi
          
eul = mod(EulAng_deg,360)

try
    clf(fig_on);
catch
end
fig_on = powellsPlot(CoMPos, EulAng_rad, tsc, params, timeInd, 2);

%%
clc;clear;

loadParams;
createCoordinateCtrlBus;
createRayTraceCtrlBus;
createSnellsMinParams;

tic
sim('find6DOFSnellMin9_th');
toc;

