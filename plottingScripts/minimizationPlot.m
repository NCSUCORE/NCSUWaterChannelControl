timeInd = 120000;

rayLength = 30;
try
    clf(figHandle)
catch
end

cameraNames     = {'Camera 3','Camera 4','Camera 5'};
unitVecNames    = {'cam1Dot1UnitVec','cam1Dot2UnitVec','cam1Dot3UnitVec',...
                   'cam2Dot1UnitVec','cam2Dot2UnitVec','cam2Dot3UnitVec',...
                   'cam3Dot1UnitVec','cam3Dot2UnitVec','cam3Dot3UnitVec'};
rayInVecNames = {'cam1Dot1InVec','cam1Dot2InVec','cam1Dot3InVec',...
                 'cam2Dot1InVec','cam2Dot2InVec','cam2Dot3InVec',...
                 'cam3Dot1InVec','cam3Dot2InVec','cam3Dot3InVec'};
rayOutVecNames = {'cam1Dot1OutVec','cam1Dot2OutVec','cam1Dot3OutVec',...
                  'cam2Dot1OutVec','cam2Dot2OutVec','cam2Dot3OutVec',...
                  'cam3Dot1OutVec','cam3Dot2OutVec','cam3Dot3OutVec'};
dotBFName = {'portDot','starboardDot','aftDot'};
marker = {'o','*','+','.'};
names = {'x','y','z'}; 
line = {'-','--',':'};
colors = {'c','m','k'};
rayNames = {'Port Dot Ray','Starboard Dot Ray','Aft Dot Ray'};

figHandle = figure(1);
set(gca,'NextPlot','add')

legend
grid on
axis equal
xlabel('x')
ylabel('y')
zlabel('z')

index = 1;
for ii = 1:3:9
    scatter3(...
       snells(ii).camPosVec(1),...
       snells(ii).camPosVec(2),...
       snells(ii).camPosVec(3),...
       'Marker',marker{index},'CData',[0 0 0],'DisplayName',cameraNames{index});
    
    index = index + 1;
end

index = 1;
for ii = 1:9
    if mod(ii,3) == 1
        index = 1;
    end
    camAng = [snells(ii).camEulAng(1) snells(ii).camEulAng(2) snells(ii).camEulAng(3)]'.*pi/180;
    camRGB = calculateRotationMatrix(camAng(1),camAng(2),camAng(3));
    camRBG = camRGB';
    
    plot3(...
        [snells(ii).camPosVec(1) snells(ii).camPosVec(1)+5*camRBG(1,index)],...
        [snells(ii).camPosVec(2) snells(ii).camPosVec(2)+5*camRBG(2,index)],...
        [snells(ii).camPosVec(3) snells(ii).camPosVec(3)+5*camRBG(3,index)],...
       'LineStyle',line{index},'LineWidth',1,'Color','m','DisplayName',names{index});
    index = index + 1;
end

tsc.CoMPos.Data(:,:,timeInd) = [5.25;-3;50];

scatter3(...
        tsc.CoMPos.Data(1,:,timeInd),...
        tsc.CoMPos.Data(2,:,timeInd),...
        tsc.CoMPos.Data(3,:,timeInd),...
        'Marker','x','CData',[0 0 1],'DisplayName','CoM Pos');

index = 0;
for ii = 1:9
    if mod(ii,3) == 1
        index = index + 1;
    end
    scatter3(...
       tsc.(rayOutVecNames{ii}).Data(1,:,timeInd),...
       tsc.(rayOutVecNames{ii}).Data(2,:,timeInd),...
       tsc.(rayOutVecNames{ii}).Data(3,:,timeInd),...
       'Marker',marker{index},'CData',[0 0 1],'DisplayName',rayOutVecNames{ii});
end

index = 0;
ind = 1;
for ii = 1:length(unitVecNames)
    if mod(ii,3) == 1
        index = index + 1;
        ind = 1;
    end
    scatter3(...
       tsc.(rayInVecNames{ii}).Data(1,:,timeInd),...
       tsc.(rayInVecNames{ii}).Data(2,:,timeInd),...
       tsc.(rayInVecNames{ii}).Data(3,:,timeInd),...
       'Marker',marker{index},'CData',[0 0 1],'DisplayName',rayInVecNames{ii});

    plot3(...
       [tsc.(rayInVecNames{ii}).Data(1,:,timeInd) tsc.(rayInVecNames{ii}).Data(1,:,timeInd)+rayLength*tsc.(unitVecNames{ii}).Data(1,:,timeInd)],...
       [tsc.(rayInVecNames{ii}).Data(2,:,timeInd) tsc.(rayInVecNames{ii}).Data(2,:,timeInd)+rayLength*tsc.(unitVecNames{ii}).Data(2,:,timeInd)],...
       [tsc.(rayInVecNames{ii}).Data(3,:,timeInd) tsc.(rayInVecNames{ii}).Data(3,:,timeInd)+rayLength*tsc.(unitVecNames{ii}).Data(3,:,timeInd)],...
       'LineStyle','--','LineWidth',1,'Color',colors{ind},'DisplayName',rayNames{ind});

   ind = ind + 1;
end

try
    EulAng_rad = [tsc.roll_rad.Data(timeInd) tsc.pitch_rad.Data(timeInd) tsc.yaw_rad.Data(timeInd)]';
    RGB = calculateRotationMatrix(EulAng_rad(1),EulAng_rad(2),EulAng_rad(3));
    RBG = RGB';
catch
end

% tsc.roll_deg.Data(timeInd) = 0;
% tsc.pitch_deg.Data(timeInd) = 0;
% tsc.yaw_deg.Data(timeInd) = 0;

try
    EulAng_rad = [tsc.roll_deg.Data(timeInd) tsc.pitch_deg.Data(timeInd) tsc.yaw_deg.Data(timeInd)]'.*pi/180;
    RGB = calculateRotationMatrix(EulAng_rad(1),EulAng_rad(2),EulAng_rad(3));
    RBG = RGB';
catch
end

EulAng_deg = EulAng_rad.*180/pi

for ii = 1:length(dotBFName)
%     scatter3(...
%         snells(ii).bodyFixedVec(1),...
%         snells(ii).bodyFixedVec(2),...
%         snells(ii).bodyFixedVec(3),...
%         'Marker','o','CData',[0 1 0],'DisplayName','Dot Pos');
    
    dotVecGF = RBG * snells(ii).bodyFixedVec;
    
    plot3(...
        [tsc.CoMPos.Data(1,:,timeInd) tsc.CoMPos.Data(1,:,timeInd)+dotVecGF(1)],...
        [tsc.CoMPos.Data(2,:,timeInd) tsc.CoMPos.Data(2,:,timeInd)+dotVecGF(2)],...
        [tsc.CoMPos.Data(3,:,timeInd) tsc.CoMPos.Data(3,:,timeInd)+dotVecGF(3)],...
       'LineStyle',line{ii},'LineWidth',1,'Color','r','DisplayName',dotBFName{ii});
end

for ii = 1:length(dotBFName)
    plot3(...
        [tsc.CoMPos.Data(1,:,timeInd) tsc.CoMPos.Data(1,:,timeInd)+10*RBG(1,ii)],...
        [tsc.CoMPos.Data(2,:,timeInd) tsc.CoMPos.Data(2,:,timeInd)+10*RBG(2,ii)],...
        [tsc.CoMPos.Data(3,:,timeInd) tsc.CoMPos.Data(3,:,timeInd)+10*RBG(3,ii)],...
       'LineStyle',line{ii},'LineWidth',1,'Color','g','DisplayName',names{ii});
end

axis equal
% axis square
