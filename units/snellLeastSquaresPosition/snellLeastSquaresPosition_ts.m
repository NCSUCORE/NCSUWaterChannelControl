close all
clear
clc
format compact

sim('resolveCOM_th')

COMPosVec.data
%%
figure

set(gca,'NextPlot','add')

startPt = rCentroidSide.data;
endPt   = startPt + d.data(1)*uCentroidSide.data;
plot3([startPt(1) endPt(1)],[startPt(2) endPt(2)],[startPt(3) endPt(3)],...
    'DisplayName','Side')


startPt = rCentroidBotA.data;
endPt   = startPt + d.data(2)*uCentroidBotA.data;
plot3([startPt(1) endPt(1)],[startPt(2) endPt(2)],[startPt(3) endPt(3)],...
    'DisplayName','Bot A')

startPt = rCentroidBotB.data;
endPt   = startPt + d.data(3)*uCentroidBotB.data;
plot3([startPt(1) endPt(1)],[startPt(2) endPt(2)],[startPt(3) endPt(3)],...
    'DisplayName','Bot B')

startPt = rCentroidSlant.data;
endPt   = startPt + d.data(4)*uCentroidSlant.data;
plot3([startPt(1) endPt(1)],[startPt(2) endPt(2)],[startPt(3) endPt(3)],...
    'DisplayName','Slant')

scatter3(COMPosVec.data(1),COMPosVec.data(2),COMPosVec.data(3),'Marker','o','CData',[1 0 0])

legend

axis equal
axis square

%%
clc;

load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_01_Jul_2019_17_43_39.mat')

timeInd = 152666;

rCentroidSide = tsc.rCentroidSide.Data(:,:,timeInd);
rCentroidBotA = tsc.rCentroidBotA.Data(:,:,timeInd);
rCentroidBotB = tsc.rCentroidBotB.Data(:,:,timeInd);
rCentroidSlant = tsc.rCentroidSlant.Data(:,:,timeInd);

uCentroidSide = tsc.uCentroidSide.Data(:,:,timeInd);
uCentroidBotA = tsc.uCentroidBotA.Data(:,:,timeInd);
uCentroidBotB = tsc.uCentroidBotB.Data(:,:,timeInd);
uCentroidSlant = tsc.uCentroidSlant.Data(:,:,timeInd);

body2GroundRotMat = tsc.body2GroundRotMat.Data(:,:,152665);

sideDotPosVec_cm = params.sideDotPosVec_cm.Value';
botADotPosVec_cm = params.botADotPosVec_cm.Value';
botBDotPosVec_cm = params.botBDotPosVec_cm.Value';
topDotPosVec_cm = params.topDotPosVec_cm.Value';

[COMPosVec,sideDotPos_cm,botADotPos_cm,botBDotPos_cm,topDotPos_cm]...
    = snellLeastSquaresPosition(rCentroidSide,rCentroidBotA,...
        rCentroidBotB,rCentroidSlant,uCentroidSide,uCentroidBotA,...
        uCentroidBotB,uCentroidSlant,body2GroundRotMat,...
        sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm,topDotPosVec_cm)

