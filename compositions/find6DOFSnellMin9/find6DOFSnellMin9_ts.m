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
try
    clf(figHandle)
catch
end

clear;clc;

load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_20_Jun_2019_14_13_56.mat')
loadParams;
createSnellsMinParams;
createRayTraceCtrlBus;
createCoordinateCtrlBus;

timeStart = 99990;
timeEnd = 100000;
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


sim('find6DOFSnellMin9_th');

EulAng_deg = [roll_deg.Data(end);pitch_deg.Data(end);yaw_deg.Data(end)]
EulAng_rad = EulAng_deg.*pi/180;

rCentroid = [cam1Dot1InVec.Data(:,end),cam1Dot2InVec.Data(:,end),cam1Dot3InVec.Data(:,end),...
             cam2Dot1InVec.Data(:,end),cam2Dot2InVec.Data(:,end),cam2Dot3InVec.Data(:,end),...
             cam3Dot1InVec.Data(:,end),cam3Dot2InVec.Data(:,end),cam3Dot3InVec.Data(:,end)];

uCentroid = [cam1Dot1UnitVec.Data(:,end),cam1Dot2UnitVec.Data(:,end),cam1Dot3UnitVec.Data(:,end),...
             cam2Dot1UnitVec.Data(:,end),cam2Dot2UnitVec.Data(:,end),cam2Dot3UnitVec.Data(:,end),...
             cam3Dot1UnitVec.Data(:,end),cam3Dot2UnitVec.Data(:,end),cam3Dot3UnitVec.Data(:,end)];

figHandle = powellsPlot(snells, CoMPos.Data(end,:), EulAng_rad, rCentroid, uCentroid, 1);
axis equal

%%

load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_20_Jun_2019_12_17_16.mat')
CoMPos = [5.25;-2.9;49.8];
EulAng = [0;0;0];

rCentroid = tsc.cam1Dot3InVec.Data(:,:,1);
uCentroid = tsc.cam1Dot3UnitVec.Data(:,:,1);
bodyFixedVec = snells(3).bodyFixedVec;

RGB = calculateRotationMatrix(EulAng(1),EulAng(2),EulAng(3));
RBG = RGB';

eMin = 10^6;

d = uCentroid'*(CoMPos + RBG*bodyFixedVec - rCentroid);
e = dot( ((CoMPos + RBG*bodyFixedVec) - (rCentroid + uCentroid*d)),...
         ((CoMPos + RBG*bodyFixedVec) - (rCentroid + uCentroid*d)) );

errVec = ((CoMPos + RBG*bodyFixedVec) - (rCentroid + uCentroid*d));
         
figure(1)
plot3(...
   [rCentroid(1) rCentroid(1)+d*uCentroid(1)],...
   [rCentroid(2) rCentroid(2)+d*uCentroid(2)],...
   [rCentroid(3) rCentroid(3)+d*uCentroid(3)],...
   'LineStyle','--','LineWidth',1,'Color','k','DisplayName','New Ray');

startPt = (rCentroid + uCentroid*dBefore);
plot3(...
   [startPt(1) startPt(1)+errVec(1)],...
   [startPt(2) startPt(2)+errVec(2)],...
   [startPt(3) startPt(3)+errVec(3)],...
   'LineStyle','--','LineWidth',1,'Color','b','DisplayName','Error Ray');

%%


