
cd('output/data');
load('data_02_Apr_2019_19_19_35.mat');
cd('../..');

sideDot = tsc.sideDotCoords.Data;
botDot = tsc.botDotCoords.Data;
slntDot = tsc.slantDotCoords.Data;

sampleSize = length(sideDot)/2;
sideDotMean = mean(sideDot(:,:,sampleSize:end),3);
botDotMean = mean(botDot(:,:,sampleSize:end),3);
slntDotMean = mean(slntDot(:,:,sampleSize:end),3);

% botBMean = botDotMean(1:4);
% botAMean = botDotMean(5:8);