% Test script 1: slant camera
clear
% close all
clc

% Start by testing this (plot the same thing from the diagram)
camPosVec_cm   = [-100 0 -5]';
roll_rad   = [0  ]*pi/180;
pitch_rad = [135]*pi/180;
yaw_rad    = [180]*pi/180;
glassThickness_cm = 2;
dist2Glass_cm     = 5;
glassPlane     = 'xy';
indOfRefVec       = [1.000293,1.52,1.333];

imageDims_px = [1000 2000];
cameraFOV_deg = [40 20];

for kk = 1:length(roll_rad)
    roll_rad  = roll_rad(kk);
    pitch = pitche_rad(kk);
    yaw_rad   = yaw_rad(kk);
    grnd2CamRotMat = calculateRotationMatrix(roll_rad,pitch,yaw_rad);
    RogG = [];
    RigG =[];
    for ii = 1:length(gamma)
            [rogG,rigG,uiG] = ...
                rayTrace(camPosVec,grnd2CamRotMat,dist2Glass,...
                gamma(ii,1),gamma(ii,2),indOfRefVec,glassPlane,glassThickness);
            RogG(end+1,:)=rogG';
            RigG(end+1,:)=rigG';
            r = [camPosVec';rogG';rigG'];
            plot3(r(:,1),r(:,2),r(:,3),'LineStyle','-')
            hold on
            scatter3(r(:,1),r(:,2),r(:,3))
            quiver3(rigG(1),rigG(2),rigG(3),dist2Glass*uiG(1),dist2Glass*uiG(2),dist2Glass*uiG(3),'Color',colors{kk},'LineStyle','-');
    end
    % Plot the glass inside and outside planes
    plot3(RogG(:,1),RogG(:,2),RogG(:,3),'LineWidth',2,'Color','g','LineStyle','-')
    plot3(RigG(:,1),RigG(:,2),RigG(:,3),'LineWidth',2,'Color','b','LineStyle','-')
    
    % Plot camera axes
    scatter3(camPosVec(1),camPosVec(2),camPosVec(3))
    quiver3(camPosVec(1),camPosVec(2),camPosVec(3),grnd2CamRotMat(1,1),grnd2CamRotMat(1,2),grnd2CamRotMat(1,3),'Color',[1 0 0])
    quiver3(camPosVec(1),camPosVec(2),camPosVec(3),grnd2CamRotMat(2,1),grnd2CamRotMat(2,2),grnd2CamRotMat(2,3),'Color',[1 0 0])
    quiver3(camPosVec(1),camPosVec(2),camPosVec(3),grnd2CamRotMat(3,1),grnd2CamRotMat(3,2),grnd2CamRotMat(3,3),'Color',[1 0 0])
    
    axis equal
end
