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

length = timeEnd - timeStart;

botDot1 = zeros(length,2); 
botDot2 = zeros(length,2);
botDot3 = zeros(length,2);

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
