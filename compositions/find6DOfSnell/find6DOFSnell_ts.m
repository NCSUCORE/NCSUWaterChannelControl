clc;clear;

loadParams;
load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_02_Jul_2019_11_35_17.mat')

marker = {'o','*','+','.'};
names = {'x','y','z'}; 
line = {'-','--',':'};
colors = {'c','m','r','y'};
index = 1;

% close all

timeIndex = 195;
rayLength = 50;

cameraPosVecs   = {'sideCamPosVec_cm','botCamPosVec_cm','prscpeCamPosVec_cm'};
unitVecNames    = {'uCentroidSide','uCentroidBotA','uCentroidBotB','uCentroidSlant'};
rayBaseVecNames = {'rCentroidSide','rCentroidBotA','rCentroidBotB','rCentroidSlant'};
rayOutVecNames = {'rogGSide','rogGBotA','rogGBotB','rogGSlant'};
dotPosVecNames  = {'sideDotPos_cm','botADotPos_cm','botBDotPos_cm','topDotPos_cm'};
dotVecBFNames  = {'sideDotPosVec_cm','botADotPosVec_cm','botBDotPosVec_cm','topDotPosVec_cm'};

figure(1)
set(gca,'NextPlot','add')
for ii = 1:length(unitVecNames)
    scatter3(...
       tsc.(rayOutVecNames{ii}).Data(1,:,timeIndex),...
       tsc.(rayOutVecNames{ii}).Data(2,:,timeIndex),...
       tsc.(rayOutVecNames{ii}).Data(3,:,timeIndex),...
       'Marker','o','CData',[1 0 0],'DisplayName','Ray Outside');
    scatter3(...
       tsc.(rayBaseVecNames{ii}).Data(1,:,timeIndex),...
       tsc.(rayBaseVecNames{ii}).Data(2,:,timeIndex),...
       tsc.(rayBaseVecNames{ii}).Data(3,:,timeIndex),...
       'Marker','o','CData',[0 0 1],'DisplayName','Ray Inside');
   plot3(...
       [tsc.(rayBaseVecNames{ii}).Data(1,:,timeIndex) tsc.(rayBaseVecNames{ii}).Data(1,:,timeIndex)+rayLength*tsc.(unitVecNames{ii}).Data(1,:,timeIndex)],...
       [tsc.(rayBaseVecNames{ii}).Data(2,:,timeIndex) tsc.(rayBaseVecNames{ii}).Data(2,:,timeIndex)+rayLength*tsc.(unitVecNames{ii}).Data(2,:,timeIndex)],...
       [tsc.(rayBaseVecNames{ii}).Data(3,:,timeIndex) tsc.(rayBaseVecNames{ii}).Data(3,:,timeIndex)+rayLength*tsc.(unitVecNames{ii}).Data(3,:,timeIndex)],...
       'LineStyle','--','LineWidth',1,'Color','k','DisplayName','Ray Line');
end

for ii = 1:length(cameraPosVecs)
    scatter3(...
       params.(cameraPosVecs{ii}).Value(1),...
       params.(cameraPosVecs{ii}).Value(2),...
       params.(cameraPosVecs{ii}).Value(3),...
       'Marker','o','CData',[0 0 0],'DisplayName','Cam Pos');
end

CoMPosVec = tsc.CoMPosVec_cm.Data(:,:,end);
scatter3(...
        CoMPosVec(1),...
        CoMPosVec(2),...
        CoMPosVec(3),...
        'Marker','x','CData',[0 0 1],'DisplayName','CoM Pos');
    

for ii = 1:length(dotPosVecNames)
    scatter3(...
        tsc.(dotPosVecNames{ii}).Data(1,:,timeIndex),...
        tsc.(dotPosVecNames{ii}).Data(2,:,timeIndex),...
        tsc.(dotPosVecNames{ii}).Data(3,:,timeIndex),...
        'Marker','o','CData',[0 1 0],'DisplayName','Dot Pos');
    plot3(...
        [CoMPosVec(1) tsc.(dotPosVecNames{ii}).Data(1,:,timeIndex)],...
        [CoMPosVec(2) tsc.(dotPosVecNames{ii}).Data(2,:,timeIndex)],...
        [CoMPosVec(3) tsc.(dotPosVecNames{ii}).Data(3,:,timeIndex)],...
       'LineStyle','--','LineWidth',1,'Color',colors{ii},'DisplayName','CoM to Dot');
end

scatter3(0,0,0,'Marker','o','CData',[1 0 0],'DisplayName','Origin')
set(gcf,'Position',1e3*[1.9210   -0.1750    1.9200    0.9648])
view([-123.1018 24.7266])
legend

EulAng_rad = [0 0 0]';
RGB = calculateRotationMatrix(EulAng_rad(1),EulAng_rad(2),EulAng_rad(3));
RBG = RGB';

% for ii = 1:length(dotVecBFNames)   
%     dotVecGF = RBG * params.(dotVecBFNames{ii}).Value';
%     
%     plot3(...
%         [CoMPosVec(1) CoMPosVec(1)+dotVecGF(1)],...
%         [CoMPosVec(2) CoMPosVec(2)+dotVecGF(2)],...
%         [CoMPosVec(3) CoMPosVec(3)+dotVecGF(3)],...
%        'LineStyle','--','LineWidth',1,'Color',colors{ii},'DisplayName',dotVecBFNames{ii});
% end

grid on
axis equal
xlabel('x')
ylabel('y')
zlabel('z')

% norm(tsc.rogGSide.Data(:,:,end) - params.sideCamPosVec_cm.Value')
% norm(tsc.rogGBotA.Data(:,:,end) - params.botCamPosVec_cm.Value')
% norm(tsc.rogGBotB.Data(:,:,end) - params.botCamPosVec_cm.Value')
% norm(tsc.rogGSlant.Data(:,:,end) - params.slntCamPosVec_cm.Value')