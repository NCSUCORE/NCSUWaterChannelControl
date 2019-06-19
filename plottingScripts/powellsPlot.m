function [figHandle] = powellsPlot(CoMPos, EulAng_rad, rCentroid, ...
    uCentroid, figNum)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% close all

rayLength = 50;

% cameraPosVecs   = {'sideCamPosVec_cm','botCamPosVec_cm','slntCamPosVec_cm'};
cameraNames     = {'Camera 3','Camera 4','Camera 5'};
unitVecNames    = {'cam1Dot1UnitVec','cam1Dot2UnitVec','cam1Dot3UnitVec'};
rayInVecNames   = {'cam1Dot1InVec','cam1Dot2InVec','cam1Dot3InVec'};
% rayOutVecNames = {'rogGSide','rogGBotA','rogGBotB','rogGSlant'};
% dotVecBFNames  = {'sideDotPosVec_cm','botADotPosVec_cm','botBDotPosVec_cm'};
dotBFName = {'portDot','starboardDot','aftDot'};
rayNames = {'Port Dot Ray','Starboard Dot Ray','Aft Dot Ray'};
marker = {'o','*','+','.'};
names = {'x','y','z'}; 
line = {'-','--',':'};
colors = {'c','m','k'};
index = 0;

figHandle = figure(figNum);
set(gca,'NextPlot','add')
for ii = 1:length(cameraNames)
    scatter3(...
       snells(ii).camPosVec(1),...
       snells(ii).camPosVec(2),...
       snells(ii).camPosVec(3),...
       'Marker',marker{index},'CData',[0 0 0],'DisplayName',cameraNames{index});
    
    index = index + 1;
end


for ii = 1:length(unitVecNames)
    if mod(ii,3) == 1
        index = index + 1;
        ind = 1;
    end
    scatter3(...
       rCentroid(1,ii),...
       rCentroid(2,ii),...
       rCentroid(3,ii),...
       'Marker',marker{index},'CData',[0 0 1],'DisplayName',rayInVecNames{ii});

    plot3(...
       [rCentroid(1,ii) rCentroid(1,ii)+rayLength*uCentroid(1,ii)],...
       [rCentroid(2,ii) rCentroid(2,ii)+rayLength*uCentroid(2,ii)],...
       [rCentroid(3,ii) rCentroid(3,ii)+rayLength*uCentroid(3,ii)],...
       'LineStyle','--','LineWidth',1,'Color',colors{ind},'DisplayName',rayNames{ind});

   ind = ind + 1;
end

scatter3(...
        CoMPos(1),...
        CoMPos(2),...
        CoMPos(3),...
        'Marker','x','CData',[0 0 1],'DisplayName','CoM Pos');

RGB = calculateRotationMatrix(EulAng_rad(1),EulAng_rad(2),EulAng_rad(3));
RBG = RGB';

for ii = 1:length(dotBFName)
%     scatter3(...
%         snells(ii).bodyFixedVec(1),...
%         snells(ii).bodyFixedVec(2),...
%         snells(ii).bodyFixedVec(3),...
%         'Marker','o','CData',[0 1 0],'DisplayName','Dot Pos');
    
    dotVecGF = RBG * snells(ii).bodyFixedVec;
    
    plot3(...
        [CoMPos(1) CoMPos(1)+dotVecGF(1)],...
        [CoMPos(2) CoMPos(2)+dotVecGF(2)],...
        [CoMPos(3) CoMPos(3)+dotVecGF(3)],...
       'LineStyle',line{ii},'LineWidth',1,'Color','r','DisplayName',dotBFName{ii});
end

for ii = 1:length(dotBFName)
    plot3(...
        [CoMPos(1) CoMPos(1)+10*RBG(1,ii)],...
        [CoMPos(2) CoMPos(2)+10*RBG(2,ii)],...
        [CoMPos(3) CoMPos(3)+10*RBG(3,ii)],...
       'LineStyle',line{ii},'LineWidth',1,'Color','g','DisplayName',names{ii});
end

legend
grid on
axis equal
axis square
xlabel('x')
ylabel('y')
zlabel('z')

end

