% Test script 1: slant camera

clear
close all
clc

% Start by testing this (plot the same thing from the diagram)
camPosVec   = [-100 0 -5]';
rolls  = [0 5]*pi/180;
pitches = [135 140]*pi/180;
colors ={[0 0 1],[1 0 0]};
for kk = 1:length(rolls)
    roll = rolls(kk);
    pitch = pitches(kk);
    yaw   = 180*pi/180;
    
    glassThickness = 2;
    
    grnd2CamRotMat = calculateRotationMatrix(roll,pitch,yaw);
    dist2Glass = 5;
    gammaH     = [-20:5:20]*pi/180;
    gammaV     = [-20:5:20]*pi/180;
    % gammaH     = 0;
    % gammaV     = 0;
    glassPlane = 'xy';
    indOfRef = [1.000293,1.52,1.333];
    
    for ii = 1:length(gammaH)
        for jj = 1:length(gammaV)
            [rOut,uOut] = ...
                rayTrace(camPosVec,grnd2CamRotMat,dist2Glass,...
                gammaH(ii),gammaV(jj),indOfRef,glassPlane,glassThickness);
            scatter3(rOut(1),rOut(2),rOut(3))
            hold on
            quiver3(rOut(1),rOut(2),rOut(3),uOut(1),uOut(2),uOut(3),'Color',colors{kk},'LineStyle','-');
            
        end
    end
    % Plot camera axes
    scatter3(camPosVec(1),camPosVec(2),camPosVec(3))
    quiver3(camPosVec(1),camPosVec(2),camPosVec(3),grnd2CamRotMat(1,1),grnd2CamRotMat(1,2),grnd2CamRotMat(1,3),'Color',[1 0 0])
    quiver3(camPosVec(1),camPosVec(2),camPosVec(3),grnd2CamRotMat(2,1),grnd2CamRotMat(2,2),grnd2CamRotMat(2,3),'Color',[1 0 0])
    quiver3(camPosVec(1),camPosVec(2),camPosVec(3),grnd2CamRotMat(3,1),grnd2CamRotMat(3,2),grnd2CamRotMat(3,3),'Color',[1 0 0])
    
    axis equal
end
