% close all
clc; clear;
format compact

loadParams;
% load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_23_May_2019_11_20_54.mat');
% load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_29_May_2019_14_39_58.mat')
load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_12_Jun_2019_11_07_53.mat')

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

