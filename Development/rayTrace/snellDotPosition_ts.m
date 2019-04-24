clear
close all
clc

camPosVec_cm   = [-17 0 -5]';
roll   = 0  *pi/180;
pitch  = 135*pi/180;
yaw    = 180*pi/180;
glassThickness = 2;
dist2Glass     = 5;
glassPlane     = 'xy';
indOfRef       = [1.000293,1.52,1.333];
cameraFOV_rad  = [40 20]*pi/180;
grnd2CamRotMat = calculateRotationMatrix(roll,pitch,yaw);
lastPosVec_cm  = [5 -5 40]';


gammaH = cameraFOV_rad(1);
gammaV = cameraFOV_rad(2);

[~,rM,uM] = rayTrace(camPosVec_cm,grnd2CamRotMat,dist2Glass,...
    0,0,...
    indOfRef,glassPlane,glassThickness);

[~,rTL,uTL] = rayTrace(camPosVec_cm,grnd2CamRotMat,dist2Glass,...
    -gammaH,gammaV,...
    indOfRef,glassPlane,glassThickness);

[~,rTR,uTR] = rayTrace(camPosVec_cm,grnd2CamRotMat,dist2Glass,...
    gammaH,gammaV,...
    indOfRef,glassPlane,glassThickness);

[~,rBL,uBL] = rayTrace(camPosVec_cm,grnd2CamRotMat,dist2Glass,...
    -gammaH,-gammaV,...
    indOfRef,glassPlane,glassThickness);

[~,rBR,uBR] = rayTrace(camPosVec_cm,grnd2CamRotMat,dist2Glass,...
    gammaH,-gammaV,...
    indOfRef,glassPlane,glassThickness);

[snellPos_cm] = snellDotPosition(rM,uM,rTL,uTL,rBL,uBL,rTR,uTR,rBR,uBR,...
    lastPosVec_cm,camPosVec_cm,grnd2CamRotMat);