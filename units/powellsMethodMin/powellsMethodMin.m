function [CoMPos,EulerAng] = powellsMethodMin(initEulerAng,inputBus,snells)

%powellsMethodMin Summary of this function goes here
%   Detailed explanation goes here

% x0 = [0 0 0]';
% x = [roll pitch yaw]

% J = objJ(x0,rCentroidSide,rCentroidBotA,rCentroidBotB,...
%     rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
%     sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);

% minFcn = @(s,x) objJ(updateLaw(s,x,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
%     rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
%     sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm),CoMPos,rCentroidSide,rCentroidBotA,...
%     rCentroidBotB,rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
%     sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);

dsgnVec = zeros(100,6);

posConv = 0.1;
angConv = 0.1;

rCentroid = zeros(3,3);
uCentroid = zeros(3,3);
bodyFixedVec = zeros(3,3);

for ii = 1:3
    rCentroid(:,ii) = inputBus(ii).insideGlassVec(:);
    uCentroid(:,ii) = inputBus(ii).unitVec(:);
    bodyFixedVec(:,ii) = snells(ii).bodyFixedVec(:);
end

EulerAng = initEulerAng;
for ii = 1:100
    RGB = calculateRotationMatrix(EulerAng(1),EulerAng(2),EulerAng(3));
    RBG = RGB';
    
    CoMPos = snellLeastSquaresPosition(rCentroid,uCentroid,RBG,bodyFixedVec);

    EulerAng = powellsMethod(EulerAng,CoMPos,rCentroid,uCentroid,bodyFixedVec);
   
    dsgnVec(ii,:) = [CoMPos(:)' EulerAng(:)'*180/pi];
    
    if ii>2 && ...
            all(abs(dsgnVec(end,1:3)-dsgnVec(end-1,1:3)) < posConv) && ...
            all(abs(dsgnVec(end,4:6)-dsgnVec(end-1,4:6)) < angConv)
       break 
    end

end

end

