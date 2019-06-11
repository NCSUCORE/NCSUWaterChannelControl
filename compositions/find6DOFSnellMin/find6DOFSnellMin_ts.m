% clc; clear;
loadParams;
load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_23_May_2019_11_20_54.mat');

timeStart = 500;
timeEnd = 501;
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

EulAng_deg = [roll_deg.Data(1), pitch_deg.Data(1), yaw_deg.Data(1)]';

powellsPlot(CoMPos.Data(1,:), EulAng_deg, tsc, params, 1)
    