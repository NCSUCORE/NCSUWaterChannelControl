clc;clear;
loadParams;
load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_29_May_2019_14_39_58.mat');

x0 = [0 0 0]';

rCentroidSide = tsc.rCentroidSide.Data(:,:,end);
rCentroidBotA = tsc.rCentroidBotA.Data(:,:,end);
rCentroidBotB = tsc.rCentroidBotB.Data(:,:,end);
rCentroidSlant = tsc.rCentroidSlant.Data(:,:,end);

uCentroidSide = tsc.uCentroidSide.Data(:,:,end);
uCentroidBotA = tsc.uCentroidBotA.Data(:,:,end);
uCentroidBotB = tsc.uCentroidBotB.Data(:,:,end);
uCentroidSlant = tsc.uCentroidSlant.Data(:,:,end);

sideDotPosVec_cm = params.sideDotPosVec_cm.Value';
botADotPosVec_cm = params.botADotPosVec_cm.Value';
botBDotPosVec_cm = params.botBDotPosVec_cm.Value';

CoMPos = params.initCoMPosVec_cm.Value';

snellsMinimization(x0,CoMPos,rCentroidSide,rCentroidBotA,...
    rCentroidBotB,rCentroidSlant,uCentroidSide,...
    uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm)