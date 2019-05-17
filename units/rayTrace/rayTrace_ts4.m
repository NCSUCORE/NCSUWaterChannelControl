close all
clc
format compact

%% Side

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
pixCoords         = tsc.sideDotCoords.data(:,:,end);
pixelRow          = tsc.pixelRowSide.Data(end);
pixelCol          = tsc.pixelColSide.Data(end);
rayLength         = 50;
camEulAngles_rad = camEulerAngles_deg*pi/180;
grnd2CamRotMat = calculateRotationMatrix(....
    camEulAngles_rad(1),camEulAngles_rad(2),camEulAngles_rad(3));

sim('rayTrace_th')

camPosVec
rogG_th = rogG.Data
rogG_m = tsc.rogGSide.Data(:,:,end)'
rigG_th = rigG.Data
rigG_m = tsc.rCentroidSide.Data(:,:,end)'
uiG_th = uiG.Data
uiG_m = tsc.uCentroidSide.Data(:,:,end)'
rocC_th = rocC.Data
rocC_m = tsc.rocCSide.Data(:,:,end)'
rioC_th = rioC.Data
rioC_m = tsc.rioCSide.Data(:,:,end)'

dist2Glass
glassDist = norm(rogG_th - camPosVec)

gammaH_th = gammaH.Data
gammaH_m = tsc.gammaHSide.Data(end)

gammaV_th = gammaV.Data
gammaV_m = tsc.gammaVSide.Data(end)

figure(1)
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
pixCoords         = tsc.botDotCoords.data(:,:,end);
pixelRow          = tsc.pixelRowBotA.Data(end);
pixelCol          = tsc.pixelColBotA.Data(end);
rayLength         = 50;
camEulAngles_rad = camEulerAngles_deg*pi/180;
grnd2CamRotMat = calculateRotationMatrix(....
    camEulAngles_rad(1),camEulAngles_rad(2),camEulAngles_rad(3));

sim('rayTrace_th')

camPosVec
rogG_thA = rogG.Data
rogG_mA = tsc.rogGBotB.Data(:,:,end)'
rigG_thA = rigG.Data
rigG_mA = tsc.rCentroidBotA.Data(:,:,end)'
uiG_thA = uiG.Data
rogG_mA = tsc.uCentroidBotA.Data(:,:,end)'
rocC_th = rocC.Data
rocC_m = tsc.rocCBotA.Data(:,:,end)'
rioC_th = rioC.Data
rioC_m = tsc.rioCBotA.Data(:,:,end)'

dist2Glass
glassDist = norm(rogG_thA - camPosVec)

gammaH_th = gammaH.Data
gammaH_m = tsc.gammaHBotA.Data(end)

gammaV_th = gammaV.Data
gammaV_m = tsc.gammaVBotA.Data(end)

figure(1)
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

pixelRow          = tsc.pixelRowBotB.Data(end);
pixelCol          = tsc.pixelColBotB.Data(end);

sim('rayTrace_th')

camPosVec
rogG_thB = rogG.Data
rogG_mB = tsc.rogGBotB.Data(:,:,end)'
rigG_thB = rigG.Data
rigG_mB = tsc.rCentroidBotB.Data(:,:,end)'
uiG_thB = uiG.Data
rogG_mB = tsc.uCentroidBotB.Data(:,:,end)'
rocC_th = rocC.Data
rocC_m = tsc.rocCBotB.Data(:,:,end)'
rioC_th = rioC.Data
rioC_m = tsc.rioCBotB.Data(:,:,end)'

dist2Glass
glassDist = norm(rogG_thB - camPosVec)

gammaH_th = gammaH.Data
gammaH_m = tsc.gammaHBotB.Data(end)

gammaV_th = gammaV.Data
gammaV_m = tsc.gammaVBotB.Data(end)

figure(1)
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
pixCoords         = tsc.slantDotCoords.data(:,:,end);
pixelRow          = tsc.pixelRowSlant.Data(end);
pixelCol          = tsc.pixelColSlant.Data(end);
rayLength         = 50;
camEulAngles_rad = camEulerAngles_deg*pi/180;
grnd2CamRotMat = calculateRotationMatrix(....
    camEulAngles_rad(1),camEulAngles_rad(2),camEulAngles_rad(3));

sim('rayTrace_th')

camPosVec
rogG_th = rogG.Data
rogG_m = tsc.rogGSlant.Data(:,:,end)'
rigG_th = rigG.Data
rigG_m = tsc.rCentroidSlant.Data(:,:,end)'
uiG_th = uiG.Data
uiG_m = tsc.uCentroidSlant.Data(:,:,end)'
rocC_th = rocC.Data
rocC_m = tsc.rocCSlant.Data(:,:,end)'
rioC_th = rioC.Data
rioC_m = tsc.rioCSlant.Data(:,:,end)'

dist2Glass
glassDist = norm(rogG_th - camPosVec)

gammaH_th = gammaH.Data
gammaH_m = tsc.gammaHSlant.Data(end)

gammaV_th = gammaV.Data
gammaV_m = tsc.gammaVSlant.Data(end)

figure(1)
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

