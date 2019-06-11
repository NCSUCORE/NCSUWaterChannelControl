clc; clear;
loadParams;
load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_22_May_2019_18_55_30.mat');

timeStart = 4180;
timeEnd = 4200;
index = 1;

length = timeEnd - timeStart;

for timeIndex = timeStart:timeEnd

    sideDot(index,:) = tsc.sideDotCoords.Data(:,:,3232);
    botDot(index,:) = tsc.botDotCoords.Data(:,:,3232);
    slntDot(index,:) = tsc.slantDotCoords.Data(:,:,3232);

%     tic
%     sim('find6DOFSnellMin_th');
%     time(index) = toc;
    
    index = index + 1;
    
end

sideDot = timeseries(sideDot);
botDot = timeseries(botDot);
slntDot = timeseries(slntDot);