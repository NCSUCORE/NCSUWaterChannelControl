clear
close all
clc

% Use this code for slant camera
% camPosVec_cm   = [-17 0 -5]';
% roll   = 0  *pi/180;
% pitch  = 135*pi/180;
% yaw    = 180*pi/180;
% glassPlane     = 1; % 1 for xy 2 for xz

% Use these settings for the side camera
camPosVec_cm   = [-1 50 30]';
roll   = 0  *pi/180;
pitch  = 90*pi/180;
yaw    = 90*pi/180;
glassPlane     = 2; % 1 for xy 2 for xz

glassThickness = 2;
dist2Glass     = 5;
indOfRef       = [1.000293,1.52,1.333];
cameraFOV_rad  = [40 20]*pi/180;
grnd2CamRotMat = calculateRotationMatrix(roll,pitch,yaw);
lastPosVec_cm  = [5 -5 40]';
centroidPos_px = [500 2000]';
imageDims_px = [1000 2000]';

[~,rM,uM] = rayTrace(camPosVec_cm,grnd2CamRotMat,dist2Glass,...
    0,0,    indOfRef,glassPlane,glassThickness);

[snellPos_cm] = snellDotPosition(...
    centroidPos_px,lastPosVec_cm,...
    rM,uM,camPosVec_cm,grnd2CamRotMat,cameraFOV_rad,...
    imageDims_px,dist2Glass,indOfRef,glassPlane,glassThickness)

sim('snellDotPosition_th')
simout.data'
