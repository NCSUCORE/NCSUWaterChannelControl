clc; clear;
loadParams;
load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_22_May_2019_18_55_30.mat');
timeIndex = 3232;

sideDot = tsc.sideDotCoords.Data(:,:,3232);
botDot = tsc.botDotCoords.Data(:,:,3232);
slntDot = tsc.slantDotCoords.Data(:,:,3232);

% sim('find6DOFSnellMin_th');