clc;clear;
loadParams;
load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_22_May_2019_18_55_30.mat');
% load('C:\Users\mcobb\Google Drive\Mitchell-Research\NCSUWaterChannelControl\output\data\data_22_May_2019_18_55_30.mat');
format compact
x0 = [0 0 0]';

timeIndex = 3232;

timeStart = 4200;
timeEnd = 4200;

length = timeEnd - timeStart;

EulAng = cell(length,1);
actualAng = cell(length,1);
errorCoM = cell(length,1);
errorEul = cell(length,1);
index = 1;

% lineSearch = 'GoldenSection';

for timeIndex = timeStart:timeEnd

    rCentroidSide = tsc.rCentroidSide.Data(:,:,timeIndex);
    rCentroidBotA = tsc.rCentroidBotA.Data(:,:,timeIndex);
    rCentroidBotB = tsc.rCentroidBotB.Data(:,:,timeIndex);
    rCentroidSlant = tsc.rCentroidSlant.Data(:,:,timeIndex);

    uCentroidSide = tsc.uCentroidSide.Data(:,:,timeIndex);
    uCentroidBotA = tsc.uCentroidBotA.Data(:,:,timeIndex);
    uCentroidBotB = tsc.uCentroidBotB.Data(:,:,timeIndex);
    uCentroidSlant = tsc.uCentroidSlant.Data(:,:,timeIndex);

    sideDotPosVec_cm = params.sideDotPosVec_cm.Value';
    botADotPosVec_cm = params.botADotPosVec_cm.Value';
    botBDotPosVec_cm = params.botBDotPosVec_cm.Value';

    CoMPos = params.initCoMPosVec_cm.Value';

    tic
    [CoMPos,EulAng_rad] = powellsMethodMin(x0,CoMPos,rCentroidSide,...
        rCentroidBotA,rCentroidBotB,rCentroidSlant,uCentroidSide,...
        uCentroidBotA,uCentroidBotB,uCentroidSlant,...
        sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);
    toc
    
    CoMPos;
    EulAng{index,1} = EulAng_rad.*180/pi;
    EulAng{1,1};
    
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

%%

clc;clear;
loadParams;
load('C:\Users\MAE-NCSUCORE\Desktop\WaterChannelControl\output\data\data_22_May_2019_18_55_30.mat');

initialCoMPositionVec_cm = params.initCoMPosVec_cm.Value';
initialEulerAngles_rad = [0 0 0]';

timeStart = 4190;
timeEnd = 4200;
index = 1;

length = timeEnd - timeStart;

for timeIndex = timeStart:timeEnd

    rCentroidSide(index,:) = tsc.rCentroidSide.Data(:,:,timeIndex);
    rCentroidBotA(index,:) = tsc.rCentroidBotA.Data(:,:,timeIndex);
    rCentroidBotB(index,:) = tsc.rCentroidBotB.Data(:,:,timeIndex);
    rCentroidSlant(index,:) = tsc.rCentroidSlant.Data(:,:,timeIndex);

    uCentroidSide(index,:) = tsc.uCentroidSide.Data(:,:,timeIndex);
    uCentroidBotA(index,:) = tsc.uCentroidBotA.Data(:,:,timeIndex);
    uCentroidBotB(index,:) = tsc.uCentroidBotB.Data(:,:,timeIndex);
    uCentroidSlant(index,:) = tsc.uCentroidSlant.Data(:,:,timeIndex);
    
    index = index + 1;
end

rSide = timeseries(rCentroidSide);
rBotA = timeseries(rCentroidBotA);
rBotB = timeseries(rCentroidBotB);
rSlant = timeseries(rCentroidSlant);
uSide = timeseries(uCentroidSide);
uBotA = timeseries(uCentroidBotA);
uBotB = timeseries(uCentroidBotB);
uSlant = timeseries(uCentroidSlant);

tic
sim('powellsMethodMin_th')
toc

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
