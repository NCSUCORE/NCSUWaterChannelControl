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

%%

sim('find6DOFSnellMin9_th');

EulAng_deg = [roll_deg.Data(end);pitch_deg.Data(end);yaw_deg.Data(end)]
EulAng_rad = EulAng_deg.*pi/180;

rCentroid = [cam1Dot1InVec.Data(:,end),cam1Dot2InVec.Data(:,end),cam1Dot3InVec.Data(:,end),...
             cam2Dot1InVec.Data(:,end),cam2Dot2InVec.Data(:,end),cam2Dot3InVec.Data(:,end),...
             cam3Dot1InVec.Data(:,end),cam3Dot2InVec.Data(:,end),cam3Dot3InVec.Data(:,end)];

uCentroid = [cam1Dot1UnitVec.Data(:,end),cam1Dot2UnitVec.Data(:,end),cam1Dot3UnitVec.Data(:,end),...
             cam2Dot1UnitVec.Data(:,end),cam2Dot2UnitVec.Data(:,end),cam2Dot3UnitVec.Data(:,end),...
             cam3Dot1UnitVec.Data(:,end),cam3Dot2UnitVec.Data(:,end),cam3Dot3UnitVec.Data(:,end)];

figHandle = powellsPlot(snells, CoMPos.Data(end,:), EulAng_rad, rCentroid, uCentroid, 2);
axis equal

dotCoords = [tsc.cam1DotPos.Data(:,:,timeEnd),tsc.cam2DotPos.Data(:,:,timeEnd),tsc.cam3DotPos.Data(:,:,timeEnd)];

%%
try
    clf(figHand)
catch
end

clc;clear;

load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_20_Jun_2019_14_13_56.mat');
loadParams;
createSnellsMinParams;
createRayTraceCtrlBus;
createCoordinateCtrlBus;

timeEnd = 100000;

rCentroid = [tsc.cam1Dot1InVec.Data(:,timeEnd),tsc.cam1Dot2InVec.Data(:,timeEnd),tsc.cam1Dot3InVec.Data(:,timeEnd),...
             tsc.cam2Dot1InVec.Data(:,timeEnd),tsc.cam2Dot2InVec.Data(:,timeEnd),tsc.cam2Dot3InVec.Data(:,timeEnd),...
             tsc.cam3Dot1InVec.Data(:,timeEnd),tsc.cam3Dot2InVec.Data(:,timeEnd),tsc.cam3Dot3InVec.Data(:,timeEnd)];

uCentroid = [tsc.cam1Dot1UnitVec.Data(:,timeEnd),tsc.cam1Dot2UnitVec.Data(:,timeEnd),tsc.cam1Dot3UnitVec.Data(:,timeEnd),...
             tsc.cam2Dot1UnitVec.Data(:,timeEnd),tsc.cam2Dot2UnitVec.Data(:,timeEnd),tsc.cam2Dot3UnitVec.Data(:,timeEnd),...
             tsc.cam3Dot1UnitVec.Data(:,timeEnd),tsc.cam3Dot2UnitVec.Data(:,timeEnd),tsc.cam3Dot3UnitVec.Data(:,timeEnd)];

bodyFixedVec = [snells(1).bodyFixedVec,snells(2).bodyFixedVec,snells(3).bodyFixedVec,...
                snells(4).bodyFixedVec,snells(5).bodyFixedVec,snells(6).bodyFixedVec,...
                snells(7).bodyFixedVec,snells(8).bodyFixedVec,snells(9).bodyFixedVec];

EulAng_rad = [tsc.roll_rad.Data(timeEnd);tsc.pitch_rad.Data(timeEnd);tsc.yaw_rad.Data(timeEnd)];
CoMPos = tsc.CoMPos.Data(:,:,timeEnd);

RGB = calculateRotationMatrix(EulAng_rad(1),EulAng_rad(2),EulAng_rad(3));
RBG = RGB';

J = 0;
d = zeros(1,length(rCentroid));
errVec = zeros(3,length(rCentroid));
for ii = 1:length(rCentroid)
    d(ii) = uCentroid(:,ii)'*(CoMPos + RBG*bodyFixedVec(:,ii) - rCentroid(:,ii));
    e = dot( ((CoMPos + RBG*bodyFixedVec(:,ii)) - (rCentroid(:,ii) + uCentroid(:,ii)*d(ii))),...
             ((CoMPos + RBG*bodyFixedVec(:,ii)) - (rCentroid(:,ii) + uCentroid(:,ii)*d(ii))) );

    errVec(:,ii) = (CoMPos + RBG*bodyFixedVec(:,ii)) - (rCentroid(:,ii) + uCentroid(:,ii)*d(ii));

    J = J + e;
end
         
figHand = figure(1);
set(gca,'NextPlot','add')
legend
grid on

marker = {'o','*','+','.'};
names = {'x','y','z'}; 
line = {'-','--',':'};
colors = {'c','m','k'};
rayNames = {'Port Dot Ray','Starboard Dot Ray','Aft Dot Ray'};
dotBFName = {'portDot','starboardDot','aftDot'};

for ii = 1:length(dotBFName)
    
    dotVecGF = RBG * bodyFixedVec(:,ii);
    
    plot3(...
        [CoMPos(1) CoMPos(1)+dotVecGF(1)],...
        [CoMPos(2) CoMPos(2)+dotVecGF(2)],...
        [CoMPos(3) CoMPos(3)+dotVecGF(3)],...
       'LineStyle',line{ii},'LineWidth',1,'Color','r','DisplayName',dotBFName{ii});
end

index = 0;
ind = 1;
for ii = 1:length(rCentroid)
    if mod(ii,3) == 1
        index = index + 1;
        ind = 1;
    end
    plot3(...
       [rCentroid(1,ii) rCentroid(1,ii)+d(ii)*uCentroid(1,ii)],...
       [rCentroid(2,ii) rCentroid(2,ii)+d(ii)*uCentroid(2,ii)],...
       [rCentroid(3,ii) rCentroid(3,ii)+d(ii)*uCentroid(3,ii)],...
       'LineStyle','--','LineWidth',1,'Color',colors{ind},'DisplayName',rayNames{ind});

    startPt = (rCentroid(:,ii) + uCentroid(:,ii)*d(ii));
    name = strcat('Error',rayNames{ind});
%     plot3(...
%        [startPt(1) startPt(1)+errVec(1,ii)],...
%        [startPt(2) startPt(2)+errVec(2,ii)],...
%        [startPt(3) startPt(3)+errVec(3,ii)],...
%        'LineStyle','--','LineWidth',1,'Color',colors{ind},'DisplayName',name);
   
   ind = ind + 1;
end


axis equal
xlabel('x')
ylabel('y')
zlabel('z')


