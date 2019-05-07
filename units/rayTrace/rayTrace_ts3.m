% Test script 1: slant camera
clear
% close all
clc

% Start by testing this (plot the same thing from the diagram)
camPosVec         = [-100 0 -5]';
roll_deg          = 0;
pitch_deg         = 135;
yaw_deg           = 180;
glassThickness    = 2;
dist2Glass        = 5;
glassPlane        = 1;
indOfRef          = [1.000293,1.52,1.333];
imageDims_px      = [1000 2000];
cameraFOV_deg     = [40 20];
gammaH = 0;
gammaV = 0;

grnd2CamRotMat = calculateRotationMatrix(....
    roll_deg*pi/180,pitch_deg*pi/180,yaw_deg*pi/180);

pixelRows     = [0:imageDims_px(1)/5:imageDims_px(1)]';
pixelCols     = [0:imageDims_px(2)/5:imageDims_px(2)]';

pixelCoords = [...
    pixelRows zeros(size(pixelRows));...
    pixelRows(end)*ones(size(pixelCols)) pixelCols;...
    flip(pixelRows) pixelCols(end)*ones(size(pixelRows));...
    pixelRows(1)*ones(size(pixelCols)) flip(pixelCols)];

[rogG,rigG,uiG,uocCRaw,uocCMag] = ...
    rayTrace_test(camPosVec,grnd2CamRotMat,dist2Glass,gammaH,gammaV,indOfRef,...
    glassPlane,glassThickness);