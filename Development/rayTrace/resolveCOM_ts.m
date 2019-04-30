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