clear
close all
clc

% Start by testing this (plot the same thing from the diagram)
camPosVec   = [-100 0 -5]';

roll  = 0;
pitch = 135*pi/180;
yaw   = 180*pi/180;

glassThickness = 2;

grnd2CamRotMat = calculateRotationMatrix(roll,pitch,yaw);
dist2Glass = 5;
gammaH     = 0;
gammaV     = 0;
glassPlane = 'xy';
indOfRef = [1.000293,1.52,1.333];

[point,direction] = ...
    rayTrace(camPosVec,grnd2CamRotMat,dist2Glass,gammaH,gammaV,indOfRef,glassPlane,glassThickness);
