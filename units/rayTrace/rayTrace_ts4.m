% close all
clc; clear;
format compact

loadParams;
createSnellsMinParams;
% load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_23_May_2019_11_20_54.mat');
% load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_29_May_2019_14_39_58.mat')
load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_18_Jun_2019_16_49_03.mat')

%% Side
% clc;

% loadParams;
% load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_22_May_2019_18_55_30.mat');
timeIndex = 800;

camPosVec         = params.sideCamPosVec_cm.Value;
% roll_deg          = tsc.roll_rad.data(end)*180/pi;
% pitch_deg         = tsc.pitch_rad.data(end)*180/pi;
% yaw_deg           = tsc.yaw_rad.data(end)*180/pi;
camEulerAngles_deg = params.sideCamEulAng_deg.Value;
glassThickness    = params.glassThickness_cm.Value;
dist2Glass        = params.sideDistancetoGlass_cm.Value;
glassPlane        = 2;
indOfRef          = params.indexOfRefractionAGW.Value;
imageDims_px      = params.sideImageSize_px.Value;
cameraFOV_deg     = params.cameraFOV_deg.Value;
pixCoords         = tsc.sideDotCoords.data(:,:,timeIndex);
pixelRow          = mean([pixCoords(1) pixCoords(3)]);
pixelCol          = mean([pixCoords(2) pixCoords(4)]);
rayLength         = 50;
camEulAngles_rad = camEulerAngles_deg*pi/180;
grnd2CamRotMat = calculateRotationMatrix(....
    camEulAngles_rad(1),camEulAngles_rad(2),camEulAngles_rad(3));

sim('rayTrace_th')

% camPosVec
rogG_th = rogG.Data
rogG_tsc = tsc.rogGSide.Data(:,:,timeIndex)'
rigG_th = rigG.Data
rigG_tsc = tsc.rCentroidSide.Data(:,:,timeIndex)'
uiG_th = uiG.Data
uiG_tsc = tsc.uCentroidSide.Data(:,:,timeIndex)'
fprintf('\n\n');
% rocC_th = rocC.Data
% rocC_m = tsc.rocCSide.Data(:,:,end)'
% rioC_th = rioC.Data
% rioC_m = tsc.rioCSide.Data(:,:,end)'
% 
% dist2Glass
% glassDist = norm(rogG_th - camPosVec)
% 
% gammaH_th = gammaH.Data
% gammaH_m = tsc.gammaHSide.Data(end)
% 
% gammaV_th = gammaV.Data
% gammaV_m = tsc.gammaVSide.Data(end)
% 
figure(2)
set(gca,'NextPlot','add')
scatter3(...
       rogG.Data(1),rogG.Data(2),rogG.Data(3),...
       'Marker','o','CData',[0 1 0],'DisplayName','Ray Base');
scatter3(...
       rigG.Data(1),rigG.Data(2),rigG.Data(3),...
       'Marker','o','CData',[0 0 1],'DisplayName','Ray Base');
plot3(...
   [rigG.Data(1) rigG.Data(1)+rayLength*uiG.Data(1)],...
   [rigG.Data(2) rigG.Data(2)+rayLength*uiG.Data(2)],...
   [rigG.Data(3) rigG.Data(3)+rayLength*uiG.Data(3)],...
   'LineStyle','--','LineWidth',1,'Color','k','DisplayName','Ray Line');

scatter3(...
   camPosVec(1),camPosVec(2),camPosVec(3),...
   'Marker','o','CData',[0 0 0],'DisplayName','Cam Pos');

%% Bottom
% clc;

% loadParams;
% load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_22_May_2019_18_55_30.mat');
% timeIndex = 500;

camPosVec         = params.botCamPosVec_cm.Value;
% roll_deg          = tsc.roll_rad.data(end)*180/pi;
% pitch_deg         = tsc.pitch_rad.data(end)*180/pi;
% yaw_deg           = tsc.yaw_rad.data(end)*180/pi;
camEulerAngles_deg = params.botCamEulAng_deg.Value;
glassThickness    = params.glassThickness_cm.Value;
dist2Glass        = params.botDistancetoGlass_cm.Value;
glassPlane        = 1;
indOfRef          = params.indexOfRefractionAGW.Value;
imageDims_px      = params.sideImageSize_px.Value;
cameraFOV_deg     = params.cameraFOV_deg.Value;
pixCoords         = tsc.botDotCoords.data(:,:,timeIndex);
pixelRow          = mean([pixCoords(1) pixCoords(3)]);
pixelCol          = mean([pixCoords(2) pixCoords(4)]);
rayLength         = 50;
camEulAngles_rad = camEulerAngles_deg*pi/180;
grnd2CamRotMat = calculateRotationMatrix(....
    camEulAngles_rad(1),camEulAngles_rad(2),camEulAngles_rad(3));

sim('rayTrace_th')

% camPosVec
rogG_thA = rogG.Data
rogG_tscA = tsc.rogGBotB.Data(:,:,end)'
rigG_thA = rigG.Data
rigG_tscA = tsc.rCentroidBotA.Data(:,:,end)'
uiG_thA = uiG.Data
uiG_tscA = tsc.uCentroidBotA.Data(:,:,end)'
fprintf('\n\n');

% rocC_th = rocC.Data
% rocC_m = tsc.rocCBotA.Data(:,:,end)'
% rioC_th = rioC.Data
% rioC_m = tsc.rioCBotA.Data(:,:,end)'
% 
% dist2Glass
% glassDist = norm(rogG_thA - camPosVec)
% 
% gammaH_th = gammaH.Data
% gammaH_m = tsc.gammaHBotA.Data(end)
% 
% gammaV_th = gammaV.Data
% gammaV_m = tsc.gammaVBotA.Data(end)
% 
% figure(1)
set(gca,'NextPlot','add')
scatter3(...
       rogG.Data(1),rogG.Data(2),rogG.Data(3),...
       'Marker','o','CData',[0 1 0],'DisplayName','Ray Base');
scatter3(...
       rigG.Data(1),rigG.Data(2),rigG.Data(3),...
       'Marker','o','CData',[0 0 1],'DisplayName','Ray Base');
plot3(...
   [rigG.Data(1) rigG.Data(1)+rayLength*uiG.Data(1)],...
   [rigG.Data(2) rigG.Data(2)+rayLength*uiG.Data(2)],...
   [rigG.Data(3) rigG.Data(3)+rayLength*uiG.Data(3)],...
   'LineStyle','--','LineWidth',1,'Color','k','DisplayName','Ray Line');

scatter3(...
   camPosVec(1),camPosVec(2),camPosVec(3),...
   'Marker','o','CData',[0 0 0],'DisplayName','Cam Pos');

pixelRow          = mean([pixCoords(5) pixCoords(7)]);
pixelCol          = mean([pixCoords(6) pixCoords(8)]);

sim('rayTrace_th')

% camPosVec
rogG_thB = rogG.Data
rogG_tscB = tsc.rogGBotB.Data(:,:,end)'
rigG_thB = rigG.Data
rigG_tscB = tsc.rCentroidBotB.Data(:,:,end)'
uiG_thB = uiG.Data
uiG_tscB = tsc.uCentroidBotB.Data(:,:,end)'
fprintf('\n\n');

% rocC_th = rocC.Data
% rocC_m = tsc.rocCBotB.Data(:,:,end)'
% rioC_th = rioC.Data
% rioC_m = tsc.rioCBotB.Data(:,:,end)'

% dist2Glass
% glassDist = norm(rogG_thB - camPosVec)
% 
% gammaH_th = gammaH.Data
% gammaH_m = tsc.gammaHBotB.Data(end)
% 
% gammaV_th = gammaV.Data
% gammaV_m = tsc.gammaVBotB.Data(end)
% 
% figure(1)
set(gca,'NextPlot','add')
scatter3(...
       rogG.Data(1),rogG.Data(2),rogG.Data(3),...
       'Marker','o','CData',[0 1 0],'DisplayName','Ray Base');
scatter3(...
       rigG.Data(1),rigG.Data(2),rigG.Data(3),...
       'Marker','o','CData',[0 0 1],'DisplayName','Ray Base');
plot3(...
   [rigG.Data(1) rigG.Data(1)+rayLength*uiG.Data(1)],...
   [rigG.Data(2) rigG.Data(2)+rayLength*uiG.Data(2)],...
   [rigG.Data(3) rigG.Data(3)+rayLength*uiG.Data(3)],...
   'LineStyle','--','LineWidth',1,'Color','k','DisplayName','Ray Line');

scatter3(...
   camPosVec(1),camPosVec(2),camPosVec(3),...
   'Marker','o','CData',[0 0 0],'DisplayName','Cam Pos');

%% Slant
% clc;

% loadParams;
% load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_22_May_2019_18_55_30.mat');
% timeIndex = 500;

camPosVec         = params.slntCamPosVec_cm.Value;
% roll_deg          = tsc.roll_rad.data(end)*180/pi;
% pitch_deg         = tsc.pitch_rad.data(end)*180/pi;
% yaw_deg           = tsc.yaw_rad.data(end)*180/pi;
camEulerAngles_deg = params.slntCamEulAng_deg.Value;
glassThickness    = params.glassThickness_cm.Value;
dist2Glass        = params.slntDistancetoGlass_cm.Value;
glassPlane        = 1;
indOfRef          = params.indexOfRefractionAGW.Value;
imageDims_px      = params.sideImageSize_px.Value;
cameraFOV_deg     = params.cameraFOV_deg.Value;
pixCoords         = tsc.slantDotCoords.data(:,:,timeIndex);
pixelRow          = mean([pixCoords(1) pixCoords(3)]);
pixelCol          = mean([pixCoords(2) pixCoords(4)]);
rayLength         = 50;
camEulAngles_rad = camEulerAngles_deg*pi/180;
grnd2CamRotMat = calculateRotationMatrix(....
    camEulAngles_rad(1),camEulAngles_rad(2),camEulAngles_rad(3));

sim('rayTrace_th')

% camPosVec
rogG_th = rogG.Data
rogG_tsc = tsc.rogGSlant.Data(:,:,timeIndex)'
rigG_th = rigG.Data
rigG_tsc = tsc.rCentroidSlant.Data(:,:,timeIndex)'
uiG_th = uiG.Data
uiG_tsc = tsc.uCentroidSlant.Data(:,:,timeIndex)'
% rocC_th = rocC.Data
% rocC_m = tsc.rocCSlant.Data(:,:,timeIndex)'
% rioC_th = rioC.Data
% rioC_m = tsc.rioCSlant.Data(:,:,timeIndex)'

% dist2Glass
% glassDist = norm(rogG_th - camPosVec)
% 
% gammaH_th = gammaH.Data
% gammaH_m = tsc.gammaHSlant.Data(end)
% 
% gammaV_th = gammaV.Data
% gammaV_m = tsc.gammaVSlant.Data(end)
% 
% figure(1)
set(gca,'NextPlot','add')
scatter3(...
       rogG.Data(1),rogG.Data(2),rogG.Data(3),...
       'Marker','o','CData',[0 1 0],'DisplayName','Ray Base');
scatter3(...
       rigG.Data(1),rigG.Data(2),rigG.Data(3),...
       'Marker','o','CData',[0 0 1],'DisplayName','Ray Base');
plot3(...
   [rigG.Data(1) rigG.Data(1)+rayLength*uiG.Data(1)],...
   [rigG.Data(2) rigG.Data(2)+rayLength*uiG.Data(2)],...
   [rigG.Data(3) rigG.Data(3)+rayLength*uiG.Data(3)],...
   'LineStyle','--','LineWidth',1,'Color','k','DisplayName','Ray Line');

scatter3(...
   camPosVec(1),camPosVec(2),camPosVec(3),...
   'Marker','o','CData',[0 0 0],'DisplayName','Cam Pos');

legend
grid on
axis equal
axis square
xlabel('x')
ylabel('y')
zlabel('z')

%% Bottom Cam
clc; clear;

createSnellsMinParams;
createRayTraceCtrlBus;
createCoordinateCtrlBus;
loadParams;
load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_19_Jun_2019_11_56_45.mat')
timeIndex = 1000;

camPosVec         = snells(7).camPosVec;
% roll_deg          = tsc.roll_rad.data(end)*180/pi;
% pitch_deg         = tsc.pitch_rad.data(end)*180/pi;
% yaw_deg           = tsc.yaw_rad.data(end)*180/pi;
camEulerAngles_deg = snells(7).camEulAng;
glassThickness    = params.glassThickness_cm.Value;
dist2Glass        = 3.4;
glassPlane        = 1;
indOfRef          = params.indexOfRefractionA.Value;
imageDims_px      = params.sideImageSize_px.Value;
cameraFOV_deg     = params.cameraFOV_deg.Value;
pixCoords         = tsc.cam3DotPos.data(1:2,:,timeIndex);
pixelRow          = pixCoords(1);
pixelCol          = pixCoords(2);
rayLength         = 50;
camEulAngles_rad = camEulerAngles_deg*pi/180;
grnd2CamRotMat = calculateRotationMatrix(....
    camEulAngles_rad(1),camEulAngles_rad(2),camEulAngles_rad(3));

sim('rayTrace_th')

timeStart = 995;
timeEnd = 1000;
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

sim('find6DOFSnellMin9_th')

% camPosVec
rogG_th = rogG.Data
rogG_tsc = tsc.cam3Dot1OutVec.Data(:,:,timeIndex)'
rogG_off = cam3Dot1OutVec.Data(:,:,len)'
rigG_th = rigG.Data
rigG_tsc = tsc.cam3Dot1InVec.Data(:,:,timeIndex)'
rigG_off = cam3Dot1InVec.Data(:,:,len)'
uiG_th = uiG.Data
uiG_tsc = tsc.cam3Dot1UnitVec.Data(:,:,timeIndex)'
uiG_off = cam3Dot1UnitVec.Data(:,:,len)'
% rocC_th = rocC.Data
% rocC_m = tsc.rocCSlant.Data(:,:,timeIndex)'
% rioC_th = rioC.Data
% rioC_m = tsc.rioCSlant.Data(:,:,timeIndex)'

% dist2Glass
% glassDist = norm(rogG_th - camPosVec)
% 
% gammaH_th = gammaH.Data
% gammaH_m = tsc.gammaHSlant.Data(end)
% 
% gammaV_th = gammaV.Data
% gammaV_m = tsc.gammaVSlant.Data(end)
% 
% figure(1)
set(gca,'NextPlot','add')
scatter3(...
       rogG.Data(1),rogG.Data(2),rogG.Data(3),...
       'Marker','o','CData',[0 1 0],'DisplayName','Ray Base');
scatter3(...
       rigG.Data(1),rigG.Data(2),rigG.Data(3),...
       'Marker','o','CData',[0 0 1],'DisplayName','Ray Base');
plot3(...
   [rigG.Data(1) rigG.Data(1)+rayLength*uiG.Data(1)],...
   [rigG.Data(2) rigG.Data(2)+rayLength*uiG.Data(2)],...
   [rigG.Data(3) rigG.Data(3)+rayLength*uiG.Data(3)],...
   'LineStyle','--','LineWidth',1,'Color','k','DisplayName','Ray Line');

scatter3(...
   camPosVec(1),camPosVec(2),camPosVec(3),...
   'Marker','o','CData',[0 0 0],'DisplayName','Cam Pos');

%

scatter3(...
       rogG_tsc(1),rogG_tsc(2),rogG_tsc(3),...
       'Marker','*','CData',[0 1 0],'DisplayName','Ray Base');
scatter3(...
       rigG_tsc(1),rigG_tsc(2),rigG_tsc(3),...
       'Marker','*','CData',[0 0 1],'DisplayName','Ray Base');
plot3(...
   [rigG_tsc(1) rigG_tsc(1)+rayLength*uiG_tsc(1)],...
   [rigG_tsc(2) rigG_tsc(2)+rayLength*uiG_tsc(2)],...
   [rigG_tsc(3) rigG_tsc(3)+rayLength*uiG_tsc(3)],...
   'LineStyle',':','LineWidth',1,'Color','k','DisplayName','Ray Line');

legend
grid on
axis equal
axis square
xlabel('x')
ylabel('y')
zlabel('z')
