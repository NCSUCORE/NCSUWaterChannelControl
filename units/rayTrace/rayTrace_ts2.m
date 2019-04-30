% Test script 2: side camera

clear
% close all
clc

% Start by testing this (plot the same thing from the diagram)
camPosVec_cm      = [-1 -50 30]';
roll_deg          = 0;
pitch_deg         = 90;
yaw_deg           = 90;
glassThickness_cm = 2;
dist2Glass_cm     = 5;
glassPlane        = 2;
indOfRefVec       = [1.000293,1.52,1.333];
imageDims_px      = [1000 2000];
cameraFOV_deg     = [40 20];

grnd2CamRotMat = calculateRotationMatrix(....
    roll_deg*pi/180,pitch_deg*pi/180,yaw_deg*pi/180);

pixelRows     = [0:imageDims_px(1)/5:imageDims_px(1)]';
pixelCols     = [0:imageDims_px(2)/5:imageDims_px(2)]';

pixelCoords = [...
    pixelRows zeros(size(pixelRows));...
    pixelRows(end)*ones(size(pixelCols)) pixelCols;...
    flip(pixelRows) pixelCols(end)*ones(size(pixelRows));...
    pixelRows(1)*ones(size(pixelCols)) flip(pixelCols)];

figure
colors ={[0 0 1],[1 0 0]};
RogG = [];
RigG = [];
for ii = 1:length(pixelCoords)
    pixelRow = pixelCoords(ii,1);
    pixelCol = pixelCoords(ii,2);
     
    sim('rayTrace_th')
    RogG(end+1,:)=rogG.data;
    RigG(end+1,:)=rigG.data;

    r = [camPosVec_cm';rogG.data;rigG.data];
    plot3(r(:,1),r(:,2),r(:,3),'LineStyle','-')
    hold on
    scatter3(r(:,1),r(:,2),r(:,3))
    quiver3(rigG.data(1),rigG.data(2),rigG.data(3),...
        dist2Glass_cm*uiG.data(1),dist2Glass_cm*uiG.data(2),dist2Glass_cm*uiG.data(3),'LineStyle','-');
    drawnow
end
% Plot the glass inside and outside planes
plot3(RogG(:,1),RogG(:,2),RogG(:,3),'LineWidth',2,'Color','g','LineStyle','-')
plot3(RigG(:,1),RigG(:,2),RigG(:,3),'LineWidth',2,'Color','b','LineStyle','-')

% Plot camera axes
scatter3(camPosVec_cm(1),camPosVec_cm(2),camPosVec_cm(3))
quiver3(camPosVec_cm(1),camPosVec_cm(2),camPosVec_cm(3),grnd2CamRotMat(1,1),grnd2CamRotMat(1,2),grnd2CamRotMat(1,3),'Color',[1 0 0])
quiver3(camPosVec_cm(1),camPosVec_cm(2),camPosVec_cm(3),grnd2CamRotMat(2,1),grnd2CamRotMat(2,2),grnd2CamRotMat(2,3),'Color',[1 0 0])
quiver3(camPosVec_cm(1),camPosVec_cm(2),camPosVec_cm(3),grnd2CamRotMat(3,1),grnd2CamRotMat(3,2),grnd2CamRotMat(3,3),'Color',[1 0 0])
axis equal

