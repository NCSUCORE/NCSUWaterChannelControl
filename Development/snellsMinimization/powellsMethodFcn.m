function [min] = powellsMethodFcn(alpha,x,S,CoMPos,rCentroidSide,rCentroidBotA,...
    rCentroidBotB,rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,...
    uCentroidSlant,sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm)

%powellsMethodFcn Summary of this function goes here
%   Detailed explanation goes here

% x = (x + alpha*S);

min = objJ((x + alpha*S)',CoMPos,rCentroidSide,rCentroidBotA,rCentroidBotB,...
    rCentroidSlant,uCentroidSide,uCentroidBotA,uCentroidBotB,uCentroidSlant,...
    sideDotPosVec_cm,botADotPosVec_cm,botBDotPosVec_cm);

end

