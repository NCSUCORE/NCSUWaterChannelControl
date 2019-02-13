close all
clear
clc
camera = 'slant';
format compact

dot2CamDist_cm   = 10;

imageDimensions_px = [1088 2048];

ROICentroidVec_px = imageDimensions_px/2 + [0 100] ;
camPositionVec_cm = [0 0 0];

cameraViewAngleVec_deg = [30 30];
switch camera
    case 'bottom'
        roll = 0;
        pitch = 180*pi/180;
        yaw = 180*pi/180;
    case 'side'
        roll = 0;
        pitch = 90*pi/180;
        yaw = -90*pi/180;
    case 'slant'
        roll = 0;
        pitch = 135*pi/180;
        yaw = 180*pi/180;
end


cam2GroundRotationMatrix = calculateRotationMatrix(roll,pitch,yaw)';

sim('findDotCentroidPosition_th')

simout.data



