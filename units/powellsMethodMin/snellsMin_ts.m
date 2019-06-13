% clc;clear;
loadParams;
% load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_22_May_2019_18_55_30.mat');
% load('C:\Users\mcobb\Google Drive\Mitchell-Research\NCSUWaterChannelControl\output\data\data_22_May_2019_18_55_30.mat');

load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_12_Jun_2019_11_07_53.mat')

format compact
x0 = [0 0 0]';

% timeIndex = 500;

timeStart = 800;
timeEnd = 800;

length = timeEnd - timeStart;

EulAng = cell(length,1);
actualAng = cell(length,1);
errorCoM = cell(length,1);
errorEul = cell(length,1);
index = 1;

% lineSearch = 'GoldenSection';

for timeIndex = timeStart:timeEnd

    rCentroid1 = tsc.rCentroidSide.Data(:,:,timeIndex);
    rCentroid2 = tsc.rCentroidBotA.Data(:,:,timeIndex);
    rCentroid3 = tsc.rCentroidBotB.Data(:,:,timeIndex);
    rCentroid4 = tsc.rCentroidSlant.Data(:,:,timeIndex);
    rCentroid5 = tsc.rCentroidSide.Data(:,:,timeIndex);
    rCentroid6 = tsc.rCentroidBotA.Data(:,:,timeIndex);
    rCentroid7 = tsc.rCentroidBotB.Data(:,:,timeIndex);
    rCentroid8 = tsc.rCentroidSlant.Data(:,:,timeIndex);
    rCentroid9 = tsc.rCentroidSide.Data(:,:,timeIndex);

    rCentroid = [rCentroid1,rCentroid2,rCentroid3,rCentroid4,rCentroid5,...
             rCentroid6,rCentroid7,rCentroid8,rCentroid9];
    
    uCentroid1 = tsc.uCentroidSide.Data(:,:,timeIndex);
    uCentroid2 = tsc.uCentroidBotA.Data(:,:,timeIndex);
    uCentroid3 = tsc.uCentroidBotB.Data(:,:,timeIndex);
    uCentroid4 = tsc.uCentroidSlant.Data(:,:,timeIndex);
    uCentroid5 = tsc.uCentroidSide.Data(:,:,timeIndex);
    uCentroid6 = tsc.uCentroidBotA.Data(:,:,timeIndex);
    uCentroid7 = tsc.uCentroidBotB.Data(:,:,timeIndex);
    uCentroid8 = tsc.uCentroidSlant.Data(:,:,timeIndex);
    uCentroid9 = tsc.uCentroidSlant.Data(:,:,timeIndex);

    uCentroid = [uCentroid1,uCentroid2,uCentroid3,uCentroid4,uCentroid5,...
             uCentroid6,uCentroid7,uCentroid8,uCentroid9];
         
    for ii = 1:9
        inputBus(ii).insideGlassVec = rCentroid(ii); 
        inputBus(ii).unitVec = uCentroid(ii);
    end

    bodyFixedVec = [snells(1).bodyFixedVec,snells(2).bodyFixedVec,snells(3).bodyFixedVec,...
                snells(4).bodyFixedVec,snells(5).bodyFixedVec,snells(6).bodyFixedVec,...
                snells(7).bodyFixedVec,snells(8).bodyFixedVec,snells(9).bodyFixedVec];

    initEulerAng = params.initEulerAng_deg.Value';

    tic
    [CoMPos,EulAng_rad] = powellsMethodMin(initEulerAng,inputBus,snells);
    time(index) = toc
    
    CoMPos
    EulAng{index,1} = EulAng_rad.*180/pi;
    EulerAngles = EulAng{index,1}
    
%     if strcmp(lineSearch,'ThreePoint')
%         EulAng{index,1} = mod(EulAng{index,1},360);
%     end
    
    roll_rad = tsc.roll_rad.Data(timeIndex);
    pitch_rad = tsc.pitch_rad.Data(timeIndex);
    yaw_rad = tsc.yaw_rad.Data(timeIndex);
    actualAng_rad = [roll_rad ; pitch_rad ; yaw_rad];
    
    actualAng{index,1} = actualAng_rad.*180/pi;
    
    errorCoM{index,1} = abs(tsc.CoMPosVec_cm.Data(:,:,timeIndex) - CoMPos);
    errorEul{index,1} = abs(actualAng{index,1} - EulAng{index,1}); 
    
    index = index + 1;
end

try
    clf(fig_off);
catch
end
fig_off = powellsPlot(CoMPos, actualAng_rad, tsc, params, timeEnd, 1);

%%

% clc;clear;
loadParams;
% load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_22_May_2019_18_55_30.mat');
% load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_23_May_2019_11_20_54.mat');

load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_12_Jun_2019_11_07_53.mat')

initialCoMPositionVec_cm = params.initCoMPosVec_cm.Value';
initialEulerAngles_rad = [0 0 0]';

% timeStart = 4190;
% timeEnd = 4200;

timeStart = 800;
timeEnd = 800;
index = 1;

length = timeEnd - timeStart;

for timeIndex = timeStart:timeEnd

    rCentroidSide = tsc.rCentroidSide.Data(:,:,timeIndex);
    rCentroidBotA = tsc.rCentroidBotA.Data(:,:,timeIndex);
    rCentroidBotB = tsc.rCentroidBotB.Data(:,:,timeIndex);
    rCentroidSlant = tsc.rCentroidSlant.Data(:,:,timeIndex);

    uCentroidSide = tsc.uCentroidSide.Data(:,:,timeIndex);
    uCentroidBotA = tsc.uCentroidBotA.Data(:,:,timeIndex);
    uCentroidBotB = tsc.uCentroidBotB.Data(:,:,timeIndex);
    uCentroidSlant = tsc.uCentroidSlant.Data(:,:,timeIndex);
    
    tic
    sim('powellsMethodMin_th')
    time(index) = toc;
    
    index = index + 1;
end

CoMPos = CoMPos_th.Data'
EulAng_deg = EulAng_th.Data'

try
    clf(fig_off);
catch
end
fig_off = powellsPlot(CoMPos, EulAng_deg.*pi/180, tsc, params, timeEnd, 1);

% rSide = timeseries(rCentroidSide);
% rBotA = timeseries(rCentroidBotA);
% rBotB = timeseries(rCentroidBotB);
% rSlant = timeseries(rCentroidSlant);
% uSide = timeseries(uCentroidSide);
% uBotA = timeseries(uCentroidBotA);
% uBotB = timeseries(uCentroidBotB);
% uSlant = timeseries(uCentroidSlant);

%%

ang = EulAng{end,1};

powellsPlot(CoMPos, ang, tsc, params, timeEnd)

%%

% [CoMPos,EulAng] = gradientDescentMin(x0,CoMPos,rCentroidSide,rCentroidBotA,...
%     rCentroidBotB,rCentroidSlant,uCentroidSide,...
%     uCentroidBotA,uCentroidBotB,uCentroidSlant,...
%     sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);
% 
% CoMPos
% EulAng = EulAng.*180/pi

%%

% yPos = 0;
% zPos = 0;
% roll = 0;
% pitch = 0;
% yaw = 0;
% 
% indX = 1;
% indY = 1;
% indZ = 1;
% indRoll = 1;
% indPitch = 1;
% indYaw = 1;
% 
% gran = 20;
% J = zeros(gran^6,1);
% SixDoF = cell(gran^6,1);
% 
% % objJ(x,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,rCentroidSlant,...
% %     uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
% %     sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm)
% 
% for xPos = linspace(-100,100,gran)
% %     CoMPos = [xPos;yPos;zPos];
% %     eulAng = [roll;pitch;yaw];
% %     J(indX,1) = objJ(eulAng,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,rCentroidSlant,...
% %         uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
% %         sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);
% %     indX = indX + 1;
%     
%     for yPos = linspace(-100,100,gran)
% %         CoMPos = [xPos;yPos;zPos];
% %         eulAng = [roll;pitch;yaw];
% %         J(indY,2) = objJ(eulAng,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,rCentroidSlant,...
% %             uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
% %             sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);
% %         indY = indY + 1;
%         
%         for zPos = linspace(-100,100,gran)
% %             CoMPos = [xPos;yPos;zPos];
% %             eulAng = [roll;pitch;yaw];
% %             J(indZ,3) = objJ(eulAng,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,rCentroidSlant,...
% %                 uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
% %                 sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);
% %             indZ = indZ + 1;
%             
%             for roll = linspace(-pi/2,pi/2,gran)
% %                 CoMPos = [xPos;yPos;zPos];
% %                 eulAng = [roll;pitch;yaw];
% %                 J(indRoll,4) = objJ(eulAng,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,rCentroidSlant,...
% %                     uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
% %                     sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);
% %                 indRoll = indRoll + 1;
%                 
%                 for pitch = linspace(-pi/2,pi/2,gran)
% %                     CoMPos = [xPos;yPos;zPos];
% %                     eulAng = [roll;pitch;yaw];
% %                     J(indPitch,5) = objJ(eulAng,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,rCentroidSlant,...
% %                         uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
% %                         sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);
% %                     indPitch = indPitch + 1;
%                     
%                     for yaw = linspace(-pi/2,pi/2,gran)
%                         CoMPos = [xPos;yPos;zPos];
%                         eulAng = [roll;pitch;yaw];
%                         J(indYaw) = objJ(eulAng,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,rCentroidSlant,...
%                             uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
%                             sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);
%                         SixDoF{indYaw} = [CoMPos;eulAng];  
%                         indYaw = indYaw + 1;
%                         
%                     end
%                 end
%             end
%         end
%     end
% end
% 
% [minJ,indJ] = min(J(:));
% DoF = SixDoF{indJ}
