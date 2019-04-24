% Test script 2: side camera

clear
% close all
clc

% Start by testing this (plot the same thing from the diagram)
camPosVec   = [-1 -50 30]';
rolls   = [0 ]*pi/180;
pitches = [90]*pi/180;
yaws    = [90]*pi/180;
glassThickness = 2;
dist2Glass     = 5;
glassPlane     = 'xz';
indOfRef       = [1.000293,1.52,1.333];

gammaH     = [-40:5:40]'*pi/180;
gammaV     = [-26:5:26]'*pi/180;
gamma      = [...
    gammaH                         gammaV(1)*ones(size(gammaH));...
    gammaH(end)*ones(size(gammaV)) gammaV;...
    flip(gammaH)                   gammaV(end)*ones(size(gammaH));...
    gammaH(1)*ones(size(gammaV))   flip(gammaV)];
plot(gamma(:,1),gamma(:,2),'Color','r','LineWidth',2)
colors ={[0 0 1],[1 0 0]};
for kk = 1:length(rolls)
    roll  = rolls(kk);
    pitch = pitches(kk);
    yaw   = yaws(kk);
    grnd2CamRotMat = calculateRotationMatrix(roll,pitch,yaw);
    RogG = [];
    RigG = [];
    for ii = 1:length(gamma)
            [rogG,rigG,uiG] = ...
                rayTrace(camPosVec,grnd2CamRotMat,dist2Glass,...
                gamma(ii,1),gamma(ii,2),indOfRef,glassPlane,glassThickness);
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
