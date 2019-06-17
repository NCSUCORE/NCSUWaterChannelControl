function [CoMPos,EulAng] = gradientDescentMin(x0,CoMPos,rCentroidSide,rCentroidBotA,...
    rCentroidBotB,rCentroidSlant,uCentroidSide,...
    uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm)

%gradientDescentMin Summary of this function goes here
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

for ii = 1:100
    RGB = calculateRotationMatrix(x0(1),x0(2),x0(3));
    RBG = RGB';
    
    CoMPos = snellLeastSquaresPosition(rCentroidSide,rCentroidBotA,...
        rCentroidBotB,rCentroidSlant,uCentroidSide,...
        uCentroidBotA,uCentroidBotB,uCentroidSlant,RBG,...
        sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);
   
    s0 = 1;
    for jj = 1:100
        sLims = goldenSection(s0,x0,CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
            rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
            sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm,0.1,'FunctionHandle',@minFcn);
        sStar = mean(sLims);
        xStar = updateLaw(sStar,x0,CoMPos,rCentroidSide,rCentroidBotA,...
            rCentroidBotB,rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,...
            uCentroidSlant,sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);
        x0 = xStar;
    end
end

EulAng = x0;

end
