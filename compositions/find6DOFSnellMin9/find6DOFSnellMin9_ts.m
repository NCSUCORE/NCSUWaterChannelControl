%%
clc;clear;

load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_16_May_2019_12_40_34.mat')

loadParams;
createCoordinateCtrlBus;
createRayTraceCtrlBus;
createSnellsMinParams;

timeStart = 1000;
timeEnd = 1050;
index = 1;

len = timeEnd - timeStart;

botDot1 = zeros(len,2); 
botDot2 = zeros(len,2);
botDot3 = zeros(len,2);

for ii = timeStart:timeEnd
    botDotCoords = tsc.botDotCoords.Data(:,:,ii);
    botDot1(index,:) = botDotCoords(1:2)';
    botDot2(index,:) = botDotCoords(3:4)';
    botDot3(index,:) = botDotCoords(5:6)';
    
    index = index + 1;
end

botDot1Time = timeseries(botDot1);
botDot2Time = timeseries(botDot2);
botDot3Time = timeseries(botDot3);

%%

load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_18_Jun_2019_17_24_48.mat')

timeStart = 900;
timeEnd = 910;
index = 1;

len = timeEnd - timeStart;

cam1 = zeros(len,6); 
cam2 = zeros(len,6);
cam3 = zeros(len,6);

for ii = timeStart:timeEnd
    cam1(index,:) = tsc.cam1DotPos.Data(:,:,ii);
    cam2(index,:) = tsc.cam2DotPos.Data(:,:,ii);
    cam3(index,:) = tsc.cam3DotPos.Data(:,:,ii);
    
    index = index + 1;
end

cam1Time = timeseries(cam1);
cam2Time = timeseries(cam2);
cam3Time = timeseries(cam3);

