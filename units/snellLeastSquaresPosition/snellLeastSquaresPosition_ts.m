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

load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_12_Jun_2019_11_07_53.mat')

rCentroid1 = tsc.rCentroidSide.Data(:,:,end);
rCentroid2 = tsc.rCentroidBotA.Data(:,:,end);
rCentroid3 = tsc.rCentroidBotB.Data(:,:,end);
rCentroid4 = tsc.rCentroidSlant.Data(:,:,end);
rCentroid5 = tsc.rCentroidSide.Data(:,:,end);
rCentroid6 = tsc.rCentroidBotA.Data(:,:,end);
rCentroid7 = tsc.rCentroidBotB.Data(:,:,end);
rCentroid8 = tsc.rCentroidSlant.Data(:,:,end);
rCentroid9 = tsc.rCentroidSlant.Data(:,:,end);

rCentroid = [rCentroid1,rCentroid2,rCentroid3,rCentroid4,rCentroid5,...
             rCentroid6,rCentroid7,rCentroid8,rCentroid9];

uCentroid1 = tsc.uCentroidSide.Data(:,:,end);
uCentroid2 = tsc.uCentroidBotA.Data(:,:,end);
uCentroid3 = tsc.uCentroidBotB.Data(:,:,end);
uCentroid4 = tsc.uCentroidSlant.Data(:,:,end);
uCentroid5 = tsc.uCentroidSide.Data(:,:,end);
uCentroid6 = tsc.uCentroidBotA.Data(:,:,end);
uCentroid7 = tsc.uCentroidBotB.Data(:,:,end);
uCentroid8 = tsc.uCentroidSlant.Data(:,:,end);
uCentroid9 = tsc.uCentroidSlant.Data(:,:,end);

uCentroid = [uCentroid1,uCentroid2,uCentroid3,uCentroid4,uCentroid5,...
             uCentroid6,uCentroid7,uCentroid8,uCentroid9];

body2GroundRotMat = eye(3);

bodyFixedVec = [snells(1).bodyFixedVec,snells(2).bodyFixedVec,snells(3).bodyFixedVec,...
                snells(4).bodyFixedVec,snells(5).bodyFixedVec,snells(6).bodyFixedVec,...
                snells(7).bodyFixedVec,snells(8).bodyFixedVec,snells(9).bodyFixedVec];

tic
[COMPosVec] = snellLeastSquaresPosition(rCentroid,uCentroid,body2GroundRotMat,bodyFixedVec);
toc

