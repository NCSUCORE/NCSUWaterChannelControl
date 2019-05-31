function [outputArg1] = snellsMinimization(x0,rCentroidSide,rCentroidBotA,...
    rCentroidBotB,rCentroidSlant,uCentroidSide,...
    uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm, botADotPosVec_cm, botBDotPosVec_cm)

%SNELLSMINIMIZATION Summary of this function goes here
%   Detailed explanation goes here

% x0 = [0 0 0 0 0 0]';
RGB = calculateRotationMatrix(x0(4:6));
RBG = RGB';

updateLaw = @(s) x_0 - gradObjJ(x)*s;

for ii = 1:1000
    CoMPos = snellLeastSquaresPosition(rCentroidSide,rCentroidBotA,...
    rCentroidBotB,rCentroidSlant,uCentroidSide,...
    uCentroidBotA,uCentroidBotB,uCentroidSlant,RBG,...
    sideDotPosVec_cm, botADotPosVec_cm, botBDotPosVec_cm);
    
    x0 = [CoMPos 0 0 0];
    s0 = 1;
    for jj = 1:100
        [xLeft, xRight] = bound(s0, 0.1, 'FunctionHandle', updateLaw);
        xLims = goldenSection(s0, 0.01, 'FunctionHandle', updateLaw);
        s_star = mean(xLims);
        s0 = s_star;
    end
end

% xOut = BFGS(x0);

end

